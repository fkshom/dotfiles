import sys
import os
import datetime

import pyauto
from keyhac import *

# [keyhac: User Manual](http://crftwr.github.io/keyhac/doc/ja/index.html)


def configure(keymap):

    # --------------------------------------------------------------------
    # Text editer setting for editting config.py file

    # Setting with program file path (Simple usage)
    if 1:
        keymap.editor = "notepad.exe"

    # Setting with callable object (Advanced usage)
    if 0:
        def editor(path):
            shellExecute( None, "notepad.exe", '"%s"'% path, "" )
        keymap.editor = editor

    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont( "MS Gothic", 12 )

    # Theme
    keymap.setTheme("black")

    # --------------------------------------------------------------------

    # Simple key replacement
    #keymap.replaceKey( "LWin", 235 )
    #keymap.replaceKey( "RWin", 255 )
    #keymap.replaceKey( 28, 236 )  # 28:変換キー
    keymap.replaceKey( 29, 235 )  # 29:無変換キー

    # User modifier key definition
    keymap.defineModifier( 235, "User0" )
    #keymap.defineModifier( 236, "User1" )

    # Global keymap which affects any windows
    if 1:
        keymap_global = keymap.defineWindowKeymap()

        # Keyboard macro
        keymap_global[ "U0-0" ] = keymap.command_RecordToggle
        keymap_global[ "U0-1" ] = keymap.command_RecordStart
        keymap_global[ "U0-2" ] = keymap.command_RecordStop
        keymap_global[ "U0-3" ] = keymap.command_RecordPlay
        keymap_global[ "U0-4" ] = keymap.command_RecordClear

        keymap_global[ "U0-h" ] = "Left"
        keymap_global[ "U0-j" ] = "Down"
        keymap_global[ "U0-k" ] = "Up"
        keymap_global[ "U0-l" ] = "Right"
        keymap_global[ "U0-S-h" ] = "S-Left"
        keymap_global[ "U0-S-j" ] = "S-Down"
        keymap_global[ "U0-S-k" ] = "S-Up"
        keymap_global[ "U0-S-l" ] = "S-Right"
        keymap_global[ "U0-C-h" ] = "C-Left"
        keymap_global[ "U0-C-j" ] = "C-Down"
        keymap_global[ "U0-C-k" ] = "C-Up"
        keymap_global[ "U0-C-l" ] = "C-Right"
        keymap_global[ "U0-C-S-h" ] = "C-S-Left"
        keymap_global[ "U0-C-S-j" ] = "C-S-Down"
        keymap_global[ "U0-C-S-k" ] = "C-S-Up"
        keymap_global[ "U0-C-S-l" ] = "C-S-Right"

        keymap_global[ "C-A" ] = keymap.defineMultiStrokeKeymap( "C-A" )
        keymap_global[ "C-A" ][ "a" ] = "C-A"
        keymap_global[ "C-A" ][ "C-A" ] = "Home"
        keymap_global[ "C-E" ] = "End"

