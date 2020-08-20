;;; lang/graql/config.el -*- lexical-binding: t; -*-


(setq graql-font-lock-keywords
      (let* (
             (native-types '("thing" "entity" "attribute" "relation" "role" "rule"))
             (data-types '("long" "double" "string" "boolean" "date"))
             (query-commands '("define" "undefine" "match" "get" "insert" "delete" "compute"))
             (query-modifiers '("offset" "limit" "group" "sort" "asc" "desc"))
             (compute-query '("centrality" "using"))
             (statement-properties '("abstract" "via" "as" "id" "type" "isa" "isa!" "sub" "sub!" "key" "has" "plays" "relates" "datatype" "regex" "when" "then"))
             (operators '("or" "not" "like"))
             (litteral-values '("true" "false"))

             (x-keywords operators)
             (x-types (append native-types data-types))
             (x-constants litteral-values)
             (x-functions (append query-commands query-modifiers compute-query statement-properties))

             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-functions-regexp (regexp-opt x-functions 'words)))


        `(
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          )

        ))

;; (native-types (regexp-opt native-types 'words))
;; (data-types (regexp-opt data-types 'words))
;; (query-commands (regexp-opt query-commands 'words))
;; (query-modifiers (regexp-opt query-modifiers 'words))
;; (compute-query (regexp-opt compute-query 'words))
;; (statement-properties (regexp-opt statement-properties 'words))
;; (operators (regexp-opt operators 'words))
;; (litteral-values (regexp-opt litteral-values 'words))

;; (defun graql-mode ()
;;   "Major mode for editing Workflow Process Description Language files"
;;   (interactive)
;;   (kill-all-local-variables)
;;   (set-syntax-table graql-font-lock-keywords)
;;   (use-local-map graql-mode-map)
;;   (setq major-mode 'graql-mode)
;;   (setq mode-name "GRAQL")
;;   (run-hooks 'graql-mode-hook))

(defvar graql-mode-hook nil)

;; (defvar graql-mode-map
;;   (let ((map (make-keymap)))
;;     (define-key map "\C-j" 'newline-and-indent)
;;     map)
;;   "Keymap for Graql major mode")


(defvar graql-mode-syntax-table nil "Syntax table for `xpy-mode'.")

(setq graql-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?# "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))


;;;###autoload
(define-derived-mode graql-mode fundamental-mode "Graql mode"
  "Graql major mode"
  (setq font-lock-defaults '((graql-font-lock-keywords)) )
  (set-syntax-table xpy-mode-syntax-table)
  (display-line-numbers-mode t)
  )


(add-to-list 'auto-mode-alist '("\\.gql\\'" . graql-mode))

(provide 'graql-mode)
