<?php

function controller_user($act, $d) {
    if ($act == 'edit_window') return User::user_edit_window($d);
    if ($act == 'edit_update') return User::user_edit_update($d);
    if ($act == 'delete_window') return User::user_delete_window($d);
    if ($act == 'delete_accept') return User::user_delete_accept($d);
    return '';
}
