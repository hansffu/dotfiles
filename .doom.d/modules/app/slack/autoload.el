;;; chat/slack/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +slack/register-authinfo-team (host)
  (let ((entry (car (auth-source-search :host host :max 1))))
    (slack-register-team
     :name (plist-get entry :user)
     :default t
     :modeline-enabled t
     :modeline-name (plist-get entry :user)
     :token (plist-get entry :secret)
     :full-and-display-names t)))

;;;###autoload
(defun +slack/register-authinfo-teams (account-hosts)
  "Register teams for all entries in auth-source where :host is in ACCOUNT-HOSTS"
  (mapcar '+slack/register-authinfo-team account-hosts))


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
_r_: room
_t_: thread
_u_: unread
"
    ("i" slack-im-select)
    ("c" slack-channel-select)
    ("g" slack-group-select)
    ("r" slack-select-rooms)
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
