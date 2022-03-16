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
(setq doom-theme 'wheatgrass)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; org sql
;; mssql client
(setq sql-ms-program "/usr/local/bin/sqlcmd")

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
(map! :leader
      :desc "er/expand-region"
      "v" #'er/expand-region)

(map! :leader
      ( :prefix-map ( "d" . "customize" )
        :desc "duplicate line/region"
        "d" #'crux-duplicate-current-line-or-region
        :desc "ediff selected files"
        "D" #'ora-ediff-files
        :desc "print yyyy-mm-dd"
        "." #'my/today
        ( :prefix ( "m" . "mine" )
          "c" #'my/js-console-log-region
          "l" #'my/js-logger-region )
        ( :prefix ( "t" . "tide" )
          "a" #'tide-add-tslint-disable-next-line
          "d" #'tide-documentation-at-point
          "D" #'tide-references
          "e" #'tide-error-at-point
          "E" #'tide-project-errors
          "f" #'tide-format
          "F" #'tide-rename-file
          "l" #'tide-list-servers
          "n" #'tide-rename-symbol
          "o" #'tide-organize-imports
          "r" #'tide-refactor
          "R" #'tide-restart-server
          "t" #'tide-jsdoc-template
          "v" #'tide-verify-setup
          "x" #'tide-fix ) )
      )

(map! :leader
      :desc "github link with line no"
      "g z" #'git-link)

;; calendar
(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; orgmode source
    (cfw:ical-create-source "gcal" "https://calendar.google.com/calendar/ical/lei.zhao%40sun-asterisk.com/public/basic.ics" "IndianRed") ; google calendar ICS
    )))


;; org mode + sqlite
(org-babel-do-load-languages
 'org-babel-load-languages (quote ((emacs-lisp . t)
                                   (sql . t)
                                   (sqlite . t)
                                   (js . t)
                                   (R . t)
                                   (python . t))))

;; pulsar
(customize-set-variable
 'pulsar-pulse-functions ; Read the doc string for why not `setq'
 '(recenter-top-bottom
   move-to-window-line-top-bottom
   reposition-window
   bookmark-jump
   other-window
   delete-window
   delete-other-windows
   forward-page
   backward-page
   scroll-up-command
   scroll-down-command
   windmove-right
   windmove-left
   windmove-up
   windmove-down
   windmove-swap-states-right
   windmove-swap-states-left
   windmove-swap-states-up
   windmove-swap-states-down
   tab-new
   tab-close
   tab-next
   org-next-visible-heading
   org-previous-visible-heading
   org-forward-heading-same-level
   org-backward-heading-same-level
   outline-backward-same-level
   outline-forward-same-level
   outline-next-visible-heading
   outline-previous-visible-heading
   outline-up-heading))

(setq pulsar-face 'pulsar-magenta)
(setq pulsar-delay 0.055)

;; git-link
(setq git-link-use-commit t)
