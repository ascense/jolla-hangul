
import QtQuick 2.0
import Sailfish.Silica 1.0
import "ko_hangul"
import ".."

KeyboardLayout {
    type: "ko_KR"
    
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
        CharacterKey { caption: "ㅂ"; captionShifted: "ㅃ"; symView: "1"; symView2: "€" }
        CharacterKey { caption: "ㅈ"; captionShifted: "ㅉ"; symView: "2"; symView2: "£" }
        CharacterKey { caption: "ㄷ"; captionShifted: "ㄸ"; symView: "3"; symView2: "$"; accents: "eèéêë€"; accentsShifted: "EÈÉÊË€" }
        CharacterKey { caption: "ㄱ"; captionShifted: "ㄲ"; symView: "4"; symView2: "¥" }
        CharacterKey { caption: "ㅅ"; captionShifted: "ㅆ"; symView: "5"; symView2: "₹"; accents: "tþ"; accentsShifted: "TÞ" }
        CharacterKey { caption: "ㅛ"; captionShifted: "ㅛ"; symView: "6"; symView2: "%"; accents: "yý¥"; accentsShifted: "YÝ¥" }
        CharacterKey { caption: "ㅕ"; captionShifted: "ㅕ"; symView: "7"; symView2: "<"; accents: "uûùúü"; accentsShifted: "UÛÙÚÜ" }
        CharacterKey { caption: "ㅑ"; captionShifted: "ㅑ"; symView: "8"; symView2: ">"; accents: "iîïìí"; accentsShifted: "IÎÏÌÍ" }
        CharacterKey { caption: "ㅐ"; captionShifted: "ㅒ"; symView: "9"; symView2: "["; accents: "oöôòó"; accentsShifted: "OÖÔÒÓ" }
        CharacterKey { caption: "ㅔ"; captionShifted: "ㅖ"; symView: "0"; symView2: "]" }
    }

    KeyboardRow {
        CharacterKey { caption: "ㅁ"; captionShifted: "ㅁ"; symView: "*"; symView2: "`"; accents: "aäàâáãå"; accentsShifted: "AÄÀÂÁÃÅ"}
        CharacterKey { caption: "ㄴ"; captionShifted: "ㄴ"; symView: "#"; symView2: "^"; accents: "sß$"; accentsShifted: "S$" }
        CharacterKey { caption: "ㅇ"; captionShifted: "ㅇ"; symView: "+"; symView2: "|"; accents: "dð"; accentsShifted: "DÐ" }
        CharacterKey { caption: "ㄹ"; captionShifted: "ㄹ"; symView: "-"; symView2: "_" }
        CharacterKey { caption: "ㅎ"; captionShifted: "ㅎ"; symView: "="; symView2: "§" }
        CharacterKey { caption: "ㅗ"; captionShifted: "ㅗ"; symView: "("; symView2: "{" }
        CharacterKey { caption: "ㅓ"; captionShifted: "ㅓ"; symView: ")"; symView2: "}" }
        CharacterKey { caption: "ㅏ"; captionShifted: "ㅏ"; symView: "!"; symView2: "¡" }
        CharacterKey { caption: "ㅣ"; captionShifted: "ㅣ"; symView: "?"; symView2: "¿" }
    }

    KeyboardRow {
        ShiftKey { }
        
        CharacterKey { caption: "ㅋ"; captionShifted: "ㅋ"; symView: "@"; symView2: "«" }
        CharacterKey { caption: "ㅌ"; captionShifted: "ㅌ"; symView: "&"; symView2: "»" }
        CharacterKey { caption: "ㅊ"; captionShifted: "ㅊ"; symView: "/"; symView2: "\""; accents: "cç"; accentsShifted: "CÇ" }
        CharacterKey { caption: "ㅍ"; captionShifted: "ㅍ"; symView: "\\"; symView2: "“" }
        CharacterKey { caption: "ㅠ"; captionShifted: "ㅠ"; symView: "'"; symView2: "”" }
        CharacterKey { caption: "ㅜ"; captionShifted: "ㅜ"; symView: ";"; symView2: "„"; accents: "nñ"; accentsShifted: "NÑ" }
        CharacterKey { caption: "ㅡ"; captionShifted: "ㅡ"; symView: ":"; symView2: "~" }

        BackspaceKey {}
    }
    
    SpacebarRow { }
}
