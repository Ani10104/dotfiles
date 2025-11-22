(setq elpaca-core-date '(20231228)) ;; set to the build date of Emacs
(add-to-list 'load-path "~/.emacs.d/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager

(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
;; Reload init.el and all config files
(defun reload-emacs ()
  "Reload Emacs configuration without restarting."
  (interactive)
  (load-file user-init-file)
  (message "Emacs config reloaded!"))
