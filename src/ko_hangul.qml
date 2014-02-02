
import QtQuick 2.0
import Sailfish.Silica 1.0
import "ko_hangul"
import ".."

KeyboardLayout {
    type: "ko_KR"
    
    property int setActive: 0;
    property int setSelectWidth: (portraitMode ? 55 : 105) * geometry.scaleRatio
    
    property variant setKeys: [[
        ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅔ", "ㅐ",
         "ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ",
         "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"],
        ["ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ", "ㅛ", "ㅕ", "ㅑ", "ㅒ", "ㅖ",
         "ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ",
         "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"]
    ], [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
         "a", "s", "d", "f", "g", "h", "j", "k", "l",
         "z", "x", "c", "v", "b", "n", "m"],
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
         "A", "S", "D", "F", "G", "H", "J", "K", "L",
         "Z", "X", "C", "V", "B", "N", "M"]
    ]];
    
    KoInputHandler {
        id: koInputHandler
    }
    
    Component.onCompleted: init()
    
    Connections {
        target: keyboard
        onInputHandlerChanged: handlerChanged()
    }
    
    function init() {
        // force onInputHandlerChanged signal by
        // making sure that the input handler was not
        // previously pasteInputHandler
        if (keyboard.allowLayoutChanges) {
            var oldHandler = keyboard.inputHandler
            keyboard.inputHandler = xt9Handler.item
            oldHandler.active = false
            keyboard.inputHandler.active = true
        }
    }
    
    function handlerChanged() {
        if (keyboard.allowLayoutChanges && keyboard.inputHandler == pasteInputHandler &&
                canvas.layoutRow.layout != null && canvas.layoutRow.layout.type == type) {
            var oldHandler = keyboard.inputHandler
            keyboard.inputHandler = koInputHandler
            oldHandler.active = false
            koInputHandler.active = true
        }
    }
    
    KeyboardRow {
        CharacterKey { caption: setKeys[setActive][0][0]; captionShifted: setKeys[setActive][1][0]; symView: "1"; symView2: "€"; accents: "ㅃ" }
        CharacterKey { caption: setKeys[setActive][0][1]; captionShifted: setKeys[setActive][1][1]; symView: "2"; symView2: "£"; accents: "ㅉ" }
        CharacterKey { caption: setKeys[setActive][0][2]; captionShifted: setKeys[setActive][1][2]; symView: "3"; symView2: "$"; accents: "ㄸ" }
        CharacterKey { caption: setKeys[setActive][0][3]; captionShifted: setKeys[setActive][1][3]; symView: "4"; symView2: "¥"; accents: "ㄲ" }
        CharacterKey { caption: setKeys[setActive][0][4]; captionShifted: setKeys[setActive][1][4]; symView: "5"; symView2: "₹"; accents: "ㅆ" }
        CharacterKey { caption: setKeys[setActive][0][5]; captionShifted: setKeys[setActive][1][5]; symView: "6"; symView2: "%" }
        CharacterKey { caption: setKeys[setActive][0][6]; captionShifted: setKeys[setActive][1][6]; symView: "7"; symView2: "<" }
        CharacterKey { caption: setKeys[setActive][0][7]; captionShifted: setKeys[setActive][1][7]; symView: "8"; symView2: ">" }
        CharacterKey { caption: setKeys[setActive][0][8]; captionShifted: setKeys[setActive][1][8]; symView: "9"; symView2: "["; accents: "ㅒ" }
        CharacterKey { caption: setKeys[setActive][0][9]; captionShifted: setKeys[setActive][1][9]; symView: "0"; symView2: "]"; accents: "ㅖ" }
    }

    KeyboardRow {
        CharacterKey { caption: setKeys[setActive][0][10]; captionShifted: setKeys[setActive][1][10]; symView: "*"; symView2: "`" }
        CharacterKey { caption: setKeys[setActive][0][11]; captionShifted: setKeys[setActive][1][11]; symView: "#"; symView2: "^" }
        CharacterKey { caption: setKeys[setActive][0][12]; captionShifted: setKeys[setActive][1][12]; symView: "+"; symView2: "|" }
        CharacterKey { caption: setKeys[setActive][0][13]; captionShifted: setKeys[setActive][1][13]; symView: "-"; symView2: "_" }
        CharacterKey { caption: setKeys[setActive][0][14]; captionShifted: setKeys[setActive][1][14]; symView: "="; symView2: "§" }
        CharacterKey { caption: setKeys[setActive][0][15]; captionShifted: setKeys[setActive][1][15]; symView: "("; symView2: "{" }
        CharacterKey { caption: setKeys[setActive][0][16]; captionShifted: setKeys[setActive][1][16]; symView: ")"; symView2: "}" }
        CharacterKey { caption: setKeys[setActive][0][17]; captionShifted: setKeys[setActive][1][17]; symView: "!"; symView2: "¡" }
        CharacterKey { caption: setKeys[setActive][0][18]; captionShifted: setKeys[setActive][1][18]; symView: "?"; symView2: "¿" }
    }

    KeyboardRow {
        ShiftKey { }
        
        CharacterKey { caption: setKeys[setActive][0][19]; captionShifted: setKeys[setActive][1][19]; symView: "@"; symView2: "«" }
        CharacterKey { caption: setKeys[setActive][0][20]; captionShifted: setKeys[setActive][1][20]; symView: "&"; symView2: "»" }
        CharacterKey { caption: setKeys[setActive][0][21]; captionShifted: setKeys[setActive][1][21]; symView: "/"; symView2: "\"" }
        CharacterKey { caption: setKeys[setActive][0][22]; captionShifted: setKeys[setActive][1][22]; symView: "\\"; symView2: "“" }
        CharacterKey { caption: setKeys[setActive][0][23]; captionShifted: setKeys[setActive][1][23]; symView: "'"; symView2: "”" }
        CharacterKey { caption: setKeys[setActive][0][24]; captionShifted: setKeys[setActive][1][24]; symView: ";"; symView2: "„" }
        CharacterKey { caption: setKeys[setActive][0][25]; captionShifted: setKeys[setActive][1][25]; symView: ":"; symView2: "~" }

        BackspaceKey {}
    }
    
    KeyboardRow {
        FunctionKey {
            id: koSymbolKey

            property int _charactersWhenPressed
            property bool _quickPicking

            caption: attributes.inSymView ? "가" : (setActive ? "?123" : "ABC")
            width: functionKeyWidth
            keyType: KeyType.SymbolKey

            onPressedChanged: {
                if (pressed && !keyboard.inSymView && keyboard.lastInitialKey === symbolKey) {
                    keyboard.deadKeyAccent = ""
                    keyboard.toggleSymbolMode()
                    _quickPicking = true
                } else {
                    _quickPicking = false
                }

                _charactersWhenPressed = keyboard.characterKeyCounter
            }

            onClicked: {
                if (!_quickPicking || keyboard.characterKeyCounter > _charactersWhenPressed) {
                    if (attributes.inSymView) {
                        keyboard.toggleSymbolMode()
                    } else {
                        if (setActive)
                            keyboard.toggleSymbolMode();
                        setActive = !setActive;
                    }
                }
            }

            Rectangle {
                color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
                opacity: parent.pressed ? 0.6 : 0.17
                radius: geometry.keyRadius

                anchors.fill: parent
                anchors.margins: Theme.paddingMedium
            }
        }
        CharacterKey {
            caption: ","
            captionShifted: ","
            width: punctuationKeyWidth
            fixedWidth: true
            separator: false
        }
        SpacebarKey {
            fixedWidth: true
        }
        CharacterKey {
            caption: "."
            captionShifted: "."
            width: punctuationKeyWidth
            fixedWidth: true
            separator: false
        }
        EnterKey {}
    }
}
