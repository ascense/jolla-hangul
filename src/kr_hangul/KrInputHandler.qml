
import QtQuick 2.0
//import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import ".."
import "../.."

import "parse_jamo.js" as Parser

InputHandler {
    
    property string preedit

    topItem: Component {
        Row {
            SilicaListView {
                id: listView
                model: preedit
                orientation: ListView.Horizontal
                width: parent.width // - moreButton.width
                // I have no idea why height: 70 makes the top row smaller
                // than for Xt9CpInputHandler and Xt9InputHandler even though
                // they both specify 70 as well
                height: 80 // 70
                delegate: BackgroundItem {
                    id: backGround
                    onClicked: accept(model.index) //selectPhrase(model.text, model.index)
                    width: candidateText.width + Theme.paddingLarge * 2
                    height: parent ? parent.height : 0

                    Text {
                        id: candidateText
                        anchors.centerIn: parent
                        color: (backGround.down || index === 0) ? Theme.highlightColor : Theme.primaryColor
                        font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
                        text: model.text // preedit
                    }
                }
            }
        }
    }
    
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
            preedit = Parser.erase(preedit);
            MInputMethodQuick.sendPreedit(preedit)

            if (keyboard.shiftState !== ShiftState.LockedShift) {
                keyboard.shiftState = ShiftState.NoShift
            }

            handled = true
        } else if (pressedKey.text.length !== 0) {
            preedit = Parser.parse_jamo(preedit, pressedKey.text)
            
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
