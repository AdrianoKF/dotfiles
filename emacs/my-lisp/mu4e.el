;; ----- mu4e email client -----

(require 'mu4e)

(setq mu4e-contexts
	  `( ,(make-mu4e-context
		   :name "UniA"
		   :match-func (lambda (msg) (when msg
									   (string-prefix-p "/UniA" (mu4e-message-field msg :maildir))))
		   :vars '(
				   (mu4e-trash-folder . "/UniA/Trash")
				   (mu4e-drafts-folder . "/UniA/Drafts")
				   (mu4e-sent-folder . "/UniA/Sent")
				   ))))


;; Bookmark for inbox
(add-to-list 'mu4e-bookmarks
       (make-mu4e-bookmark
        :name "UniA Inbox"
        :query "maildir:/UniA/INBOX"
        :key ?i))

;; Don't ask for a 'context' upon opening mu4e
(setq mu4e-context-policy 'pick-first)
;; Don't ask to quit... why is this the default?
(setq mu4e-confirm-quit nil)

;; Fix for correctly deleting mails with offlineimap
;; See http://cachestocaches.com/2017/3/complete-guide-email-emacs-using-mu-and-/#pitfalls-and-additional-tweaks
(defun remove-nth-element (nth list)
  (if (zerop nth) (cdr list)
    (let ((last (nthcdr (1- nth) list)))
      (setcdr last (cddr last))
      list)))
(setq mu4e-marks (remove-nth-element 5 mu4e-marks))
(add-to-list 'mu4e-marks
     '(trash
       :char ("d" . "▼")
       :prompt "dtrash"
       :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
       :action (lambda (docid msg target) 
                 (mu4e~proc-move docid
                    (mu4e~mark-check-target target) "-N"))))


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

;; Mode-line alerts for new mail
(require 'use-package)
(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query
    (concat
     "flag:unread maildir:/UniA/INBOX "
     ))
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
    (interactive)
    (mu4e~proc-kill)
    (mu4e-alert-enable-mode-line-display)
    )
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line)
  )
