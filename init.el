(require 'package)
(setq package-archives '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; This means we prefer things from ~/.emacs.d/elpa over the standard packages.
(package-initialize)

;; This bootstraps us if we don't have anything
;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; (when (not (package-installed-p 'el-get))
;;   (package-install 'el-get))

(when (not (file-exists-p (concat user-emacs-directory "el-get")))
  (message "Making el-get config directoy.")
  (make-directory (concat user-emacs-directory "el-get")))

(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(require 'el-get nil 'noerror)

(setq el-get-verbose t)
(setq el-get-install-skip-emacswiki-recipes 't)
(add-to-list 'el-get-recipe-path "~/.emacs.d/local/recipes")

(setq el-get-sources
      '((:name ace-jump-mode
               :description "Jump to the thing"
               :type git
               :url "git@github.com:winterTTr/ace-jump-mode.git")
	(:name ace-window
               :description "Like ace-jump-mode but for windows"
               :type git
               :url "git@github.com:abo-abo/ace-window.git"
               :depends (ace-jump-mode))
        (:name queue
               :description "The queue package"
               :type elpa)
        (:name cider
               :website "https://github.com/clojure-emacs/cider"
               :description "Clojure IDE and REPL for Emacs"
               :type git
               :url "git@github.com:clojure-emacs/cider.git"
               :pkgname "cider")
        (:name clocker
               :description "Clock in while you work!"
               :type git
               :url "git@github.com:roman/clocker.el.git")
        (:name clojure-mode
               :website "https://github.com/clojure-emacs/clojure-mode"
               :description "Emacs support for the Clojure language. Without the deprecated clojure-test-mode being required."
               :type elpa
               :pkgname "clojure-mode")
        (:name csv-mode
               :description "csv-mode"
               :type git
               :url "git@github.com:emacsmirror/csv-mode.git")
        (:name elmacro
               :description "Show keyboard macros as emacs lisp."
               :type git
               :url "git@github.com:Silex/elmacro.git")
        (:name erc-colorize
               :description "Colorize the whole message in erc rather than just the nick"
               :type git
               :url "git@github.com:thisirs/erc-colorize.git")
        (:name es-mode
               :description "Elasticsearch mode"
               :type git
               :url "git@github.com:dakrone/es-mode.git")
        (:name grandshell-theme
               :description "Purple-tastic theme"
               :type git
               :url "git@github.com:steckerhalter/grandshell-theme.git")
        (:name jabber
               :description "A minimal jabber client"
               :type git
	       :url "git@github.com:legoscia/emacs-jabber.git"
               :pkg-name jabber)
        (:name org-gcal
               :description "Google Calendar integration for org-mode"
               :type git
               :url "git@github.com:myuhe/org-gcal.el.git"
               :depends (deferred alert cl-lib org-mode))
        (:name powerline
               :description "Emacs version of vim powerline"
               :type git
               :url "git@github.com:milkypostman/powerline.git")
        (:name rainbow-mode
               :description "rainbow-mode"
               :type git
               :url "git@github.com:emacsmirror/rainbow-mode.git")))

;; my packages
(setq my-packages
      (append
       ;; list of packages we use straight from official recipes
       '(ace-jump-mode
	 ace-window
	 align-cljlet
         browse-kill-ring
	 buffer-move
	 cider
         clocker
	 clj-refactor
	 cljsbuild-mode
	 ;; clojure-cheatsheet ;; in melpa
	 ;; color-identifiers-mode ;; this breaks alot lately
	 company-mode
	 css-eldoc
         csv-mode ;; syntax error in the file csv-mode-pkg.el
	 diminish
         jabber
         elmacro
	 emms
	 exec-path-from-shell
	 discover
         erc-colorize
         es-mode
         git-auto-commit
	 git-gutter-fringe+
	 ;; github-browse-file ;; in melpa
	 gist
	 ;; gnus-alias ;; in melpa
	 grandshell-theme
	 helm
         helm-ag
	 ;; helm-orgcard ;; in melpa
	 ;; helm-projectile ;; in melpa
	 highlight-symbol
         ido-vertical-mode
	 js2-mode
         json-reformat
	 keyfreq
	 magit
	 magit-gh-pulls
	 makey
	 markdown-mode
	 monokai-theme
	 multiple-cursors
         org-gcal
	 org-mode
	 org-pomodoro
	 paredit
         popup
         powerline
	 projectile
         queue
	 rainbow-delimiters
	 rainbow-mode
	 refheap
         restclient
	 sauron
	 smartscan
         smex
	 tagedit
	 twittering-mode
	 window-number
         yaml-mode
	 yasnippet)
       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

(el-get 'sync my-packages)

(require 'org)
(org-babel-load-file (concat user-emacs-directory "org/config.org"))
