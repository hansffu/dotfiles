;;; autoloads/calendar.el -*- lexical-binding: t; -*-

;;;###autoload
(defun my/import-calendars ()
  (interactive)
  (delete-file diary-file)
  (and (get-buffer "diary") (kill-buffer "diary") )
  (setq my/remembered-diary-items '())
  (dolist (calendar my/calendars)
    (let ((url (auth-source-pick-first-password :host (format "calendar.%s" calendar))))
      (async-start (lambda ()
                     (with-temp-buffer (url-insert-file-contents url)
                                       (buffer-string)))
                   (lambda (ret)
                     (with-temp-buffer (insert ret)
                                       (icalendar-import-buffer diary-file t))
                     (appt-activate 1)
                     (after! org
                       (org-agenda-to-appt t))
                     ))
      )
    )
  )


;;;###autoload
(defun my/open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; org-agenda source
    (cfw:cal-create-source "Orange") ; diary source
   )))
