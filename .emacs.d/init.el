(add-to-list 'load-path "~/.emacs.d/lisp")

; Add all top-level subdirectories of .emacs.d to the load path
(progn (cd "~/.emacs.d")
       (normal-top-level-add-subdirs-to-load-path))
; Third party libraries are stored in ~/.emacs.d/extern
(add-to-list 'load-path "~/.emacs.d/extern")
(progn (cd "~/.emacs.d/extern")
       (normal-top-level-add-subdirs-to-load-path))

; Python specific enhancements
(load-library "init-python")

; For those heathen times when I want to scroll and click
(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode t))

(setq make-backup-files nil)

; Tabs, not even once
(setq-default indent-tabs-mode nil)

(setq inhibit-startup-message t)
