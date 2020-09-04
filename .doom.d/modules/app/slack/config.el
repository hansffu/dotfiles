;;; chat/slack/config.el -*- lexical-binding: t; -*-

(use-package! slack
  :commands slack-start
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)

  (map! :leader
        :prefix ("a" . "Applications")
        :desc "Slack" "s" #'+slack/start)

  (map! :after slack
        :map slack-mode-map
        :localleader
        :desc "update" "u" #'slack-room-update-messages
        :desc "edit in buffer" "m" #'slack-message-write-another-buffer
        :desc "edit message" "e" #'slack-message-edit
        :desc "delete message" "d" #'slack-message-delete
        :desc "add reaction"     "a" #'slack-message-add-reaction
        :desc "remove reaction"  "r" #'slack-message-remove-reaction
        :desc "show reactions"   "s" #'slack-message-show-reaction-users)

  (set-popup-rule! "^\\*Slack" :size 0.5 :side 'right :select t)
  :config
  (+slack/register-authinfo-teams)

  )

;; "c" 'slack-buffer-kill
;; "pl" 'slack-room-pins-list
;; "pa" 'slack-message-pins-add
;; "pr" 'slack-message-pins-remove
;; "mm" 'slack-message-write-another-buffer
;; "me" 'slack-message-edit
;; "md" 'slack-message-delete
;; "u" 'slack-room-update-messages
;; "2" 'slack-message-embed-mention
;; "3" 'slack-message-embed-channel
;; "\C-n" 'slack-buffer-goto-next-message
;; "\C-p" 'slack-buffer-goto-prev-message
(after! slack
  (defun +slack/im-user-name (team im)
    (funcall (-compose
              (-rpartial 'slack-user--name team)
              (-rpartial 'slack-user--find team))
             (oref im user)))

  (defun +slack/channel-name (channel)
    (oref channel name))

  (defun +slack/group-name (group)
    (oref group name))

  (let* ((team (slack-team-select))
         (channels (slack-team-channels team))
         (groups (slack-team-groups team))
         (ims (slack-team-ims team))
         )
    (append
     (--map (+slack/im-user-name team it) ims)
     (--map (+slack/channel-name it) channels)
     (--map (+slack/group-name it) groups)
     )
    )

  (when (featurep! hydra)

    )
)

(after! alert
    ;; configure pomodoro alerts to use growl or libnotify
  (alert-add-rule :category "slack"
                  :style (cond (alert-growl-command
                                'growl)
                               (alert-notifier-command
                                'notifier)
                               (alert-libnotify-command
                                'libnotify)
                               (alert-default-style))))
