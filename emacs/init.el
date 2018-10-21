(server-start)

;; Load packages from ~/.emacs.d/lisp
(add-to-list 'load-path "~/.emacs.d/lisp")

;; Automatically load everything under ~/.emacs.d/my-lisp
(require 'load-directory)
(load-directory "~/.emacs.d/my-lisp/")

;; Autoload themes directory
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; Use UTF-8 as default file encoding
(set-language-environment "UTF-8")

;; ISpell location (using Cygwin)
(setq ispell-program-name "c:/cygwin64/bin/aspell.exe")

;; fakecygpty for compatibility with Cygwin
;; See: https://github.com/d5884/fakecygpty
;; (require 'fakecygpty)
;; (fakecygpty-activate)
;; (setq fakecygpty-program "~/.emacs.d/bin/fakecygpty.exe")
;; (setq fakecygpty-qkill "~/.emacs.d/bin/qkill.exe")

;; Move between windows with Alt+<cursor>
(windmove-default-keybindings 'meta)

;; Powerline status bar
;; (require 'powerline)
;; (setq powerline-arrow-shape 'arrow)
;; (powerline-default-theme)

;; Neotree file navigator
;; (require 'neotree)
;; (global-set-key [f12] 'neotree-toggle)

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
	("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" "bb749a38c5cb7d13b60fa7fc40db7eced3d00aa93654d150b9627cabd2d9b361" "a3f85ee6e877f02e239d2a6633a5b8263b53113751aca549aa4c5f458829c95d" default)))
 '(debug-on-error t)
 '(gradle-use-gradlew t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(auto-complete-auctex use-package use-package-ensure-system-package magit magit-todos powerline neotree ox-pandoc pandoc pandoc-mode adoc-mode cmake-mode yaml-mode ansible creamsody-theme auctex auctex-latexmk langtool org-pandoc org-iv org-beautify-theme org-ac markdown-mode groovy-mode gradle-mode ac-math)))
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
 '(default ((t (:family "PragmataPro Mono" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))

;; Keep backup files in separate directory
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; AucTeX setup
;; (setq TeX-parse-self t) ; Enable parse on load.
;; (setq TeX-auto-save t) ; Enable parse on save.

;; Auto-indentation by default
(electric-indent-mode 1)

;; Flyspell mode by default
;; (setq flyspell-issue-message-flag ())
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; Set up LaTeX auto-completion
;; (require 'auto-complete)
;; (global-auto-complete-mode t)
;; (ac-config-default)

;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))


;; (add-hook 'LaTeX-mode-hook
;; 		  (lambda ()
;; 			'turn-on-reftex
;; 			'ac-latex-mode-setup
;; 			(reftex-mode t)
;;  ))

;; (ac-flyspell-workaround)

;; Enable auctex-latexmk mode
;; (require 'auctex-latexmk)
;; (auctex-latexmk-setup)
;; (setq auctex-latexmk-inherit-TeX-PDF-mode t)

;; Use C-x f to open file under cursor
(global-set-key (kbd "C-x f") 'find-file-at-point)

;; LanguageTool spell/grammar checking
;; (require 'langtool)
;; (global-set-key (kbd "<f4>") 'langtool-check)
;; (global-set-key (kbd "<f5>") 'langtool-correct-buffer)
;; (global-set-key "\C-x4W" 'langtool-check-done)
;; (global-set-key "\C-x4l" 'langtool-switch-default-language)
;; (global-set-key "\C-x44" 'langtool-show-message-at-point)

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


;; KOMA-Script export for org-mode
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
			   '("koma-article"
				 "\\documentclass{scrartcl}"
				 ("\\section{%s}" . "\\section*{%s}")
				 ("\\subsection{%s}" . "\\subsection*{%s}")
				 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
				 ("\\paragraph{%s}" . "\\paragraph*{%s}")
				 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )
