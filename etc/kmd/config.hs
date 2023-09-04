(defcfg
    input  (device-file "DEVICE_FILE_PATH")
    output (uinput-sink "iukbtw" "sleep 0.1")
    fallthrough true
    allow-cmd true
)
(defsrc
  esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12          ssrq  slck  pause
  grv   1     2     3     4     5     6     7     8     9     0     -     =     bspc   ins   home  pgup   nlck  kp/   kp*   kp-
  tab   q     w     e     r     t     y     u     i     o     p     [     ]     \      del   end   pgdn   kp7   kp8   kp9   kp+
  caps  a     s     d     f     g     h     j     k     l     ;     '     ret                             kp4   kp5   kp6
  lsft  z     x     c     v     b     n     m     ,     .     /     rsft                     up           kp1   kp2   kp3   kprt
  lctl  lmet  lalt              spc               ralt  rmet  cmp   rctl               left  down  rght   kp0   kp.
)
(deflayer normal_keyboard
  esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12          ssrq  slck  pause
  grv   1     2     3     4     5     6     7     8     9     0     -     =     bspc   ins   home  pgup   nlck  kp/   kp*   kp-
  tab   q     w     e     r     t     y     u     i     o     p     [     ]     \      del   end   pgdn   kp7   kp8   kp9   kp+
  caps  a     s     d     f     g     h     j     k     l     ;     '     ret                             kp4   kp5   kp6
  lsft  z     x     c     v     b     n     m     ,     .     /     rsft                     up           kp1   kp2   kp3   kprt
  lctl  lmet  lalt              spc               ralt  rmet  cmp   rctl               left  down  rght   kp0   kp.
)
(deflayer blocked_all_but_modifiers
  _     _     _     _     _     _     _     _     _     _     _     _     _            XX    XX    _
  XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _      XX    XX    XX     XX    XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX     XX    XX    XX     XX    XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _                               XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _                        XX           XX    XX    XX    XX
  _     _     _                 _                 _     _     _     _                  XX    XX    XX     XX    XX
)
(deflayer transparent
  _     _     _     _     _     _     _     _     _     _     _     _     _            XX    XX    XX
  _     _     _     _     _     _     _     _     _     _     _     _     _     _      XX    XX    XX     XX    XX    XX    XX
  _     _     _     _     _     _     _     _     _     _     _     _     _     _      XX    XX    XX     XX    XX    XX    XX
  _     _     _     _     _     _     _     _     _     _     _     _     _                               XX    XX    XX
  _     _     _     _     _     _     _     _     _     _     _     _                        XX           XX    XX    XX    XX
  _     _     _                 _                 _     _     _     _                  XX    XX    XX     XX    XX
)

