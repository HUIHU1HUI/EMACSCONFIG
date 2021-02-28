(require 'package)
(package-initialize)
;;init shortcut
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package delight :ensure t)
(use-package use-package-ensure-system-package :ensure t)


;;if windowed no toolbar
(if window-system
    (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  )
;; (defun startup-layout ()
;;   (interactive)
;;   ;;(delete-other-windows)
;;   (next-multiframe-window)
;;   (shrink-window 10)
;;   (previous-multiframe-window)
;;   (split-window-horizontally)
;;   (next-multiframe-window)
;;   (enlarge-window ( - 20 (window-body-width)))
;;   (term "/bin/bash")
;;   (previous-multiframe-window)
;;   )
;; (startup-layout)

;; Start fullscreen (cross-platf)

(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
;;(delete-other-windows)
;;(desktop-save-mode 1)



(global-set-key (kbd "M-o") 'ace-window)

(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
 display-time-default-load-average nil            ; Don't display load average
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Prefers spaces over tabs
 ;;inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 kill-ring-max 128                                ; Maximum length of kill ring
 load-prefer-newer t                              ; Prefers the newest version of a file
 mark-ring-max 128                                ; Maximum length of mark ring
 read-process-output-max (* 1024 1024)            ; Increase the amount of data reads from the process
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 tab-width 4                                      ; Set width for tabs
 use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
 user-full-name "Lucas Hui"               ; Set the full name of the current user
 user-mail-address "lucashui2398@gmail.com"  ; Set the email address of the current user
 vc-follow-symlinks t                             ; Always follow the symlinks
 view-read-only t)                                ; Always open read-only buffers in view-mode
(cd "~/")                                         ; Move to the user directory
(column-number-mode 1)                            ; Show the column number
(display-time-mode 1)                             ; Enable time in the mode-line
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-hl-line-mode)                             ; Hightlight current line
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(show-paren-mode 1)                               ; Show the parent

(use-package aggressive-indent
  :hook ((css-mode . aggressive-indent-mode)
         (emacs-lisp-mode . aggressive-indent-mode)
         (js-mode . aggressive-indent-mode)
         (lisp-mode . aggressive-indent-mode))
  :custom (aggressive-indent-comments-too))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;;THEMES

;;(load-theme 'zenburn t)
(use-package kaolin-themes
  :config
  (load-theme 'kaolin-light t)
  (kaolin-treemacs-theme))

(set-face-attribute 'default nil :font "Source Code Pro Medium")
(set-fontset-font t 'latin "Noto Sans")

(electric-pair-mode 1 )


;; (use-package tao-theme)
;; (load-theme 'tao-yang t)
;; (defun tao-palette () (tao-theme-golden-grayscale-yin-palette))
;; (tao-theme)
;; (tao-with-color-variables tao-palette
;;                           (progn
;;                             (setq
;;                              hl-paren-colors (list color-14 color-11 color-9 color-7 color-6)
;;                              hl-paren-background-colors (list color-4 color-4 color-4 color-4 color-4))))


(use-package lsp-mode
  :hook ((c-mode c++-mode dart-mode java-mode json-mode python-mode typescript-mode xml-mode) . lsp)
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/dev/stderr"))
  (lsp-enable-folding nil)
  (lsp-enable-links nil)
  (lsp-enable-snippet nil)
  (lsp-prefer-flymake nil)
  (lsp-session-file (expand-file-name (format "%s/emacs/lsp-session-v1" xdg-data)))
  (lsp-restart 'auto-restart))

(use-package lsp-ui)

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))


(use-package company
  :defer 0.5
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :delight
  :hook (company-mode . company-box-mode))

;;languages

(use-package ccls
  :after projectile
  :ensure-system-package ccls
  :custom
  (ccls-args nil)
  (ccls-executable (executable-find "ccls"))
  (projectile-project-root-files-top-down-recurring
   (append '("compile_commands.json" ".ccls")
           projectile-project-root-files-top-down-recurring))
  :config (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

(use-package google-c-style
  :hook (((c-mode c++-mode) . google-set-c-style)
         (c-mode-common . google-make-newline-indent)))

(use-package prettier-js
  :delight
  :custom (prettier-js-args '("--print-width" "100"
                              "--single-quote" "true"
                              "--trailing-comma" "all")))


;;CMAKE
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))

(use-package cmake-ide
  :after projectile
  :hook (c++-mode . my/cmake-ide-find-project)
  :preface
  (defun my/cmake-ide-find-project ()
    "Finds the directory of the project for cmake-ide."
    (with-eval-after-load 'projectile
      (setq cmake-ide-project-dir (projectile-project-root))
      (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
    (setq cmake-ide-compile-command
          (concat "cd " cmake-ide-build-dir " && cmake .. && make"))
    (cmake-ide-load-db))

  (defun my/switch-to-compilation-window ()
    "Switches to the *compilation* buffer after compilation."
    (other-window 1))
  :bind ([remap comment-region] . cmake-ide-compile)
  :init (cmake-ide-setup)
  :config (advice-add 'cmake-ide-compile :after #'my/switch-to-compilation-window))

(require 'windsize)
(windsize-default-keybindings)

;; (require 'flycheck)
;; (defun flycheckOnMode () (flycheck-mode t) )
;; (add-hook 'c++-mode 'flycheckOnMode)

(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  (if (display-graphic-p)
      (flycheck-pos-tip-mode)
    (flycheck-popup-tip-mode)))



;;(delete-other-windows)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(kaolin-light))
 '(custom-safe-themes
   '("a5d04a184d259f875e3aedbb6dbbe8cba82885d66cd3cf9482a5969f44f606c0" "6f895d86fb25fac5dd4fcce3aec0fe1d88cf3b3677db18a9607cf7a3ef474f02" "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "98db748f133d9bb82adf38f8ae7834eefa9eefd6f7ea30909213164e1aa36df6" "7236acec527d58086ad2f1be6a904facc9ca8bf81ed1c19098012d596201b3f1" "b9e406b52f60a61c969f203958f406fed50b5db5ac16c127b86bbddd9d8444f7" "7e5d400035eea68343be6830f3de7b8ce5e75f7ac7b8337b5df492d023ee8483" "4e9e56ec06ede9857c876fea2c44b75dd360cd29a7fe927b706c45f804f7beff" "8f54cfa3f010d83d782fbcdc3a34cdc9dfe23c8515d87ba22d410c033160ad7e" "620b9018d9504f79344c8ef3983ea4e83d209b46920f425240889d582be35881" "0c6a36393d5782839b88e4bf932f20155cb4321242ce75dc587b4f564cb63d90" "e58e0bd0ca1f1a8c1662aeb17c92b7fb49ed564aced96435c64df608ee6ced6d" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(fci-rule-color "#383838")
 '(initial-buffer-choice nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(flycheck-pos-tip popup flycheck all-the-icons tao-theme kaolin-themes rainbow-delimiters aggressive-indent zenburn-theme use-package-ensure-system-package rust-mode prettier-js lsp-ui google-c-style delight dap-mode company-box cmake-ide cmake-font-lock ccls))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#16211C")
 '(pos-tip-foreground-color "#dcded9")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
