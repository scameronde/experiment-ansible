import System.Exit
import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Util.Run
import XMonad.Util.EZConfig


main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

myKeys = [ ((mod4Mask, xK_p), safeSpawn "dmenu_run" []) 
         , ((mod4Mask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
         ]

myConfig = gnomeConfig 
    {
      terminal    = "xterm -e 'tmux new -A -s Client'" 
    , modMask     = mod4Mask
    , layoutHook  = smartBorders (avoidStruts $ layoutHook desktopConfig)
    , manageHook  = manageHook gnomeConfig <+> manageDocks
    , startupHook = setWMName "LG3D"
    , focusedBorderColor = "#ffffff"
    , normalBorderColor  = "#aaaaaa"
    , borderWidth = 1
    } `additionalKeys` myKeys


