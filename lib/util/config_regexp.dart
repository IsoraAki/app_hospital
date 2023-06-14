/*
 |--------------------------------------------------------------------------
 | REGEXP STRING AND NUMBER START
 |--------------------------------------------------------------------------
 */
const String EMAIL_REGEXP = r"^[a-z0-9'*+/=?^_`{|}~-]+(?:\.[a-z0-9'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$";
const String FULL_NAME_REGEXP = r'^[a-zA-Z0-9\s\+]*$';
const String PHONE_NUMBER_REGEXP = r'^-?[0-9]+$';
const String ONLY_LETTER = r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]';
const String ONLY_CHARACTER = r'^[a-z A-Z]+$';
const String ONLY_NUMBER = r'^[0-9]+$';
const String PASSPORT = r'^[a-z A-Z 0-9]+$';
