(require 'package)
;(require 'agda2)
(require 'tls)
;(require 'nix-docbook-mode)

;;(setq package-archives
;;      '(
;;;        ("geiser"    . "http://gnu.mirrors.pair.com/savannah/savannah/geiser/packages/")
;;;        ("haxney"    . "http://dl.dropbox.com/u/19422084/elpa-haxney/")
;;;        ("marmalade" . "http://marmalade-repo.org/packages/")
;;        ("melpa"     . "http://melpa.milkbox.net/packages/")
;;        ("gnu"       . "http://elpa.gnu.org/packages/")))
;;;; Refresh the packages descriptions
;;(package-initialize)
;;(unless package-archive-contents
;;  (package-refresh-contents))
;;;; List of packages to load
;;(setq package-load-list '(all))
;;;; List of packages to install
;;(mapc (lambda (x) (unless (package-installed-p x)
;;                    (package-install x)))
;;      '(
;;        ;fasm-mode
;;        iasm-mode
;;
;;        haskell-mode
;;
;;        nix-mode
;;
;;        rust-mode
;;
;;        scala-mode
;;        sbt-mode
;;
;;        tuareg
;;        dirtree
;;       ))

(setq rust-indent-offset 2)

(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key [f9]  'count-words)
(global-set-key [f10] 'whitespace-cleanup)
(global-set-key [f11] 'align-regexp)
(global-set-key [f12] 'compile)

(setq latex-run-command "xelatex")

(column-number-mode)

(load-file "~/.emacs.d/rtf-mode.el")
;;(require 'dirtree)


;; Assembly, Nasm
(autoload 'nasm-mode "~/.emacs.d/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|inc\\)$" . nasm-mode))
(setq nasm-basic-offset 4)
;(add-to-list 'align-rules-list
; '(nasm
;   (regexp . "\\(\\S-+\\)")
;   (modes nasm-mode)
;   (tab-stop)
;   (repeat . t)
;   (group . 2)))

;; C programming langauge
(setq c-default-style "linux"
      c-basic-offset 2)

;; Racket
(add-to-list 'auto-mode-alist '("\\.rkt$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.scrbl$" . scheme-mode))
(add-to-list 'magic-mode-alist '("#lang racket" . scheme-mode))

;; haskell
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

;(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
;(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

;;; IDO mode
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

;; Laptop-specific

;; pyret
(ignore-errors
  (add-to-list 'load-path (expand-file-name "~/Code/git/pyret-lang/tools/emacs/"))
  (require 'pyret)
  (add-to-list 'auto-mode-alist '("\\.arr$" . pyret-mode))
  (add-to-list 'magic-mode-alist '("#lang pyret" . pyret-mode))
  (add-to-list 'magic-mode-alist (cons "#lang bootstrap" '(lambda () (pyret-mode) (bootstrap-mode))))
  (add-to-list 'file-coding-system-alist '("\\.arr\\'" . utf-8-unix)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)

(setq sonarpulse-keys '("/home/john/.ssl/Sonarpulse.key"
                        "/home/john/.ssl/Sonarpulse.cert"))

(defun erc-open-tls-stream-with-certificate (name buffer host service)
  (open-network-stream name buffer host service
                       :type 'tls
                       :client-certificate sonarpulse-keys))

;HACK
(defun open-gnutls-stream (name buffer host service)
  (gnutls-negotiate :process (open-network-stream name buffer host service)
                    :type 'gnutls-x509pki
                    :hostname host
                    :keylist `(,sonarpulse-keys)))


;(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof -cert /home/john/.ssl/Sonarpulse.pem"
;                    "gnutls-cli --priority secure256 --x509certfile ~/.ssl/Sonarpulse.pem -p %p %h"
;                    "gnutls-cli --priority secure256 -p %p %h"))
;                                     -CAfile /home/ootput/.private/certs/CAs.pem
;                               --x509cafile /home/ootput/.private/certs/CAs.pem

(setq erc-autojoin-channels-alist '(("mozilla.com" "#rust-osdev" "#rust-internals" "#cargo")))

(defun erc-freenode ()
   "Connect to IRC."
   (interactive)
   (erc-tls :server "irc.freenode.net" :port 6697
            :nick "Sonarpulse" :full-name "John Ericson"))

(defun erc-mozilla ()
   "Connect to IRC."
   (interactive)
   (erc :server "irc.mozilla.com" :port 6667
        :nick "Ericson2314" :full-name "John Ericson"))

; From Emacs Wiki
(make-variable-buffer-local 'erc-fill-column)
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (save-excursion
               (walk-windows
                (lambda (w)
                  (let ((buffer (window-buffer w)))
                    (set-buffer buffer)
                    (when (eq major-mode 'erc-mode)
                      (setq erc-fill-column (- (window-width w) 2)))))))))

(defun protect-window ()
   "make unsplittable"
   (interactive)
   (set-frame-parameter nil 'unsplittable t)
   (set-window-dedicated-p (selected-window) t))

;;(require 'oneonone)
;;
;;(remove-hook 'same-window-regexps "\\*info\\*\\(\\|<[0-9]+>\\)")
;;(remove-hook 'same-window-regexps "\\`\\*Customiz.*\\*\\'")
;;
;;(define-key minibuffer-local-map "\C-o"
;;  '1on1-fit-minibuffer-frame)
;;(define-key minibuffer-local-must-match-map "\C-o"
;;  '1on1-fit-minibuffer-frame)
;;(define-key minibuffer-local-completion-map "\C-o"
;;  '1on1-fit-minibuffer-frame)
;;
;;(1on1-emacs)
(put 'upcase-region 'disabled nil)

(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))
