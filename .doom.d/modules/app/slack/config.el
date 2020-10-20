;;; chat/slack/config.el -*- lexical-binding: t; -*-

(use-package! slack
  :commands slack-start
  :init
  (setq slack-buffer-emojify t ;; if you want to enable emoji, default nil
        slack-prefer-current-team t
        slack-modeline t
        slack-enable-global-mode-string t
        slack-modeline-count-only-subscribed-channel t)

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
        :desc "show reactions"   "s" #'slack-message-show-reaction-users
        :desc "insert emoji" "i" #'slack-insert-emoji)

  (set-popup-rule! "^\\*Slack" :size 0.5 :side 'right :select t)
  :config
  (+slack/register-authinfo-teams)

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
