(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#70917e" :background "#041818"))))
 '(custom-group-tag-face ((t (:underline t :foreground "#2e7841"))) t)
 '(custom-variable-tag-face ((t (:underline t :foreground "#2e7841"))) t)
 '(font-lock-builtin-face ((t nil)))
                                        ; '(font-lock-comment-face ((t (:foreground "yellow"))))
 '(font-lock-comment-face ((t (:foreground "#1f592e"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "#355241")))) 
 '(font-lock-keyword-face ((t (:foreground "#516b5c" ))))
                                        ; '(font-lock-string-face ((t (:foreground "gray160" :background "gray16"))))
 '(font-lock-string-face ((t (:foreground "#31573f"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#70917e"))))  
                                        ; '(font-lock-warning-face ((t (:foreground "#695a46"))))
 '(font-lock-warning-face ((t (:foreground "#504038"))))
 
 '(highlight ((t (:foreground "sea green") :background "dark olive green"))))
'(mode-line ((t (:inverse-video t))))
'(widget-field-face ((t (:foreground "#70917e"))) t)
'(widget-single-line-field-face ((t (:background "darkgray"))) t)

(global-font-lock-mode 1)
(set-cursor-color "#ff47f0")
(set-background-color "#041818")
(set-face-attribute 'region nil :background "dark goldenrod" :foreground "maroon")

(set-face-foreground 'font-lock-type-face "#7c9185")
(set-face-foreground 'font-lock-constant-face "#70917e")
(set-face-foreground 'font-lock-builtin-face         "#41634f")
