;;; Personal configuration -*- lexical-binding: t -*-

;; Save the contents of this file under ~/.emacs.d/init.el
;; Do not forget to use Emacs' built-in help system:
;; Use C-h C-h to get an overview of all help commands.  All you
;; need to know about Emacs (what commands exist, what functions do,
;; what variables specify), the help system can provide.

;; Load local-packages directory
(add-to-list 'load-path "~/.emacs.d/local-packages/")
(add-to-list 'load-path "~/.emacs.d/local-packages/avy")

;; Add the NonGNU ELPA package archive
(require 'package)
(add-to-list 'package-archives  '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

;; Set initial frame parameters
(setq initial-frame-alist
      '(
        ;; Center initial Emacs frame
        (left . 0.5)
        (top . 0.5)
        ))

;; default/subsequent frame parameters
;; (setq default-frame-alist
;;       '(
;;         (width . 85) ;; character
;;         (height . 45) ;; lines
;;         ))

;; Load a custom theme
(load-theme 'leuven t)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bars
(scroll-bar-mode -1)

;; Disable splash screen
(setq inhibit-startup-screen t)

;; Transparent Title Bar (at least on MacOS)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

;; Add visual-fill-column package (local) - wraps lines at fill-column, if fill-column is too large for the window, the text is wrapped at the window edge.
(require 'visual-fill-column)

;; Add visual-fill-column to visual-line-mode hook
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)

;; Set the width of the buffer to n columns
(setq-default fill-column 90)

;; Set fringe to 20px
(fringe-mode 16)

;; Center wrapped text in window
(setq-default visual-fill-column-center-text t)

;; Add visual-line mode to multiple hooks
(dolist (hook '(prog-mode-hook org-mode-hook markdown-mode-hook recentf-dialog-mode-hook))
  (add-hook hook #'visual-line-mode))

;;; Completion framework
(unless (package-installed-p 'vertico)
  (package-install 'vertico))

;; Enable completion by narrowing
(vertico-mode t)

;; Define global goto-address-mode (make links in buffer
(define-globalized-minor-mode global-goto-address-mode goto-address-mode
  (lambda () (goto-address-mode 1)))

;; Turn on globalized minor mode
(global-goto-address-mode 1)

;; Enable line numbering in prog-mode
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Automatically pair parentheses
(electric-pair-mode t)

;;; Pop-up auto-completion
(unless (package-installed-p 'company)
  (package-install 'company))

;; Enable Company by default in programming buffers
(add-hook 'prog-mode-hook #'company-mode)

;;; LaTeX support
(unless (package-installed-p 'auctex)
  (package-install 'auctex))
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Enable LaTeX math support
(add-hook 'LaTeX-mode-map #'LaTeX-math-mode)

;; Enable reference mangment
(add-hook 'LaTeX-mode-map #'reftex-mode)

;; Markdown support
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;; Jump to arbitrary positions
(require 'avy)
(global-set-key (kbd "C-c z") #'avy-goto-word-1)

;; Use tabs instead of spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Miscellaneous options
(setq-default major-mode
              (lambda () ;; guess major mode from file name
                (unless buffer-file-name
                  (let ((buffer-file-name (buffer-name)))
                    (set-auto-mode)))))
(setq window-resize-pixelwise t) ;; resize windows by pixels - not by columns and rows
(setq frame-resize-pixelwise t) ;; resize frames by pixels - not by columns and rows
(delete-selection-mode t) ;; make selection "normal", e.g. replace selected region when you start typing and delete the whole region just by hitting Backspace
(save-place-mode t) ;; when you visit a file, cursor goes to the last place it was when you previously visited the same file
(savehist-mode t) ;; save minibuffer history
(recentf-mode t) ;; save recent files list

(setq make-backup-files nil) ;; turn off ~ - ~ files
(setq auto-save-default nil) ;; turnf off #-# files
(defalias 'yes-or-no-p 'y-or-n-p) ;; use y/n instead of yes/no
;; (global-hl-line-mode t) ;; highlight current line


;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
