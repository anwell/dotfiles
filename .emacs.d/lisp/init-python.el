; tab display width of 4 columns by default
; (throw everything at the wall, and eventually something will stick...)
(setq-default tab-width 4)  ; Normal emacs tab-width
(setq-default py-smart-indentation nil) ; Don't try to guess tab width
(setq-default py-indent-offset 4) ; emacs-for-python setting
(setq-default python-indent 4) ; emacs-for-python setting

(defun customize-py-tabs ()
    (setq indent-tabs-mode nil
        tab-width 4
        py-smart-indentation nil
        py-indent-offset 4
        python-indent 4
    )
 )

(add-hook 'python-mode-hook 'customize-py-tabs)

; Reconfigure whitespace-mode for day-to-day use
(require 'whitespace)
(setq whitespace-style '(face tabs space-before-tab tab-mark))
(global-whitespace-mode t)

;; On save, remove whitespace at end of lines
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; This is like the lines-tail setting for whitespace-style
; Except it uses preprend, so it doesn't clobber other faces
(require 'whitespace)
(defface too-long-line
  '((t :background "gray14"))
  "Face for parts of a line that co over 80 chars."
)

; Can't remember where I stole this from. Similar code in whitespace.el
(add-hook 'font-lock-mode-hook (lambda ()
 (font-lock-add-keywords nil
   `((,(format
      "^\\([^\t\n]\\{%s\\}\\|[^\t\n]\\{0,%s\\}\t\\)\\{%d\\}%s\\(.+\\)$"
      tab-width (- tab-width 1)
      (/ whitespace-line-column tab-width)
      (let ((rem (% whitespace-line-column tab-width)))
        (if (zerop rem)
        ""
        (format ".\\{%d\\}" rem))))
     (2 'too-long-line prepend)))
   t)))

;; Cheetah Modes
(define-derived-mode cheetah-mode html-mode "cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\\(#\\(from\\|else\\|include\\|extends\\|set\\|def\\|import\\|for\\|if\\|end\\|elif\\|call\\|block\\|attr\\|silent\\|echo\\|return\\)+\\)\\>" 1 font-lock-type-face)
     ("\\(#\\(from\\|for\\|end\\|else\\)\\).* \\<\\(for\\|import\\|def\\|if\\|in\\|block\\|call\\)\\>" 3 font-lock-type-face)
     ("\\(##.*\\)\n" 1 font-lock-comment-face)
     ("\\(\\$\\(?:\\sw\\|}\\|{\\|\\s_\\)+\\)" 1 font-lock-variable-name-face))
   )
  (font-lock-mode 1)
 )

(define-derived-mode cheetah-css-mode css-mode "cheetah-css"
  (make-face 'cheetah-css-variable-face)
  (font-lock-add-keywords
   nil
   '(("\\(##.*\\)\n" font-lock-comment-face)) (font-lock-mode 1))
  (modify-syntax-entry ?# "' 12b" cheetah-css-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" cheetah-css-mode-syntax-table))

(setq auto-mode-alist (cons '( "\\.tmpl\\'" . cheetah-mode ) auto-mode-alist ))
(setq auto-mode-alist (cons '( "\\.css.tmpl\\'" . cheetah-css-mode ) auto-mode-alist ))

; emacs-for-python
(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(epy-setup-ipython)
(epy-setup-checker "pyflakes %f")
