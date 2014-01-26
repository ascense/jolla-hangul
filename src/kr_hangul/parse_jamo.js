﻿
/**
/ Library for combining Hangul Jamo into syllables, based on:
/ http://gernot-katzers-spice-pages.com/var/korean_hangul_unicode.html
/ http://www.decodeunicode.org/en/hangul_jamo
/ http://www.unicode.org/faq/korean.html
*/

var _BASE_OFFS = 0xAC00;
var _COMP_OFFS = 0x3130;

var _JAMO_LEAD = 0x1100;
var _JAMO_VOWEL = 0x1161;
var _JAMO_TRAIL = 0x11A8;

var _VOWEL_DIV = 28;
var _LEAD_DIV = 588;


// map compatibility jamo (virtual keyboard rendering) to component jamo
var LEAD = {
    'ㄱ': 0x1100, 'ㄲ': 0x1101, 'ㄴ': 0x1102, 'ㄷ': 0x1103, 'ㄸ': 0x1104,
    'ㄹ': 0x1105, 'ㅁ': 0x1106, 'ㅂ': 0x1107, 'ㅃ': 0x1108, 'ㅅ': 0x1109,
    'ㅆ': 0x110A, 'ㅇ': 0x110B, 'ㅈ': 0x110C, 'ㅉ': 0x110D, 'ㅊ': 0x110E,
    'ㅋ': 0x110F, 'ㅌ': 0x1110, 'ㅍ': 0x1111, 'ㅎ': 0x1112
};
var VOWEL = {
    'ㅏ': 0x1161, 'ㅐ': 0x1162, 'ㅑ': 0x1163, 'ㅒ': 0x1164, 'ㅓ': 0x1165,
    'ㅔ': 0x1166, 'ㅕ': 0x1167, 'ㅖ': 0x1168, 'ㅗ': 0x1169, 'ㅛ': 0x116D,
    'ㅜ': 0x116E, 'ㅠ': 0x1172, 'ㅡ': 0x1173, 'ㅣ': 0x1175
};
var TRAIL = {
    'ㄱ': 0x11A8, 'ㄲ': 0x11A9, 'ㄴ': 0x11AB, 'ㄷ': 0x11AE, 'ㄹ': 0x11AF,
    'ㅁ': 0x11B7, 'ㅂ': 0x11B8, 'ㅅ': 0x11BA, 'ㅆ': 0x11BB, 'ㅇ': 0x11BC,
    'ㅈ': 0x11BD, 'ㅊ': 0x11BE, 'ㅋ': 0x11BF, 'ㅌ': 0x11C0, 'ㅍ': 0x11C1,
    'ㅎ': 0x11C2
};


function is_jamo(str) {
    if (typeof str !== "string")
        return false;
    
    if ((str.charCodeAt(0) >= _COMP_OFFS) && (str.charCodeAt(0) <= 0x318F))
        return true;
    return false;
}

function is_syllable(str) {
    if (typeof str !== "string")
        return false;
    
    if ((str.charCodeAt(0) >= _BASE_OFFS) && (str.charCodeAt(0) <= 0xD7A3))
        return true;
    return false;
}

function is_hangul(str) {
    if (is_jamo(str) || is_syllable(str))
        return true;
    return false;
}

// convert compatiblity jamo into component jamo
function get_component(str, table) {
    if (table[str] != null)
        return String.fromCharCode(table[str]);
    return str;
}

function normalise(str, table) {
    for (var jamo in table) {
        if (table[jamo] === str.charCodeAt(0))
            return jamo;
    }
    return str;
}

/**
/ Get base offset for jamo type
/ Valid values: _JAMO_LEAD, _JAMO_VOWEL, _JAMO_TRAIL
*/
function get_base(str) {
    var code = str.charCodeAt(0);
    if (code >= _JAMO_TRAIL)
        return _JAMO_TRAIL;
    else if (code >= _JAMO_VOWEL)
        return _JAMO_VOWEL;
    else if (code >= _JAMO_LEAD)
        return _JAMO_LEAD;
    return -1;
}

// merge jamo into a syllable block
function join(lead, vowel, trail) {
    if (is_jamo(lead))
        lead = get_component(lead, LEAD);
    if (is_jamo(vowel))
        vowel = get_component(vowel, VOWEL);
    if (is_jamo(trail))
        trail = get_component(trail, TRAIL);

    var lead_offs = lead.charCodeAt(0) - _JAMO_LEAD;
    var vowel_offs = vowel.charCodeAt(0) - _JAMO_VOWEL;
    var trail_offs = -1;

    if (trail !== "")
        trail_offs = trail.charCodeAt(0) - _JAMO_TRAIL;

    return String.fromCharCode(
            trail_offs + vowel_offs*_VOWEL_DIV +
            lead_offs*_LEAD_DIV +
            _BASE_OFFS + 1
    );
}

