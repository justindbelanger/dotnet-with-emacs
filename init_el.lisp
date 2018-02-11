(require 'package)

(set-face-background 'mode-line "#050505")

(push '("melpa" . "http://melpa.org/packages/") package-archives)
(push '("org" . "http://orgmode.org/elpa/") package-archives)
(setq package-list '(
         evil-org
		     company
		     ack
		     avy
		     counsel
		     projectile
		     ido-vertical-mode
		     flx-ido
		     color-theme
         hl-line
         hl-line+
         evil-leader
         evil-matchit
		     evil-surround))

(package-initialize)

(unless package-archive-contents (package-refresh-contents)) 

(dolist (package package-list)
 (unless (package-installed-p package)
   (package-install package)))

(require 'evil)
(evil-mode 1)

(require 'color-theme)
(load "~/.emacs.d/railscasts-theme/railscasts-theme.el")

(set-frame-font "Consolas 16")
(add-to-list 'default-frame-alist '(font . "Consolas 14"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))

(require 'hl-line)
(require 'hl-line+)

(global-hl-line-mode 1)

(require 'evil-leader)
(require 'evil-matchit)
(require 'evil-surround)
(require 'projectile)
(require 'ido)
(require 'ido-vertical-mode)

(require 'flx-ido)
(require 'counsel)
(require 'ack)
(require 'company)
(require 'avy)
(require 'editorconfig)
(require 'magit)
(require 'evil-magit)
(require 'yasnippet)
(require 'alert)
(require 'evil-org)
(require 'fsharp-mode)
(require 'ag)
(require 'vimish-fold)

(vimish-fold-global-mode 1)
(setq inferior-fsharp-program "\"C:\\Program Files (x86)\\Microsoft SDKs\\F#\\4.1\\Framework\\v4.0\\fsi.exe\"")
(setq fsharp-compiler "\"C:\\Program Files (x86)\\Microsoft SDKs\\F#\\4.1\\Framework\\v4.0\\fsc.exe\"")


(yas-global-mode 1)

(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))

(setq evil-want-C-i-jump nil)
(setq counsel-ag-base-command "ag --vimgrep --nocolor --nogroup %s")

(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

(evil-mode 1)
(global-evil-matchit-mode 1)
(global-evil-surround-mode 1)

(load "~/.emacs.d/visual-basic-mode/visual-basic-mode.el")
(require 'visual-basic-mode)

(global-hl-line-mode 1)

;;Mode line changes to hide minor modes I don't care about.
(diminish 'projectile-mode "")
(diminish 'osx-clipboard-mode "")
(diminish 'undo-tree-mode "")
(diminish 'company-mode "")
(setq projectile-indexing-method 'alien)
(setq counsel-ag-base-command "ag --vimgrep --nocolor --nogroup %s")

;;Misc editor configuration
(menu-bar-mode -1)
(define-key global-map (kbd "RET") 'newline-and-indent)
(setq-default truncate-lines t)
(setq visible-bell 1)
(editorconfig-mode 1)

;; avy
(setq avy-styles-alist '((avy-goto-word-0 . at-full) (avy-goto-line . at-full)))
(setq avy-all-windows nil)

;; Emac's Ctrl+P
(projectile-global-mode)

(ido-mode 1)
(ido-vertical-mode 1)

(add-hook 'ido-setup-hook 'vim-like-ido-keys)

(defun vim-like-ido-keys ()
  "Add vim like keybindings for ido."
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
  (define-key ido-completion-map (kbd "C-k") 'ido-prev-match))

(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces t)
(setq ido-enable-flex-matching t)

;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(add-hook 'ivy-setup-hook 'vim-like-ivy-keys)

(defun vim-like-ivy-keys ()
  "Add vim like keybindings for ivy."
  (define-key ido-completion-map (kbd "C-n") 'ivy-next-line)
  (define-key ido-completion-map (kbd "C-j") 'ivy-next-line)
  (define-key ido-completion-map (kbd "C-p") 'ivy-previous-line)
  (define-key ido-completion-map (kbd "C-k") 'ivy-previous-line))

(global-hl-line-mode 1)

;;Mode line changes to hide minor modes I don't care about.
(diminish 'projectile-mode "")
(diminish 'osx-clipboard-mode "")
(diminish 'undo-tree-mode "")
(diminish 'company-mode "")


;;Misc editor configuration
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(define-key global-map (kbd "RET") 'newline-and-indent)
(setq-default truncate-lines t)
(setq visible-bell 1)
(editorconfig-mode 1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Deletes trailing whitespace
(defun amir/turn-on-show-trailing-whitespace ()
  (interactive)
  (setq show-trailing-whitespace t))

(add-hook 'prog-mode-hook 'amir/turn-on-show-trailing-whitespace)


(global-set-key (kbd "C-j")
  '(lambda ()
     (interactive)
     (evil-normal-state)
     (condition-case nil 
         (evil-window-down 1)
       (error (if (eq 1 (length (frame-list))) (make-frame-command) (other-frame 1)))
     (evil-normal-state))))
(global-set-key (kbd "C-k")
  '(lambda ()
     (interactive)
     (evil-normal-state)
     (condition-case nil 
         (evil-window-up 1)
       (error (if (eq 1 (length (frame-list))) (make-frame-command) (other-frame -1)))
     (evil-normal-state))))
(global-set-key (kbd "C-l")
  '(lambda ()
     (interactive)
     (evil-normal-state)
     (condition-case nil 
         (evil-window-right 1)
       (error (if (eq 1 (length (frame-list))) (make-frame-command) (other-frame -1)))
     (evil-normal-state))))
(global-set-key (kbd "C-h")
  '(lambda ()
     (interactive)
     (evil-normal-state)
     (condition-case nil 
         (evil-window-left 1)
       (error (if (eq 1 (length (frame-list))) (make-frame-command) (other-frame 1)))
       (evil-normal-state))
     (evil-normal-state)))

(setq-default indent-tabs-mode nil)

;; tab width 2
(setq-default indent-tabs-mode nil tab-width 2)
(setq css-indent-offset 2)

(defun js2-jsx-mode-hook-settings ()
  "Hooks for Web mode. Adjust indents"
  (setq js-indent-level 2)
  (setq tab-width 2)
  (setq web-mode-indent-style 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(add-hook 'ivy-setup-hook 'vim-like-ivy-keys)

(defun vim-like-ivy-keys ()
  "Add vim like keybindings for ivy."
  (define-key ido-completion-map (kbd "C-n") 'ivy-next-line)
  (define-key ido-completion-map (kbd "C-j") 'ivy-next-line)
  (define-key ido-completion-map (kbd "C-p") 'ivy-previous-line)
  (define-key ido-completion-map (kbd "C-k") 'ivy-previous-line))


;;Evil leader
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(setq explicit-shell-file-name "C:\\Program Files\\Git\\git-bash.exe")
(setq explicit-bash.exe-args '("--login" "-i"))

(defun pd ()
  (interactive)
  (projectile-dired))

(defun ps ()
  (interactive)
  (projectile-switch-project))

(defun sm ()
  (interactive)
  (sql-mode))

(defun vbm ()
  (interactive)
  (visual-basic-mode))

(evil-leader/set-key
  "v" 'ag
  "a" 'ace-window
  "c" 'comment-dwim
  "C" 'eshell-kill-process
  "e" 'amir/eval-dwim
  "E" 'amir/eval-file-dwim
  "j" 'avy-goto-line
  "w" 'avy-goto-word-0
  "m" 'amir/split-and-find
  "M" 'amir/hsplit-and-find
  "g" 'projectile-find-file
  "r" 'amir/cider-send-to-repl
  "o" 'org-open-at-point
  "t" 'amir/touch
  "f" 'next-error
  "d" 'previous-error
  "b" 'ido-switch-buffer
  "B" 'amir/split-and-ido-switch-buffer
  "." 'ido-dired
  "=" 'amir-sql-beautify-region
  "," 'amir/split-and-dired
  "<" 'amir/hsplit-and-dired
  "s" 'magit-status
  "h" 'vc-print-log
  ")" 'next-buffer
  "(" 'previous-buffer
  "`" 'amir/resize-window-dwim
  "TAB" 'amir/resize-equal
  "2" 'amir/resize-window-vertical+
  "3" 'amir/resize-window-vertical-
  "1" 'amir/resize-window-horizontal-
  "4" 'amir/resize-window-horizontal+
  "x" 'amir/write-quit
  "z" 'amir/zoom-buffer)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.03)
(setq company-minimum-prefix-length 2)
(setq company-show-numbers 't)
(setq gc-cons-threshold 20000000)

;;ruby syntax highlighting
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(setq ruby-deep-indent-paren nil)

;;disable company-mode hook for org-mode
(add-hook 'org-mode-hook (lambda () (company-mode 0)))


(defun amir/counsel-ag ()
  (interactive)
  (counsel-ag nil (vc-root-dir) nil nil))


(defun amir/company-complete-equal-sign ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert " =")))

(defun amir/company-complete-paren ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert "(")))

(defun amir/company-complete-end-paren ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert ")")))

(defun amir/company-complete-. ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert ".")))

(defun amir/company-complete-comma ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert ",")))

(defun amir/company-complete-end-curly ()
  (interactive)
  (progn
    (company-complete-selection)
    (insert "}")))

;; Make autocomplete insert text if code based keys are pressed
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "C-n") 'company-abort)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
     (define-key company-active-map (kbd "TAB") 'company-select-next)
     (define-key company-active-map [tab] 'company-select-next)
     (define-key company-active-map (kbd ".") 'amir/company-complete-.)
     (define-key company-active-map (kbd ",") 'amir/company-complete-comma)
     (define-key company-active-map (kbd "=") 'amir/company-complete-equal-sign)
     (define-key company-active-map (kbd "}") 'amir/company-complete-end-curly)
     (define-key company-active-map (kbd ")") 'amir/company-complete-end-paren)
     (define-key company-active-map (kbd "(") 'amir/company-complete-paren)))

;;tail log files
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;; magit stuff
(setq magit-last-seen-setup-instructions "1.4.0")
(setq tags-add-tables nil)

(add-hook 'magit-setup-hook 'vim-like-magit-keys)

(defun vim-like-magit-keys ()
  "Add vim like keybindings for ido."
  (define-key magit-status-mode-map (kbd "k") nil))

;;custom methods
(defun amir/resize-equal ()
  (interactive)
  (balance-windows)
  (redraw-display))

(defun amir/resize-window-dwim ()
  (interactive)
  (let ((maximize (< (window-width) (/ (frame-width) 2))))
    (cond ((< (window-width) 80) (evil-window-set-width 80))
          (maximize
           (progn
             (evil-window-set-width (frame-width))
             (evil-window-set-height (frame-height))
             (redraw-display)))
          ((not maximize) (evil-window-set-width 80)))))

(defun amir/zoom-buffer ()
  (interactive)
  (progn
    (evil-window-set-width (frame-width))
    (evil-window-set-height (frame-height))
    (redraw-display)))

(defun amir/resize-window-vertical+ ()
  (interactive)
  (evil-window-set-height (+ (window-height) 10)))

(defun amir/resize-window-vertical- ()
  (interactive)
  (evil-window-set-height (- (window-height) 10)))

(defun amir/resize-window-horizontal+ ()
  (interactive)
  (evil-window-set-width (+ (window-width) 10)))

(defun amir/resize-window-horizontal- ()
  (interactive)
  (evil-window-set-width (- (window-width) 10)))

(defun amir/touch ()
  "Run touch command on current file."
  (interactive)
  (when buffer-file-name
    (shell-command (concat "touch " (shell-quote-argument buffer-file-name)))
    (clear-visited-file-modtime)))

(defun amir/paredit-wrap-around ()
  "Puts parenthesis around current s-exp. Used in clojure and elisp."
  (interactive)
  (paredit-wrap-round)
  (evil-insert 1))

(defun amir/paredit-splice-sexp-killing-backward ()
  "Deletes parenthesis around current s-exp. Used in clojure and elisp."
  (interactive)
  (paredit-splice-sexp-killing-backward)
  (evil-insert 1))

(defun amir/reload-init-el ()
  "Fast way to reload my init.el file."
  (interactive)
  (load "~/.emacs.d/init.el"))

(defun amir/split-and-find ()
  "Opens a new split window and brings up dired so I can ."
  (interactive)
  (evil-window-vsplit)
  (projectile-find-file))

(defun amir/split-and-ido-switch-buffer ()
  "Opens a new split window and brings up recently accessed files."
  (interactive)
  (evil-window-vsplit)
  (ido-switch-buffer))

(defun amir/hsplit-and-find ()
  "Opens a new split window and brings up projectile so I can search for a file."
  (interactive)
  (evil-window-split)
  (projectile-find-file))

(defun amir/split-and-dired ()
  "Opens a new split window and brings up dired so I can navigate a directory."
  (interactive)
  (evil-window-vsplit)
  (ido-dired))

(defun amir/hsplit-and-dired ()
  "Opens a new split window and brings up dired so I can navigate a directory."
  (interactive)
  (evil-window-split)
  (ido-dired))

(defun amir/cljs-buffer ()
  (first
   (-filter (lambda (x) (string-match ".*CLJS.*" (buffer-name x)))
            (cider-connections))))

(defun amir/cider-send-to-repl ()
  (interactive)
  (progn
    (evil-append 0)
    (let ((s (buffer-substring-no-properties
             (nth 0 (cider-last-sexp 'bounds))
             (nth 1 (cider-last-sexp 'bounds)))))
     (with-current-buffer (amir/cljs-buffer)
       (insert s)
       (cider-repl-return)))
    (evil-normal-state)))

(defun amir/eval-dwim ()
  "Send the current selected \"stuff\" to the repl."
  (interactive)
  (pcase major-mode
    (`clojure-mode (cider-eval-defun-at-point))
    (`clojurescript-mode (cider-eval-defun-at-point))
    (`fsharp-mode
     (progn
       (fsharp-eval-phrase)
       (evil-next-line 1)))
    (_ (eval-last-sexp nil))))

(defun amir/eval-file-dwim ()
  "Send the current selected \"stuff\" to the repl."
  (interactive)
    (pcase major-mode
      (`clojure-mode (cider-eval-file buffer-file-name))
      (`fsharp-mode (fsharp-eval-region (point) (mark)))
      (`sql-mode (sql-send-region (point) (mark)))
      (_ (eval-last-sexp nil))))

(defun amir/write-quit ()
  ":wq"
  (interactive)
  (evil-save nil t)
  (kill-buffer-and-window))

(defun amir-sql-beautify-region (beg end)
  "Beautify SQL in region between beg and END."
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "anbt-sql-formatter" nil t)))

(defun amir-sql-beautify-buffer ()
 "Beautify SQL in buffer."
 (interactive)
 (sql-beautify-region (point-min) (point-max)))

(defun amir-eshell-clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(defun amir-copy-file-path ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))


(define-key org-mode-map (kbd "C-j") nil)
(define-key dired-mode-map (kbd "n") nil)
(define-key dired-mode-map (kbd "p") nil)
(define-key ag-mode-map (kbd "k") nil)
(define-key ag-mode-map (kbd "n") nil)
(define-key ag-mode-map (kbd "p") nil)
(define-key ag-mode-map (kbd "g") nil)
(define-key ivy-minibuffer-map (kbd "C-n") nil)
(define-key ivy-minibuffer-map (kbd "C-p") nil)
(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)

(defun keymaps-at-point ()
  "List entire keymaps present at point."
  (interactive)
  (let ((map-list
         (list
          (mapcar (lambda (overlay)
                    (overlay-get overlay 'keymap))
                  (overlays-at (point)))
          (mapcar (lambda (overlay)
                    (overlay-get overlay 'local-map))
                  (overlays-at (point)))
          (get-text-property (point) 'keymap)
          (get-text-property (point) 'local-map))))
    (apply #'message
           (concat 
            "Overlay keymap: %s\n"
            "Overlay local-map: %s\n"
            "Text-property keymap: %s\n"
            "Text-property local-map: %s")
           map-list)))

(defun key-binding-at-point (key)
  (mapcar (lambda (keymap) (when (keymapp keymap)
                             (lookup-key keymap key)))
          (list
           ;; More likely
           (get-text-property (point) 'keymap)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'keymap))
                   (overlays-at (point)))
           ;; Less likely
           (get-text-property (point) 'local-map)
           (mapcar (lambda (overlay)
                     (overlay-get overlay 'local-map))
                   (overlays-at (point))))))

(defun locate-key-binding (key)
  "Determine in which keymap KEY is defined."
  (interactive "kPress key: ")
  (let ((ret
         (list
          (key-binding-at-point key)
          (minor-mode-key-binding key)
          (local-key-binding key)
          (global-key-binding key))))
    (when (called-interactively-p 'any)
      (message "At Point: %s\nMinor-mode: %s\nLocal: %s\nGlobal: %s"
               (or (nth 0 ret) "") 
               (or (mapconcat (lambda (x) (format "%s: %s" (car x) (cdr x)))
                              (nth 1 ret) "\n             ")
                   "")
               (or (nth 2 ret) "")
               (or (nth 3 ret) "")))
    ret))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-hit-face ((t (:foreground "light sea green" :weight normal))))
 '(avy-lead-face ((t (:background "cyan" :foreground "black"))))
 '(avy-lead-face-0 ((t (:background "cyan" :foreground "black"))))
 '(avy-lead-face-1 ((t (:background "cyan" :foreground "black"))))
 '(avy-lead-face-2 ((t (:background "brightblack" :foreground "white"))))
 '(aw-leading-char-face ((t (:foreground "red" :height 5.0))))
 '(cider-debug-code-overlay-face ((t (:background "brightblack"))))
 '(cider-result-overlay-face ((t (:background "brightblack" :box (:line-width -1 :color "yellow")))))
 '(cider-test-failure-face ((t (:background "brightmagenta"))))
 '(col-highlight ((t (:background "color-233"))))
 '(custom-variable-tag ((t (:foreground "cyan" :weight bold))))
 '(diff-added ((t (:inherit diff-changed :background "black" :foreground "#ddffdd"))))
 '(diff-context ((t (:foreground "color-248"))))
 '(diff-file-header ((t (:background "black" :weight bold))))
 '(diff-header ((t (:background "black" :foreground "grey80"))))
 '(diff-refine-added ((t (:background "color-22" :foreground "white"))))
 '(diff-refine-removed ((t (:inherit nil :background "#ffbbbb" :foreground "black"))))
 '(diff-removed ((t (:inherit diff-changed :background "black" :foreground "#ffdddd"))))
 '(ediff-current-diff-C ((t (:background "SystemBackground"))))
 '(ediff-even-diff-B ((t (:background "Grey" :foreground "blue4"))))
 '(ediff-fine-diff-C ((t (:background "#aaaa22" :foreground "black"))))
 '(ediff-odd-diff-C ((t (:background "Grey" :foreground "SystemWindowText"))))
 '(flycheck-warning ((t (:inherit warning :background "black" :underline t))))
 '(flymake-errline ((t (:background "color-52" :foreground "white"))))
 '(flymake-warnline ((t (:background "yellow" :foreground "white"))))
 '(font-lock-keyword-face ((t (:foreground "sky blue"))))
 '(fsharp-usage-face ((t (:foreground "color-39"))))
 '(hl-line ((t (:background "color-235"))))
 '(ivy-current-match ((t (:background "brightmagenta" :foreground "DarkSlateGray2"))))
 '(ivy-highlight-face ((t (:foreground "cornflower blue"))))
 '(ivy-minibuffer-match-face-1 ((t (:background "brightyellow"))))
 '(ivy-minibuffer-match-face-2 ((t (:background "brightblack" :weight bold))))
 '(ivy-minibuffer-match-face-3 ((t (:background "brightgreen" :weight bold))))
 '(ivy-minibuffer-match-face-4 ((t (:background "brightmagenta" :weight bold))))
 '(ivy-remote ((t (:foreground "cyan"))))
 '(jabber-activity-personal-face ((t (:foreground "red" :weight bold))))
 '(js2-external-variable ((t (:foreground "color-136"))))
 '(js2-function-param ((t (:foreground "color-81"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(link ((t (:foreground "color-39" :underline t))))
 '(magit-diff-added ((t (:background "black" :foreground "#22aa22"))))
 '(magit-diff-added-highlight ((t (:background "black" :foreground "#22aa22"))))
 '(magit-diff-context-highlight ((t (:background "black" :foreground "brightgreen"))))
 '(magit-diff-hunk-heading-highlight ((t (:background "black" :foreground "white"))))
 '(magit-diff-removed ((t (:background "brightblack" :foreground "#aa2222"))))
 '(magit-diff-removed-highlight ((t (:background "black" :foreground "#aa2222"))))
 '(magit-popup-argument ((t (:foreground "medium spring green"))))
 '(magit-popup-disabled-argument ((t (:foreground "ghost white" :strike-through t))))
 '(magit-popup-option-value ((t (:foreground "medium spring green"))))
 '(magit-section-highlight ((t (:background "black"))))
 '(minibuffer-prompt ((t (:foreground "color-143" :weight bold))))
 '(mmm-default-submode-face ((t nil)))
 '(mode-line ((t (:background "color-130" :foreground "white" :box nil))))
 '(mode-line-buffer-id ((t (:background "brightred" :foreground "white"))))
 '(mode-line-highlight ((t (:background "dark slate gray" :box (:line-width 2 :color "dark slate gray" :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "gray15" :weight light))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "white"))))
 '(neo-header-face ((t (:foreground "color-33"))))
 '(org-agenda-structure ((t (:foreground "color-38"))))
 '(org-block ((t (:background "gray10"))))
 '(org-date ((t (:foreground "color-81" :underline t))))
 '(org-document-title ((t (:foreground "deep sky blue" :weight bold))))
 '(org-done ((t (:foreground "color-28" :weight bold))))
 '(org-hide ((t (:foreground "gray23"))))
 '(org-scheduled ((t (:foreground "color-34"))))
 '(org-table ((t (:foreground "brightblue"))))
 '(org-todo ((t (:foreground "color-196" :weight bold))))
 '(secondary-selection ((t (:background "color-236"))))
 '(shadow ((t (:foreground "cyan"))))
 '(show-paren-match ((t (:background "dark slate gray"))))
 '(show-paren-mismatch ((t (:background "color-90" :foreground "white"))))
 '(smerge-markers ((t (:background "brightblack" :foreground "white"))))
 '(smerge-mine ((t (:background "black" :foreground "#ffdddd"))))
 '(smerge-other ((t (:background "black" :foreground "#ddffdd"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "#aaffaa" :foreground "black"))))
 '(trailing-whitespace ((t (:background "dark slate gray"))))
 '(vc-annotate-face-CCCCFF ((t (:background "color-16"))) t)
 '(vc-annotate-face-CCD8FF ((t (:background "color-57" :foreground "white"))) t)
 '(vc-annotate-face-CCE4FF ((t (:background "color-56" :foreground "white"))) t)
 '(vc-annotate-face-CCF0FF ((t (:background "brightblack" :foreground "white"))) t)
 '(vc-annotate-face-CCFCFF ((t (:background "color-72" :foreground "white"))) t)
 '(vc-annotate-face-CCFFD2 ((t (:background "color-23" :foreground "white"))) t)
 '(vc-annotate-face-CCFFDE ((t (:background "color-30" :foreground "white"))) t)
 '(vc-annotate-face-CCFFEA ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-CCFFF6 ((t (:background "color-31" :foreground "white"))) t)
 '(vc-annotate-face-D2FFCC ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-DEFFCC ((t (:background "color-25" :foreground "white"))) t)
 '(vc-annotate-face-EAFFCC ((t (:background "color-24" :foreground "white"))) t)
 '(vc-annotate-face-F6FFCC ((t (:background "color-89" :foreground "white"))) t)
 '(vc-annotate-face-FFCCCC ((t (:background "color-88" :foreground "white"))) t)
 '(vc-annotate-face-FFD8CC ((t (:background "color-90" :foreground "white"))) t)
 '(vc-annotate-face-FFE4CC ((t (:background "color-91" :foreground "white"))) t)
 '(vc-annotate-face-FFF0CC ((t (:background "color-94" :foreground "white"))) t)
 '(vc-annotate-face-FFFCCC ((t (:background "color-99" :foreground "white"))) t)
 '(web-mode-html-tag-bracket-face ((t (:foreground "color-250"))))
 '(web-mode-html-tag-face ((t (:foreground "yellow"))))
 '(whitespace-hspace ((t (:foreground "beige"))))
 '(whitespace-newline ((t (:foreground "white" :weight normal))))
 '(whitespace-space ((t (:foreground "beige"))))
 '(whitespace-space-after-tab ((t (:background "red" :foreground "white"))))
 '(whitespace-tab ((t (:foreground "beige"))))
 '(yas-field-highlight-face ((t nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-use-environment t)
 '(avy-all-windows (quote all-frames))
 '(aw-keys (quote (106 107 102 100 115 108 97 59 104)))
 '(cider-cljs-lein-repl
   "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")
 '(evil-esc-delay 0)
 '(fancy-splash-image nil)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(js-indent-level 2)
 '(jsx-indent-level 2)
 '(minibuffer-prompt-properties (quote (read-only t face minibuffer-prompt)))
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (counsel ivy zencoding-mode yasnippet web-mode typit scss-mode sbt-mode paredit osx-clipboard mmm-mode markdown-mode json-mode js2-mode ido-vertical-mode hl-line+ helm-projectile fsharp-mode flymake-ruby flx-ido expand-region exec-path-from-shell evil-surround evil-org evil-matchit evil-magit emmet-mode editorconfig diminish csharp-mode company-tern color-theme cider avy auto-complete ag 2048-game)))
 '(ruby-deep-arglist nil)
 '(ruby-deep-indent-paren nil)
 '(safe-local-variable-values
   (quote
    ((cider-cljs-lein-repl . "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))"))))
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(sql-database "DEORewrite_Test_Data")
 '(sql-ms-login-params (quote (server database)))
 '(sql-ms-options (quote ("-w" "10000" "-E" "-n")))
 '(sql-server "DAL2DEVPC353")
 '(web-mode-code-indent-offset 2)
 '(yas-global-mode t))
