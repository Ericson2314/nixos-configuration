{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
import XMonad

import XMonad.Hooks.ManageHelpers
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutModifier

import qualified Data.Map as M

myManageHook = composeAll
  [ (className =? "Gnome-panel" <&&> title =? "Run Application") --> doCenterFloat
  --, (className =? "Gcr-prompter")                                --> doCenterFloat
  --, (className =? "Xfce4-notifyd"                                -->  doIgnore)
  , isFullscreen                                                 --> doFullFloat
  ]

myKeys (XConfig {XMonad.modMask = modm}) = M.fromList $
  [ ((modm,               xK_p), spawn "dmenu_run")
  , ((modm .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
  ]

main :: IO ()
main = xmonad $ extend defaultConfig -- gnomeConfig
  where extend :: forall w
               .  LayoutClass w Window
               => XConfig w
               -> XConfig (ModifiedLayout SmartBorder w)
        extend self = self
          { modMask            = mod4Mask
          , terminal           = "termite"
          , layoutHook         = smartBorders (layoutHook self)
          , keys               = myKeys <+> keys self
          --, borderWidth        = 2
          --, normalBorderColor  = "#cccccc"
          --, focusedBorderColor = "#3300ff"
          , manageHook         = myManageHook <+> manageHook self
          }
