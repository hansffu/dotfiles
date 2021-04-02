;;; app/spotify/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +spotify/register-hydra ()
  (defhydra +spotify/hydra (:hint nil)
    "
^Search^                  ^Control^               ^Manage^
^^^^^^^^-----------------------------------------------------------------
_t_: Track               _SPC_: Play/Pause        _+_: Volume up
_m_: My Playlists        _n_  : Next Track        _-_: Volume down
_f_: Featured Playlists  _p_  : Previous Track    _x_: Mute
_u_: User Playlists      _r_  : Repeat            _d_: Device
^^                       _s_  : Shuffle           _q_: Quit
"
    ("t" counsel-spotify-search-track :exit t)
    ("m" smudge-my-playlists :exit t)
    ("f" smudge-featured-playlists :exit t)
    ("u" smudge-user-playlists :exit t)
    ("SPC" smudge-controller-toggle-play :exit nil)
    ("n" smudge-controller-next-track :exit nil)
    ("p" smudge-controller-previous-track :exit nil)
    ("r" smudge-controller-toggle-repeat :exit nil)
    ("s" smudge-controller-toggle-shuffle :exit nil)
    ("+" smudge-controller-volume-up :exit nil)
    ("-" smudge-controller-volume-down :exit nil)
    ("x" smudge-controller-volume-mute-unmute :exit nil)
    ("d" smudge-select-device :exit nil)
    ("q" quit-window "quit" :color blue))
  )

;;;###autoload
(defun +spotify/start ()
  (interactive)
  (setq smudge-transport 'connect
        smudge-oauth2-client-secret (auth-source-pick-first-password :host "spotify-client-secret" )
        smudge-oauth2-client-id spotify-client-id
        counsel-spotify-client-id spotify-client-id
        counsel-spotify-client-secret (auth-source-pick-first-password :host "spotify-client-secret" ))
  (+spotify/register-hydra)
  (global-set-key [remap +spotify/start] #'+spotify/hydra/body)
  (+spotify/hydra/body)
  )
