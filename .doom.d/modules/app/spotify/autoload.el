;;; app/spotify/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +spotify/register-hydra ()
  (defhydra +spotify/hydra (:hint nil)
    "
%(format \"%s\" spotify-player-status)
^Search^                  ^Control^               ^Manage^
^^^^^^^^-----------------------------------------------------------------
_t_: Track               _SPC_: Play/Pause        _+_: Volume up
_m_: My Playlists        _n_  : Next Track        _-_: Volume down
_f_: Featured Playlists  _p_  : Previous Track    _x_: Mute
_u_: User Playlists      _r_  : Repeat            _d_: Device
^^                       _s_  : Shuffle           _q_: Quit
"
    ("t" counsel-spotify-search-track :exit t)
    ("m" spotify-my-playlists :exit t)
    ("f" spotify-featured-playlists :exit t)
    ("u" spotify-user-playlists :exit t)
    ("SPC" spotify-toggle-play :exit nil)
    ("n" spotify-next-track :exit nil)
    ("p" spotify-previous-track :exit nil)
    ("r" spotify-toggle-repeat :exit nil)
    ("s" spotify-toggle-shuffle :exit nil)
    ("+" spotify-volume-up :exit nil)
    ("-" spotify-volume-down :exit nil)
    ("x" spotify-volume-mute-unmute :exit nil)
    ("d" spotify-select-device :exit nil)
    ("q" quit-window "quit" :color blue))
  )

;;;###autoload
(defun +spotify/start ()
  (interactive)
  (+spotify/register-hydra)
  (global-set-key [remap +spotify/start] #'+spotify/hydra/body)
  (+spotify/hydra/body)
  )
