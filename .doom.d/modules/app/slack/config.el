;;; chat/slack/config.el -*- lexical-binding: t; -*-

(use-package! slack
  :commands slack-start
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)

  (map! :leader
        :prefix ("a" . "Applications")
        (:prefix ("s" . "Slack")
          :desc "select im" "i" #'+slack/im-select
          "t" #'+slack/team-select
          ))
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
