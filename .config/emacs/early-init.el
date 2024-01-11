(setq package-enable-at-startup nil)

;; Set the customize file so it doesn't pollute init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
