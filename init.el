(require 'package)
(setq package-archives '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; This means we prefer things from ~/.emacs.d/elpa over the standard packages.
(package-initialize)

;; This bootstraps us if we don't have anything
(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'el-get))
  (package-install 'el-get))

(when (not (file-exists-p (concat user-emacs-directory "el-get")))
  (message "Making el-get config directoy.")
  (make-directory (concat user-emacs-directory "el-get")))

(require 'el-get nil 'noerror)

(setq el-get-verbose t)
(setq el-get-install-skip-emacswiki-recipes 't)
(add-to-list 'el-get-recipe-path "~/.emacs.d/local/recipes")

(setq el-get-sources
      '((:name org-gcal
               :description "Google Calendar integration for org-mode"
               :type git
               :url "git@github.com:myuhe/org-gcal.el.git"
               :depends (deferred alert cl-lib org-mode))
        (:name ace-window
               :description "Like ace-jump-mode but for windows"
               :type git
               :url "git@github.com:abo-abo/ace-window.git"
               :depends (ace-jump-mode))
        (:name erc-colorize
               :description "Colorize the whole message in erc rather than just the nick"
               :type git
               :url "git@github.com:thisirs/erc-colorize.git")
        (:name grandshell-theme
               :description "Purple-tastic theme"
               :type git
               :url "git@github.com:steckerhalter/grandshell-theme.git")
        (:name es-mode
               :description "Elasticsearch mode"
               :type git
               :url "git@github.com:dakrone/es-mode.git")
	(:name rainbow-mode
               :description "rainbow-mode"
               :type git
               :url "git@github.com:emacsmirror/rainbow-mode.git")
        ))

;; my packages
(setq my-packages
      (append
       ;; list of packages we use straight from official recipes
       '(ace-jump-mode
	 ace-window
	 align-cljlet
	 buffer-move
	 cider
	 clj-refactor
	 cljsbuild-mode
	 ;; clojure-cheatsheet ;; in melpa
	 ;; color-identifiers-mode ;; this breaks alot lately
	 company-mode
	 css-eldoc
	 ;; csv-mode ;; syntax error in the file csv-mode-pkg.el
	 diminish
         emacs-jabber
	 emms
	 exec-path-from-shell
	 discover
         erc-colorize
         es-mode
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
	 js2-mode
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
	 projectile
	 rainbow-delimiters
	 rainbow-mode
	 refheap
	 sauron
	 smartscan
	 tagedit
	 twittering-mode
	 window-number
	 yasnippet)
       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

(el-get 'sync my-packages)

(require 'org)
(org-babel-load-file (concat user-emacs-directory "org/config.org"))
