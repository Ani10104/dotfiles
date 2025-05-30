;; Force UTF-8 everywhere
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq default-buffer-file-coding-system 'utf-8)




;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; AUCTex configurations for Arch Linux (CachyOS)
(setenv "PATH" "/usr/local/bin:/usr/bin:$PATH" t)
(setq exec-path (append exec-path '("/usr/bin")))

; (setq org-startup-with-latex-preview t)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
; ;; Always use UTF-8
; (prefer-coding-system 'utf-8)
; (set-language-environment "UTF-8")
; (set-default-coding-systems 'utf-8)
(custom-set-faces!
  '(org-level-1 :inherit outline-1 :height 1.5)
  '(org-level-2 :inherit outline-2 :height 1.3)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-4 :height 1.1)
  '(org-level-5 :inherit outline-5 :height 1.0)
  '(org-level-6 :inherit outline-6 :height 1.0)
  '(org-level-7 :inherit outline-7 :height 1.0)
  '(org-level-8 :inherit outline-8 :height 1.0))


(add-hook 'org-mode-hook 'org-fragtog-mode)

(set-face-attribute 'default nil :height 110) ; 110 = 110%

(setq org-format-latex-options
      '(:foreground default
        :background default
        :scale 2.0                    ; Bigger preview (adjust to taste)
        :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))




;; Orgmode Heading Bullets setup
(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  ;; Replace default stars with these pretty bullets
  (setq org-bullets-bullet-list '("◉" "○" "✿" "▶" "▸" "∙")))


(custom-set-faces!
  '(org-level-1 :foreground "#ff6c6b" :weight bold :height 1.4)
  '(org-level-2 :foreground "#98be65" :weight bold :height 1.3)
  '(org-level-3 :foreground "#da8548" :weight bold :height 1.2)
  '(org-level-4 :foreground "#51afef" :weight bold :height 1.1)
  '(org-level-5 :foreground "#c678dd" :weight semi-bold :height 1.0)
  '(org-level-6 :foreground "#46d9ff" :weight semi-bold :height 1.0)
  '(org-level-7 :foreground "#a9a1e1" :weight semi-bold :height 1.0)
  '(org-level-8 :foreground "#ff6c6b" :weight semi-bold :height 1.0))



;; Orgmode open pdf in vert split

(after! org
  ;; Use latexmk for PDF generation
  (setq org-latex-pdf-process
        '("latexmk -pdf -interaction=nonstopmode -output-directory=%o %f"))

  ;; Automatically open PDF in Emacs in a vertical split after export
  (defun my/org-open-exported-pdf ()
    (when (and (eq major-mode 'org-mode)
               (org-export-derived-backend-p org-export-current-backend 'latex))
      (let* ((pdf-file (concat (file-name-sans-extension (buffer-file-name)) ".pdf")))
        (when (file-exists-p pdf-file)
          (select-window (split-window-right)) ;; or split-window-below for horizontal
          (find-file pdf-file)))))

  ;; Hook to run after PDF export
  (add-hook 'org-export-after-processing-hook #'my/org-open-exported-pdf))

;; UTF-8 disable
;; Set default coding system to UTF-8 everywhere
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")


(use-package! autoinsert
  :defer nil  ;; load immediately
  :config
  (auto-insert-mode 1)             ;; enable auto-insert
  (setq auto-insert-query nil)     ;; don't ask for confirmation
  (define-auto-insert
    "\\.org\\'"                    ;; trigger for .org files
    '(my/org-default-template)))   ;; function or string template

(defun my/org-default-template ()
  "Insert a default header for Org files."
  (let ((title (file-name-base (or (buffer-file-name) (buffer-name)))))
    (insert (format "#+TITLE: %s\n" title))
    (insert (format "#+DATE: %s\n" (format-time-string "%Y-%m-%d")))
    (insert "#+AUTHOR: Aniruddha Sarkar\n\n")
    (insert "* Notes\n")))

(define-auto-insert
  "\\.org\\'"
  '(lambda ()
     (when (= (point-max) 1)
       (my/org-default-template))))

;; List enumerate style
(after! org
  (defun my/org-cycle-list-number-style ()
    "Cycle numbering style of current Org list item: 1. → A. → a. → I. → i. → 1."
    (interactive)
    (save-excursion
      (beginning-of-line)
      (when (looking-at "^\\([ \t]*\\)\\([0-9]+\\|[A-Za-z]+\\|[ivxlcdmIVXLCDM]+\\)[.)]\\( \\)")
        (let* ((indent (match-string 1))
               (marker (match-string 2))
               (space (match-string 3))
               (styles '("1." "A." "a." "I." "i."))
               (style
                (cond
                 ((string-match-p "^[0-9]+$" marker) "1.")
                 ((string-match-p "^[A-Z]+$" marker) "A.")
                 ((string-match-p "^[a-z]+$" marker) "a.")
                 ((string-match-p "^[IVXLCDM]+$" marker) "I.")
                 ((string-match-p "^[ivxlcdm]+$" marker) "i.")
                 (t "1.")))
               (next-style (or (cadr (member style styles))
                               (car styles))))
          ;; Replace with next style and "1" as the actual number/letter
          (replace-match (concat indent
                                 (pcase next-style
                                   ("1." "1.")
                                   ("A." "A.")
                                   ("a." "a.")
                                   ("I." "I.")
                                   ("i." "i."))
                                 space)
                         nil nil)))))

  ;; Keybind in Org mode: SPC m n
  (map! :map org-mode-map
        :localleader
        "n" #'my/org-cycle-list-number-style))
;;; ~/.doom.d/config.el

;; Use 4 headline levels during LaTeX export
(after! org
  (setq org-export-headline-levels 5)
  (setq org-latex-default-packages-alist nil) ; Remove default packages
  (setq org-latex-hyperref-template "")       ; Disable hyperref metadata

  ;; Define barebones LaTeX class
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
                 '("barebones"
                   "\\documentclass{report}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")))))

;; Remove auto-generated \label{sec:orgxxxxxx} in LaTeX export
(with-eval-after-load 'ox
  (defun my-latex-filter-removeOrgAutoLabels (text backend info)
    "Remove Org-generated labels like \\label{sec:org123abc} from LaTeX output."
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string "\\\\label{sec:org[0-9a-f]+}\\(?:\n\\)?" "" text)))

  (add-to-list 'org-export-filter-headline-functions
               #'my-latex-filter-removeOrgAutoLabels))