// split a syllable block into component jamo
function split(str) {
    var char_offs = str.charCodeAt(0) - _BASE_OFFS;
    var trail_offs = Math.floor(char_offs%_VOWEL_DIV - 1);
    var vowel_offs = Math.floor((char_offs - trail_offs)%_LEAD_DIV / _VOWEL_DIV);
    var lead_offs = Math.floor(char_offs/_LEAD_DIV);
    
    var trail = "";
    
    if (trail_offs !== -1)
        trail = normalise(String.fromCharCode(_JAMO_TRAIL + trail_offs), TRAIL);
    
    return [
            normalise(String.fromCharCode(_JAMO_LEAD + lead_offs), LEAD),
            normalise(String.fromCharCode(_JAMO_VOWEL + vowel_offs), VOWEL),
            trail
    ];
}

// merge new jamo with the existing string
function parse_jamo(str, jamo) {
    // make sure merging is actually a valid option
    if (is_jamo(jamo) && is_hangul(str)) {
        
        // merge jamo with jamo
        if (is_jamo(str)) {
            var lead = get_component(str, LEAD);
            var vowel = get_component(jamo, VOWEL);
            
            if ((get_base(lead) === _JAMO_LEAD) && (get_base(vowel) === _JAMO_VOWEL))
                return join(lead, vowel, '');
        
        // merge syllable with jamo
        } else {
            var buffer = split(str);
            
            // merging vowel to existing syllable
            if (get_base(get_component(jamo, VOWEL)) === _JAMO_VOWEL) {
                // if syllable has padchim, split into two complete syllables:
                if (buffer[2] !== "") {
                    // verify that the padchim is a legal initial consonant:
                    if (get_component(buffer[2], LEAD) !== buffer[2])
                        return join(buffer[0], buffer[1], '') + join(normalise(buffer[2], TRAIL), jamo, '');
                    return str + jamo;
                }
                
                // attempt vowel mergers:
                if (buffer[1] === 'ㅗ') {
                    if (jamo === 'ㅏ') return join(buffer[0], String.fromCharCode(0x116A), '');
                    if (jamo === 'ㅐ') return join(buffer[0], String.fromCharCode(0x116B), '');
                    if (jamo === 'ㅣ') return join(buffer[0], String.fromCharCode(0x116C), '');
                } else if (buffer[1] === 'ㅜ') {
                    if (jamo === 'ㅓ') return join(buffer[0], String.fromCharCode(0x116F), '');
                    if (jamo === 'ㅔ') return join(buffer[0], String.fromCharCode(0x1170), '');
                    if (jamo === 'ㅣ') return join(buffer[0], String.fromCharCode(0x1171), '');
                } else if (buffer[1] === 'ㅡ') {
                    if (jamo === 'ㅣ') return join(buffer[0], String.fromCharCode(0x1174), ''); 
                }
                    
            // merging consonant to existing syllable
            } else if (get_base(get_component(jamo, TRAIL)) === _JAMO_TRAIL) {
                if (buffer[2] === "") {
					// verify that the consonant is a legal trailing consonant:
					if (get_component(jamo, TRAIL) !== jamo)
						return join(buffer[0], buffer[1], jamo);
					return str + jamo;
				}
                
                // attempt consonant mergers:
                if (buffer[2] === 'ㄱ') {
                    if (jamo === 'ㅅ') return join(buffer[0], buffer[1], String.fromCharCode(0x11AA));
                } else if (buffer[2] === 'ㄴ') {
                    if (jamo === 'ㅈ') return join(buffer[0], buffer[1], String.fromCharCode(0x11AC));
                    if (jamo === 'ㅎ') return join(buffer[0], buffer[1], String.fromCharCode(0x11AD));
                } else if (buffer[2] === 'ㄹ') {
                    if (jamo === 'ㄱ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B0));
                    if (jamo === 'ㅁ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B1));
                    if (jamo === 'ㅂ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B2));
                    if (jamo === 'ㅅ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B3));
                    if (jamo === 'ㅌ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B4));
                    if (jamo === 'ㅍ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B5));
                    if (jamo === 'ㅎ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B6));
                } else if (buffer[2] === 'ㅂ') {
                    if (jamo === 'ㅅ') return join(buffer[0], buffer[1], String.fromCharCode(0x11B9));
                }
            }
        }
    }
    
    return str + jamo;
}

// erase jamo from the syllable under creation
function erase(str) {
    if (is_jamo(str) || !is_hangul(str))
        return "";

    var buffer = split(str);    
    if (buffer[2] !== "")
        return join(buffer[0], buffer[1], "");
    else
        return buffer[0];
}
