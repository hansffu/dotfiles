;;; app/eaf/autoload.el -*- lexical-binding: t; -*-
(defun +eaf/browse ()
  "Start EAF browser in workspace if enabled"
  (interactive)
  (if (featurep! :ui workspaces)
      (progn
        (+workspace-switch "Browser" t)
        (eaf-open-browser-with-history)
        (+workspaces-add-current-buffer-h)
        (+workspace/display))
    (eaf-open-browser-with-history))
  )
