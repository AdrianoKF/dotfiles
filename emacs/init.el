(server-start)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex")
 '(TeX-source-correlate-method (quote auto))
 '(TeX-source-correlate-mode t)
 '(TeX-view-program-list
   (quote
	(("SumatraPDF"
	  ("SumatraPDF.exe -reuse-instance"
	   (mode-io-correlate " -forward-search \"%b\" %n")
	   " %o")))))
 '(TeX-view-program-selection
   (quote
	(((output-dvi style-pstricks)
	  "dvips and start")
	 (output-dvi "Yap")
	 (output-pdf "SumatraPDF")
	 (output-html "start"))))
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
	("bb749a38c5cb7d13b60fa7fc40db7eced3d00aa93654d150b9627cabd2d9b361" "a3f85ee6e877f02e239d2a6633a5b8263b53113751aca549aa4c5f458829c95d" default)))
 '(gradle-use-gradlew t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(cmake-mode yaml-mode ansible creamsody-theme auctex auctex-latexmk langtool org-pandoc org-iv org-beautify-theme org-ac markdown-mode groovy-mode gradle-mode ac-math)))
 '(pos-tip-background-color "#1A3734")
 '(pos-tip-foreground-color "#FFFFC8")
 '(preview-gs-command "C:/Program Files/gs/gs9.18/bin/gswin64c.exe")
 '(preview-image-type (quote pnm))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Keep backup files in separate directory
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; AucTeX setup
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

;; Auto-indentation by default
(electric-indent-mode 1)

;; Flyspell mode by default
; Work around Emacs64 builds with Cygwin hunspell - http://gromnitsky.blogspot.de/2016/09/emacs-251-hunspell.html
(setq ispell-program-name "c:/cygwin64/bin/hunspell.exe")
(setq ispell-hunspell-dict-paths-alist
      '(("de_DE" "C:/cygwin64/usr/share/myspell/de_DE.aff")
		("en_US" "C:/cygwin64/usr/share/myspell/en_US.aff")
        ("en_GB" "C:/cygwin64/usr/share/myspell/en_GB.aff")))

;; Set up LaTeX auto-completion
(require 'auto-complete)
(global-auto-complete-mode t)
(ac-config-default)

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))


; Turn on RefTeX for AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
(setq reftex-plug-into-AUCTeX t)

(add-hook 'LaTeX-mode-hook
		  (lambda ()
			'turn-on-reftex
			'ac-latex-mode-setup
			(reftex-mode t)
			(flyspell-mode t)
 ))

(ac-flyspell-workaround)

;; Enable auctex-latexmk mode
(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)

;; Use C-x f to open file under cursor
(global-set-key (kbd "C-x f") 'find-file-at-point)

(require 'langtool)
(setq langtool-language-tool-jar "~/Desktop/Programs/LanguageTool-3.5/languagetool-commandline.jar"
      langtool-mother-tongue "en-US"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))

;; Integrate RefTeX and cleveref
(eval-after-load
    "latex"
  '(TeX-add-style-hook
    "cleveref"
    (lambda ()
      (if (boundp 'reftex-ref-style-alist)
		  (add-to-list
		   'reftex-ref-style-alist
		   '("Cleveref" "cleveref"
			 (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
      (reftex-ref-style-activate "Cleveref")
      (TeX-add-symbols
       '("cref" TeX-arg-ref)
       '("Cref" TeX-arg-ref)
       '("cpageref" TeX-arg-ref)
       '("Cpageref" TeX-arg-ref)))))

