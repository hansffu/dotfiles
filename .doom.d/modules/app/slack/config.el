;;; chat/slack/config.el -*- lexical-binding: t; -*-
(defvar +slack/accounts '())

(use-package! slack
  :commands slack-start
  :init
  (setq slack-buffer-emojify t ;; if you want to enable emoji, default nil
        slack-prefer-current-team t
        slack-modeline nil
        slack-enable-global-mode-string nil
        ;; slack-modeline-count-only-subscribed-channel t
        doom-modeline-irc nil
        slack-buffer-function #'pop-to-buffer)

  (map! :leader
        :prefix ("r" . "Run")
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
  (+slack/register-authinfo-teams +slack/accounts)
  (defclass slack-image-block-element (slack-block-element)
    ((type :initarg :type :type string :initform "image")
     (image-url :initarg :image_url :type string)
     (alt-text :initarg :alt_text :type string)
     (image-height :initarg :image_height :type (or number null))
     (image-width :initarg :image_width :type (or number null))
     (image-bytes :initarg :image_bytes :type (or number null))))
  )

(after! alert
  ;; configure slack alerts to use growl or libnotify
  (alert-add-rule :category "slack"
                  :style (cond (alert-growl-command
                                'growl)
                               (alert-notifier-command
                                'notifier)
                               (alert-libnotify-command
                                'libnotify)
                               (alert-default-style))))
