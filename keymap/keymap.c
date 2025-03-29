#include QMK_KEYBOARD_H

enum my_layers {
	_COLEMAK,
	_QWERTY,
	_LOWER,
	_RAISE,
	_ADJUST,
};

enum my_keycodes {
	LANG1 = SAFE_RANGE,
	LANG2,
	HEX1,
	HEX2,
};

#define LOWER LT(_LOWER, KC_SPC)
#define LLOWER LT(_ADJUST, KC_TAB)
#define RAISE OSL(_RAISE)
#define RRAISE MO(_ADJUST)

#define TMUX C(KC_B)
#define OSMCMD OSM(MOD_LGUI)
#define OSMOPT OSM(MOD_LALT)
#define OSMCTL OSM(MOD_LCTL)
#define OSMSFT OSM(MOD_LSFT)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
	[_COLEMAK] = LAYOUT(
			KC_Q,    KC_W,    KC_F,    KC_P,    KC_B,                      KC_J,    KC_L,    KC_U,    KC_Y,    KC_QUOT,
			KC_A,    KC_R,    KC_S,    KC_T,    KC_G,                      KC_M,    KC_N,    KC_E,    KC_I,    KC_O,
			KC_Z,    KC_X,    KC_C,    KC_D,    KC_V,    _______, _______, KC_K,    KC_H,    KC_COMM, KC_DOT,  KC_ENT,
			OSMCMD,  OSMOPT,  OSMCTL,  KC_BSPC, LOWER,   LANG1,   LANG2,   RAISE,   OSMSFT,  OSMCTL,  OSMOPT,  OSMCMD
			),

	[_QWERTY] = LAYOUT(
			KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                      KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,
			KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                      KC_H,    KC_J,    KC_K,    KC_L,    KC_QUOT,
			KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    _______, _______, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_ENT,
			OSMCMD,  OSMOPT,  OSMCTL,  KC_BSPC, LOWER,   LANG1,   LANG2,   RAISE,   OSMSFT,  OSMCTL,  OSMOPT,  OSMCMD
			),

	[_RAISE] = LAYOUT(
			KC_LBRC, KC_LCBR, KC_RCBR, KC_RBRC, KC_CIRC,                   KC_DLR,  KC_AT,   KC_PERC, KC_HASH, KC_GRV,
			KC_PLUS, KC_MINS, KC_EQL,  KC_ASTR, KC_SLSH,                   KC_TILD, KC_UNDS, KC_QUES, KC_EXLM, KC_BSLS,
			KC_LT,   KC_LPRN, KC_RPRN, KC_GT,   KC_AMPR, _______, _______, KC_PIPE, KC_COLN, TMUX,    KC_SCLN, _______,
			_______, _______, _______, KC_ESC,  LLOWER,  _______, _______, _______, KC_LEFT, _______, _______, _______
			),

	[_LOWER] = LAYOUT(
			KC_HOME, KC_PGDN, KC_PGUP, KC_END,  KC_BRIU,                   S(KC_E), KC_7,    KC_8,    KC_9,    S(KC_F),
			KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_MPLY,                   S(KC_C), KC_4,    KC_5,    KC_6,    S(KC_D),
			KC_MRWD, KC_VOLD, KC_VOLU, KC_MFFD, KC_BRID, _______, _______, S(KC_A), KC_1,    KC_2,    KC_3,    S(KC_B),
			_______, _______, _______, KC_DEL,  _______, _______, _______, RRAISE,  KC_0,    KC_DOT,  HEX1,    HEX2
			),

	[_ADJUST] = LAYOUT(
			_______, _______, _______, _______, _______,                   KC_F14,  KC_F7,   KC_F8,   KC_F9,   KC_F15,
			_______, _______, _______, _______, _______,                   KC_F12,  KC_F4,   KC_F5,   KC_F6,   KC_F13,
			_______, KC_INS,  KC_CAPS, _______, _______, _______, _______, KC_F10,  KC_F1,   KC_F2,   KC_F3,   KC_F11,
			_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
			),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	if (record->event.pressed) {
		switch (keycode) {
			case LANG1:
				tap_code16(KC_CAPS);
				if (get_highest_layer(default_layer_state) == _COLEMAK)
					set_single_persistent_default_layer(_QWERTY);
				else
					set_single_persistent_default_layer(_COLEMAK);
				return false;
			case LANG2:
				if (get_highest_layer(default_layer_state) == _COLEMAK)
					set_single_persistent_default_layer(_QWERTY);
				else
					set_single_persistent_default_layer(_COLEMAK);
				return false;
			case HEX1:
				tap_code16(KC_0);
				tap_code16(KC_X);
				return false;
			case HEX2:
				tap_code16(KC_BSLS);
				tap_code16(KC_X);
				return false;	
		}
	}
	return true;
}
