/*
 * Copyright (C) 2014 Henry Carlson
 * Copyright (C) 2013 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import "../.."

KeyboardRow {
    id: koSpacebarRow
    
    FunctionKey {
        id: koSymbolKey

        caption: attributes.inSymView ? "가" : (setActive ? "?123" : "ABC")
        width: functionKeyWidth
        keyType: KeyType.SymbolKey

        onClicked: {
            // hack to get 3-way set selection for symbol key
            if (attributes.inSymView) {
                keyboard.toggleSymbolMode()
            } else {
                if (setActive)
                    keyboard.toggleSymbolMode();
                setActive = !setActive;
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
        separator: 0
    }
    SpacebarKey {}
    SpacebarKey {
        active: splitActive
        languageLabel: ""
    }
    CharacterKey {
        caption: "."
        captionShifted: "."
        width: punctuationKeyWidth
        fixedWidth: true
        separator: 0
    }
    EnterKey {}
}
