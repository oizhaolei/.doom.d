;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lei Zhao"
      user-mail-address "oizhaolei@gmail.com")
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

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
(setq-hook! 'html-mode-hook +format-with :none)
;; winner-mode
(global-set-key (kbd "C-c H") 'winner-undo)
(global-set-key (kbd "C-c L") 'winner-redo)


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
  (global-set-key (kbd "C-c m .") 'my/today)

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
  (global-set-key (kbd "C-c m i") 'my/intl-region)

  (defun my/js-console-log-region ()
    "Write console.log of curent region to new line."
    (interactive)
    (let (myRegion)
      (if (use-region-p)
          (setq myRegion (buffer-substring (region-beginning) (region-end)))
        (setq myRegion (thing-at-point 'word))
        )
      (end-of-line)
      (newline-and-indent)
      (insert (format "console.log('%s:', %s);" myRegion myRegion))))
  (global-set-key (kbd "C-c m c") 'my/js-console-log-region)

  (defun my/js-logger-region ()
    "Write console.log of curent region to new line."
    (interactive)
    (let (myRegion)
      (if (use-region-p)
          (setq myRegion (buffer-substring (region-beginning) (region-end)))
        (setq myRegion (thing-at-point 'word))
        )
      (end-of-line)
      (newline-and-indent)
      (insert (format "logger.info('%s:', %s);" myRegion myRegion))))
  (global-set-key (kbd "C-c m l") 'my/js-logger-region)

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

  (defun my/open-curr-dir(arg)
    "Open base dir of visited file in default external program.
When in dired mode, open file under the cursor.

With a prefix ARG always prompt for command to use."
    (interactive "P")
    (let* ((current-file-name
            (if (eq major-mode 'dired-mode)
                (dired-get-file-for-visit)
              buffer-file-name))
           (open (pcase system-type
                   (`darwin "open")
                   ((or `gnu `gnu/linux `gnu/kfreebsd) "xdg-open")))
           (program (if (or arg (not open))
                        (read-shell-command "Open current file with: ")
                      open)))
      (call-process program nil 0 nil current-file-name)))

(map! :leader
      :desc "projectile find dir"
      "p d" #'projectile-find-dir)

(map! :leader
      :desc "er/expand-region"
      "v" #'er/expand-region)

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

