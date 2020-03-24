;;; chat/slack/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +slack/register-authinfo-teams nil
  "Register teams for all entries in authinfo with :host slack"
  (defun register-team (entry)
    (print (plist-get entry :secret))
    (slack-register-team
     :name (plist-get entry :user)
     :default t
     :token (funcall (plist-get entry :secret))
     :full-and-display-names t))


  (mapcar 'register-team (auth-source-search :host "slack")))


;;;###autoload
(defun +slack/im-select ()
  (interactive)
  (cond ((fboundp 'slack-im-select)
         (call-interactively 'slack-im-select))
        (t (call-interactively 'slack-start)
           (call-interactively 'slack-im-select))))

;;;###autoload
(defun +slack/team-select ()
  (interactive)
  (cond ((fboundp 'slack-change-current-team)
         (call-interactively 'slack-change-current-team))
        (t (call-interactively 'slack-start))))
