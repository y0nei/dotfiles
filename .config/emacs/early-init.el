(setq package-enable-at-startup nil)

;; Set the customize file so it doesn't pollute init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Temporarily set a high value of 256 MB to trigger less garbage collections
;; during initialization. The Emacs default is a threshold of 800 KB
(setq gc-cons-threshold (* 256 1000000))

;; Then lower the threshold to 16 MB during normal operation to prevent longer
;; GC pauses, but still have it at a higher value than the default to experience
;; less mini-interruptions – eg. while scrolling larger buffers.
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1000000))))

;; Show a message when garbage collection happens? Useful while tuning the GC
(setq garbage-collection-messages nil)

;; Diagnostics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs started in %s with %d garbage collections."
                     (format "%.3f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Remove flashbang when loading Emacs
(add-to-list 'default-frame-alist '(background-color . "#17191a"))
