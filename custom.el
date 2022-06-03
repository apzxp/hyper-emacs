(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(avy markdown-mode auctex company vertico))
 '(tool-bar-mode nil))
 ;; '(initial-buffer-choice 'recentf-open-files))

;; Fonts
(cond
 ((string-equal system-type "windows-nt") ;;Microsoft Windows
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas-14" t t)
    )
  )
 ((string-equal system-type "darwin") ;;MacOS
  (if (member "Unifont" (font-family-list))
      (progn
        (set-frame-font "Unifont-14" t t)
        (require 'pragmatapro-lig))
   (set-frame-font "Monaco-14" t t))
  )
 ((string-equal system-type "gnu/linux") ;; Linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono-14" t t)
    )
  )
 )
