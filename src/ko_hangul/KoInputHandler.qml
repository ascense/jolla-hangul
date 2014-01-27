
import QtQuick 2.0
//import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import ".."
import "../.."

import "parser.js" as Parser

InputHandler {
    
    property string preedit
    
    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if (pressedKey.key === Qt.Key_Space) {
            if (preedit !== "") {
                commit(preedit + " ")

                if (keyboard.shiftState !== ShiftState.LockedShift) {
                    keyboard.shiftState = ShiftState.AutoShift
                }

                handled = true
            }
        } else if (pressedKey.key === Qt.Key_Return) {
            if (preedit !== "") {
                commit(preedit)
                handled = true
            }
        } else if (pressedKey.key === Qt.Key_Backspace && preedit !== "") {
            preedit = Parser.erase_jamo(preedit);
            MInputMethodQuick.sendPreedit(preedit)

            if (keyboard.shiftState !== ShiftState.LockedShift) {
                keyboard.shiftState = ShiftState.NoShift
            }

            handled = true
        } else if (pressedKey.text.length !== 0) {
            preedit = Parser.add_jamo(preedit, pressedKey.text)
            
            if (keyboard.shiftState !== ShiftState.LockedShift) {
                keyboard.shiftState = ShiftState.NoShift
            }

            if (preedit.length > 1)
                commit_partial(preedit[0], preedit[1]);
            else
                MInputMethodQuick.sendPreedit(preedit);

            handled = true
        }

        return handled
    }
    
    function reset() {
        preedit = ""
    }

    function commit(text) {
        MInputMethodQuick.sendCommit(text)
        reset()
    }

    function commit_partial(text, pe) {
        MInputMethodQuick.sendCommit(text)
        preedit = pe
        MInputMethodQuick.sendPreedit(preedit)
    }
}
