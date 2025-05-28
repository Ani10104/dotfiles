;;; latex-project.el --- Org latex file              -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Aniruddha

;; Author: Aniruddha <ani@Workspace>

;;; latex-project.el --- Create LaTeX project structure  -*- lexical-binding: t; -*-

(defun create-latex-project (project-name)
  "Create a new LaTeX project with the given PROJECT-NAME."
  (interactive "sEnter project name: ")
  (when (string-empty-p project-name)
    (user-error "You must provide a project name!"))

  ;; Prompt for main file name with default
  (let* ((default-main "main")
         (main-file (read-string (format "Enter name for main .tex file (default: %s): " default-main)))
         (main-file (if (string-empty-p main-file) default-main main-file))
         (main-file (if (string-match "\\.tex$" main-file) main-file (concat main-file ".tex")))
         (cwd default-directory)
         (project-dir (expand-file-name project-name cwd))
         (general-dir (expand-file-name "General" project-dir))
         (template-dir (expand-file-name "Templates/latex/" (getenv "HOME"))))

    ;; Create directories
    (make-directory general-dir t)

    ;; Copy preamble files
    (dolist (file (directory-files template-dir t "^preamble-.*\\.tex$"))
      (copy-file file (expand-file-name (file-name-nondirectory file) general-dir) t))

    ;; Copy all .tex files (excluding preamble files)
    (dolist (file (directory-files template-dir t "\\.tex$"))
      (unless (string-match "^preamble-" (file-name-nondirectory file))
        (copy-file file (expand-file-name (file-name-nondirectory file) general-dir) t)))

    ;; Copy .sty files
    (dolist (file (directory-files template-dir t "\\.sty$"))
      (copy-file file (expand-file-name (file-name-nondirectory file) project-dir) t))

    ;; Copy .latexmkrc if exists
    (let ((latexmkrc-src (expand-file-name ".latexmkrc" template-dir)))
      (when (file-exists-p latexmkrc-src)
        (copy-file latexmkrc-src (expand-file-name ".latexmkrc" project-dir) t)))

    ;; Copy copypdf.sh if exists and make executable
    (let ((copypdf-src (expand-file-name "copypdf.sh" template-dir)))
      (when (file-exists-p copypdf-src)
        (copy-file copypdf-src (expand-file-name "copypdf.sh" project-dir) t)
        (set-file-modes (expand-file-name "copypdf.sh" project-dir) #o755)
        (message "Copied and made executable: copypdf.sh")))

    ;; Create main tex file
    (let ((main-tex-path (expand-file-name main-file project-dir)))
      (with-temp-file main-tex-path
        (insert "\\documentclass[12pt]{article}\n\n")
        (insert "\\begin{document}\n\n")
        (insert "% Your content here\n\n")
        (insert "\\end{document}\n"))

      ;; Open the created file
      (find-file main-tex-path)
      (message "✅ Created LaTeX project: %s with main file: %s" project-name main-file))))

(provide 'latex-project)
