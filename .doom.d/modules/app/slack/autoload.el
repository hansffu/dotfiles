;;; chat/slack/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +slack/register-authinfo-teams nil
  "Register teams for all entries in authinfo with :host slack"
  (defun register-team (entry)
    (message (plist-get entry :user))
    (slack-register-team
     :name (plist-get entry :user)
     :default t
     :token (funcall (plist-get entry :secret))
     :full-and-display-names t))


  (mapcar 'register-team (auth-source-search :host "slack" :max 5)))


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

;;;###autoload
(defun +slack/register-hydra ()
  (defhydra +slack/hydra (:hint nil :exit t)
    "
^Browse^       ^Select^       ^Other^
------------------------------------
_i_: im        _T_: team      _R_ restart
_c_: channel
_g_: group
_t_: threads
_u_: unread
"
    ("i" slack-im-select)
    ("c" slack-channel-select)
    ("g" slack-group-select)
    ("t" slack-all-threads)
    ("u" slack-all-unreads)
    ("T" slack-change-current-team)
    ("R" +slack/start)))

;;;###autoload
(defun +slack/start ()
  (interactive)
  (slack-start)
  (+slack/register-hydra)

  (global-set-key [remap +slack/start] #'+slack/hydra/body)
  (+slack/hydra/body))
