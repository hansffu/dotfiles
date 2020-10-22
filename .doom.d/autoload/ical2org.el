;;; autoloads/ical2org.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +ical2org/import ()
  (interactive)
  (let ((ical2org/calendars (--map
                             `(:name ,(car it)
                              :org-file ,(format "~/Dropbox/org/%s_cal.org" (cdr it))
                              :url ,(auth-source-pick-first-password :host (format "calendar.%s" (cdr it)))
                              )
                             my/ical2org-calendars)))
        (message "%s" ical2org/calendars)
        (ical2org/import)
        ))

