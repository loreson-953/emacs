(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9b21c848d09ba7df8af217438797336ac99cbbbc87a08dc879e9291673a6a631" "45631691477ddee3df12013e718689dafa607771e7fd37ebc6c6eb9529a8ede5" "6b9d569b61d04cca3bf20a75fe36157fb98add6e690e087aa19b469bd5b1949e" "95ee4d370f4b66ff2287d8075f8fe5f58c4a9b9c1e65d663b15174f1a8c57717" "fc1275617f9c8d1c8351df9667d750a8e3da2658077cfdda2ca281a2ebc914e0" default))
 '(package-selected-packages
   '(gruvbox-light-soft gruvbox-light-soft-theme auctex dashboard lsp-ui flycheck company ccls)))


;;Main
(setq inhibit-startup-message t) ;; Startup
(scroll-bar-mode -1) ;; Get rid of that fuckass scrollbar
(tool-bar-mode -1) ;; Get rid of that fuckass tooblar
(tooltip-mode -1)
(set-fringe-mode 10) ;; Idk look it up later bruh
(menu-bar-mode -1) ;; Get rid of that fuckass menu
(set-face-attribute 'default nil :font "mononoki" :height 200)
(global-hl-line-mode +1)
;; (set-face-background 'hl-line "#1e1b29")
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(set-face-attribute 'mode-line nil :height 200)

;; Themeing
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-light-soft t))

;;(use-package masked-theme
;;  :ensure t
;;  :config
;;  (load-theme 'masked t))


;; housekeeping (in lucke's words)
(setq make-backup-files nil)                                                            ;; disable ~ files
(setq auto-save-default nil)                                                            ;; disable #autosave#
(setq create-lockfiles nil)

;;Indentation
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq c-basic-offset tab-width)
(setq-default electric-indent-inhibit t)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'nil)

;;Melpa (my beloved...)
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;LSP
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.08))

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :hook ((c-mode c++-mode objc-mode) . lsp)
  :init
  ;;(setq lsp-keymap-prefix "C-c l")  ;; optional key prefix
  :config
  (setq lsp-enable-on-type-formatting nil
        lsp-prefer-flymake nil))     ;; use flycheck if available

(use-package ccls
  :after lsp-mode
  :config
  ;; If ccls is not on PATH, set the path explicitly:
  (setq ccls-executable "~/.emacs.d/elpa/ccls-20250825.531")
  ;; Basic ccls settings:
  (setq ccls-sem-highlight-method 'font-lock)
  ;; Tell lsp-mode how to start ccls
  (setq lsp-clients-clangd-executable "clangd") ;; keep clangd default untouched
  )

;; Optional: nicer UI for LSP (peek, docs)
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.2
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t))

;; use-package with package.el:
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner 'official)
;; Value can be:
;;  - 'official which displays the official emacs logo.
;;  - 'logo which displays an alternative emacs logo.
;;  - an integer which displays one of the text banners
;;    (see dashboard-banners-directory files).
;;  - a string that specifies a path for a custom banner
;;    currently supported types are gif/image/text/xbm.
;;  - a cons of 2 strings which specifies the path of an image to use
;;    and other path of a text file to use if image isn't supported.
;;    (cons "path/to/image/file/image.png" "path/to/text/file/text.txt").
;;  - a list that can display an random banner,
;;    supported values are: string (filepath), 'official, 'logo and integers.

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
;; vertically center content
(setq dashboard-vertically-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)
(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)))

;; Hideshow
(use-package hideshow
  :hook (prog-mode . hs-minor-mode)
  :bind (:map hs-minor-mode-map
              ("C-c e" . hs-show-block)
              ("C-c d" . hs-hide-block)
              ("C-c @ C-s" . nil)
              ("C-c @ C-d" . nil)))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :init (use-package with-editor :ensure t))
			  

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
