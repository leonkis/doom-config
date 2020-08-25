;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 22))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(defun org-sort-buffer ()
  "Sort all entries in the current buffer, recursively."
  (interactive)
  (org-map-entries (lambda ()
                     (condition-case x
                         (org-sort-entries nil ?a)
                       (user-error)))))

(map! :leader
      :desc "sortiraj mi bafere" "S" #'org-sort-buffer)



(setq evil-respect-visual-line-mode t)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook 'centered-cursor-mode)
(setq global-flycheck-mode nil)
(setq ccm-recenter-at-end-of-file t)

(map! :leader
      :desc "Terminal (ansi)" "o t"
      '(lambda ()
         (interactive)
         (progn
           (let ((name "terminal"))
             (evil-window-vsplit)
             (if (get-buffer name)
                 (switch-to-buffer name)
               (progn
                 (ansi-term "/bin/zsh")
                 (rename-buffer "terminal")))))))

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-off-auto-fill)

(map! :leader
      :desc "centered cursor mode" "e" #'centered-cursor-mode)

(defadvice! +latex-no-indent-on-fill-paragraph (orig-fn &rest args)
  :around #'fill-paragraph
  (let ((tex-indent-basic 0)
        (tex-indent-item 0)
        (tex-indent-arg 0)
        (TeX-brace-indent-level 0)
        (LaTeX-indent-level 0)
        (LaTeX-item-indent 0))
    (apply orig-fn args)))

(setq counsel-find-file-ignore-regexp (regexp-opt '("synctex")))

(map! :leader
      :desc "open dired marked files" "O" #'dired-do-find-marked-files)

(setq org-plain-list-ordered-item-terminator ?\))

;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)

(add-hook 'org-mode-hook 'visual-fill-column-mode)

(setq org-log-done 'time)
