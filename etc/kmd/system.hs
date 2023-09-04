(deflayer system
  @lock @wmmp @wmms @wmml @wmmd @wmmr _     _     _     _     _     _     _            XX    XX    XX
  XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    @brtd @brtu @tgwt  XX    XX    XX     XX    XX    XX    XX
  _     XX    XX    XX    @wmrb @test XX    XX    @i3re @wmlo @wmpo XX    XX    @tgbr  XX    XX    XX     XX    XX    XX    XX
  _     XX    @wmss @wmds XX    XX    XX    XX    @kmdr @wmlk XX    XX    _                               XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _                        XX           XX    XX    XX    XX
  _     _     @sysa             _                 _     _     _     _                  XX    XX    XX     XX    XX
)
(deflayer systemalt
  _     _     _     _     _     _     _     _     _     _     _     _     _            XX    XX    _
  XX    @kll1 @kll2 @kll3 XX    XX    XX    XX    XX    XX    XX    XX    XX    _      XX    XX    XX     XX    XX    XX    XX
  _     @kill @panc XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX     XX    XX    XX     XX    XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _                               XX    XX    XX
  _     XX    XX    XX    XX    XX    XX    XX    XX    XX    XX    _                        XX           XX    XX    XX    XX
  _     _     _                 _                 _     _     _     _                  XX    XX    XX     XX    XX
)
(defalias
    kill (cmd-button "sleep 0.1 ; pkill -x kmonad")
    kll1 (cmd-button "killall firefox")
    kll2 (cmd-button "killall lite-xl")
    kll3 (cmd-button "killall alacritty")
    panc (cmd-button "killall firefox lite-xl alacritty")
    sysa (layer-toggle systemalt)
    kmdr (cmd-button "kmdrun")
    i3re (cmd-button "i3-msg restart")
    wmlk (cmd-button "loginctl lock-session")
    wmds (cmd-button "displaygeometry --file .iukdisplays")
    wmlo (cmd-button "i3-msg exit")
    wmss (cmd-button "loginctl lock-session && systemctl suspend")
    wmhb (cmd-button "systemctl hibernate")
    wmpo (cmd-button "systemctl poweroff")
    wmrb (cmd-button "systemctl reboot")
    wmmp (cmd-button "mons -o")
    wmms (cmd-button "mons -s")
    wmmd (cmd-button "mons -m")
    wmml (cmd-button "mons -e left")
    wmmr (cmd-button "mons -e right")
    brtu (cmd-button "sudo setmonbrightness --increase")
    brtd (cmd-button "sudo setmonbrightness --decrease")
    tgwt (cmd-button "i3-msg border toggle")
    tgbr (cmd-button "i3-msg bar mode toggle, bar hidden_state hide")
    test (cmd-button "$HOME/.test")
)

