;; Use MELPA repository
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

;; Install use-package if needed
(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

;; Initialize use-package to automatically download packages
(eval-when-compile
  (require 'use-package))

;; ----
;; use-package dependencies
;; ----
(use-package auto-complete-config
  :ensure auto-complete
  :init
  (setq flyspell-issue-message-flag ())
  :config
  (global-auto-complete-mode t)
  (ac-config-default)
  (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
  (ac-flyspell-workaround))

(use-package latex
  :ensure auctex
  :init
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-parse-self t) ; Enable parse on load.
  (setq TeX-auto-save t) ; Enable parse on save.
  :hook (
		 (LaTeX-mode . turn-on-reftex)
		 (LaTeX-mode . ac-mode-latex-setup)
		 (LaTeX-mode . (reftex-mode t))
		 (LaTeX-mode . flyspell-mode)
		 (LaTeX-mode . flyspell-buffer)))

(use-package auctex-latexmk
  :ensure t
  :init
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  :config (auctex-latexmk-setup))

(use-package langtool
  :ensure t
  :init
  (setq langtool-language-tool-server-jar "~/Desktop/Programs/LanguageTool-4.2/languagetool-server.jar"
		langtool-server-user-arguments '("-p" "8082")
		langtool-default-language "en-US"
		langtool-mother-tongue "en-US")
  :bind (
		 ([f4] . langtool-check)
		 ([f5] . langtool-correct-buffer)
		 ("\C-x4W" . langtool-check-done)
		 ("\C-x4l" . langtool-switch-default-language)
		 ("\C-x44" . langtool-show-message-at-point)))

(use-package magit
  :ensure t)
(use-package magit-todos
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package neotree
  :ensure t
  :bind ([f12] . neotree-toggle))

(use-package powerline
  :ensure t
  :init
  (setq powerline-arrow-shape 'arrow)
  :config 
  (powerline-default-theme))
