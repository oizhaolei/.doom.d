;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lei Zhao"
      user-mail-address "oizhaolei@gmail.com")
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; (add-to-list 'load-path "/usr/local/Cellar/mu/1.6.11/share/emacs/site-lisp/mu/mu4e")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
                                        ; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(global-disable-mouse-mode)
(mapc #'disable-mouse-in-keymap
      (list evil-motion-state-map
            evil-normal-state-map
            evil-visual-state-map
            evil-insert-state-map))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; (setq-hook! 'html-mode-hook +format-with :none)
;; (setq-hook! 'yaml-mode-hook +format-with :none)
;; (setq-hook! 'xml-mode-hook +format-with :none)
;; (setq-hook! 'nxml-mode-hook +format-with :none)
;; winner-mode
(global-set-key (kbd "C-<") 'winner-undo)
(global-set-key (kbd "C->") 'winner-redo)


(defun my/kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (kill-buffer buffer)))

(defun my/today ()
  "Output current date."
  (interactive)
  (insert (format-time-string "%Y-%m-%d"))
  )

(defun my/js-if-region ()
  "Write if of curent region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "if (%s) {}" myRegion))))

(defun my/intl-region ()
  "Write if of curent region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (kill-region (region-beginning) (region-end))
    (insert (format "{intl.formatMessage({ id: 'name', defaultMessage: '%s' })}" myRegion))))

(defun my/js-console-log-region ()
  "Write console.log of current region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "console.log('%s:', %s);" myRegion myRegion))))


(defun my/python-print-region ()
  "Write console.log of current region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "print(\"%s: \", %s)" myRegion myRegion))))

(defun my/rust-debug-region ()
  "Write console.log of current region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "println!(\"%s: {:?}\", %s);" myRegion myRegion))))


(defun my/rust-println-region ()
  "Write console.log of current region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "println!(\"%s: {}\", %s);" myRegion myRegion))))


(defun my/js-logger-region ()
  "Write login.info of current region to new line."
  (interactive)
  (let (myRegion)
    (if (use-region-p)
        (setq myRegion (buffer-substring (region-beginning) (region-end)))
      (setq myRegion (thing-at-point 'word))
      )
    (end-of-line)
    (newline-and-indent)
    (insert (format "logger.info('%s:', %s);" myRegion myRegion))))

(defun my/numberic-increase-region ()
  "Increase current region or point."
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))
(global-set-key (kbd "M-C-]") 'my/numberic-increase-region)

(defun my/numberic-decrease-region ()
  "Increase current region or point."
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1- (string-to-number (match-string 0))))))
(global-set-key (kbd "M-C-[") 'my/numberic-decrease-region)

(global-set-key (kbd "M-p") 'drag-stuff-up)
(global-set-key (kbd "M-n") 'drag-stuff-down)

;; ediff in dired
(defun ora-ediff-files ()
  (interactive)
  (let ((files (dired-get-marked-files))
        (wnd (current-window-configuration)))
    (if (<= (length files) 2)
        (let ((file1 (car files))
              (file2 (if (cdr files)
                         (cadr files)
                       (read-file-name
                        "file: "
                        (dired-dwim-target-directory)))))
          (if (file-newer-than-file-p file1 file2)
              (ediff-files file2 file1)
            (ediff-files file1 file2))
          (add-hook 'ediff-after-quit-hook-internal
                    (lambda ()
                      (setq ediff-after-quit-hook-internal nil)
                      (set-window-configuration wnd))))
      (error "no more than 2 files should be marked"))))

;;
;; CUSTOMIZE KEY BINDING
;;
;; jump
(map! :leader
      ( :prefix-map ( "j" . "jump" )
                    "c" #'evil-ace-jump-char-mode
                    "j" #'evil-ace-jump-word-mode
                    "t" #'evil-snipe-s
                    "l" #'evil-ace-jump-line-mode
                    "w" #'evil-ace-jump-word-mode
                    ))

;; github link with line no
(map! :leader
      :desc "Github link with linenum"
      "g z" #'git-link)


;; git-link
(setq git-link-use-commit t)

;; winum
(global-set-key (kbd "s-1") 'winum-select-window-1)
(global-set-key (kbd "s-2") 'winum-select-window-2)
(global-set-key (kbd "s-3") 'winum-select-window-3)
(global-set-key (kbd "s-4") 'winum-select-window-4)
(global-set-key (kbd "s-5") 'winum-select-window-5)

;; mu4e
;; ;; we installed this with homebrew
;; (setq mu4e-mu-binary (executable-find "mu"))

;; ;; this is the directory we created before:
;; (setq mu4e-maildir "~/.maildir")

;; ;; this command is called to sync imap servers:
;; (setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
;; ;; how often to call it in seconds:
;; (setq mu4e-update-interval 300)

;; ;; save attachment to desktop by default
;; ;; or another choice of yours:
;; (setq mu4e-attachment-dir "~/Downloads")

;; ;; rename files when moving - needed for mbsync:
;; (setq mu4e-change-filenames-when-moving t)

;; ;; list of your email adresses:
;; (setq mu4e-user-mail-address-list '("oizhaolei@gmail.com"
;;                                     "lei.zhao@as-cube.com"))

;; (after! mu4e
;;   (setq sendmail-program (executable-find "msmtp")
;;         send-mail-function #'smtpmail-send-it
;;         message-sendmail-f-is-evil t
;;         message-sendmail-extra-arguments '("--read-envelope-from")
;;         message-send-mail-function #'message-send-mail-with-sendmail))


(defun my/org-screenshot ()
  "Save a clipboard's screenshot into a time stamped unique-named file
   in a specified directory and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-name)
                  "_img_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "pngpaste" nil nil nil filename)
  (insert (concat "[[./" filename "]]"))
  (org-display-inline-images))

(global-set-key (kbd "C-c C-x C-^") 'my/org-screenshot)

;; (use-package! lsp-bridge
;;   :config
;;   (setq lsp-bridge-enable-log nil)
;;   (global-lsp-bridge-mode))

;; (after! projectile
;;   (setq projectile-project-root-files-bottom-up
;;         (remove ".git"
;;                 projectile-project-root-files-bottom-up)))
