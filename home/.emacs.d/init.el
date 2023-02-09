;
; Gnu emacs customization for Matt Mathis
;	(Almost virgin!)
;

; Make sure that the google stuff loaded
(require 'google)

; Don't use tabs at all, they confuse too many tools
(setq indent-tab-mode nil)

; replaces find-alternate-file
(global-set-key "\C-X\C-v" 'find-file-other-window)

; not used
(global-set-key "\C-X " 'goto-line)

; not used
(global-set-key "\M-j" 'fill-paragraph)

; replaces suspend
(global-set-key "\C-z" 'undo)

; Permit lisp from the prompt
(put 'eval-expression 'disabled nil)

; Google style indentation
(setq c-mode-common-hook
      (list
	(setq-default indent-tabs-mode t)
	(setq c-basic-offset 8)
      )
)

; Google p4 support
; (load-file "lib/google.el")
(setq p4-use-p4config-exclusively t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(google-tabs-modes
   '(cc-mode c++-mode java-mode jde-mode python-mode emacs-lisp-mode borg-mode ess-mode markdown-mode objc-mode typescript-mode SQL Shell-script)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
