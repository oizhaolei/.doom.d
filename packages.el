;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)

;;; Code:

;; underscore -> UPCASE -> CamelCase conversion of names
(package! string-inflection
  :recipe (:host github :repo "akicho8/string-inflection" :branch "main"))


;; A Collection of Ridiculously Useful eXtensions for Emacs
(package! crux
  :recipe (:host github :repo "bbatsov/crux"))


(package! apheleia)

;; for github, copy remote url with line number
(package! git-link
  :recipe (:host github :repo "sshaw/git-link"))

;; Auto-Dark-Emacs is an auto changer between 2 themes, dark/light, following MacOS Dark Mode settings
;; (package! auto-dark-emacs
;;   :recipe (:host github :repo "LionyxML/auto-dark-emacs"))

;; gist
(package! igist
  :recipe (:host github :repo "KarimAziev/igist"))


;; log commands to buffer
(package! command-log-mode
  :recipe (:host github :repo "lewang/command-log-mode"))

;; Disable the mouse in Emacs
(package! disable-mouse
  :recipe (:host github :repo "purcell/disable-mouse"))

;; radio
;; (package! eradio)

;; a quick cursor jump mode for emacs
(package! ace-jump-mode)

;;drag stuff (words, region, lines) around
(package! drag-stuff)

(package! prisma-mode
  :recipe (:host github :repo "pimeys/emacs-prisma-mode" :branch "main"))

(package! aider :recipe (:host github :repo "tninja/aider.el" :files ("*.el")))


(provide 'packages)
;;; packages.el ends here
