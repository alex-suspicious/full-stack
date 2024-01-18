<?php

class User {

    // GENERAL

    public static function user_info($d) {
        // vars
        $user_id = is_array($d) ? ( isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0 ) : $d;
        $phone = isset($d['phone']) ? preg_replace('~\D+~', '', $d['phone']) : 0;
        // where
        if ($user_id) $where = "user_id='".$user_id."'";
        else if ($phone) $where = "phone='".$phone."'";
        else return [];
        // info
        $q = DB::query("SELECT user_id, phone, access, first_name, last_name, email, phone, plot_id FROM users WHERE ".$where." LIMIT 1;") or die (DB::error());
        if ($row = DB::fetch_row($q)) {
            return [
                'user_id' => (int) $row['user_id'],
                'access' => (int) $row['access'],
                'first_name' => $row['first_name'],
                'last_name' => $row['last_name'],
                'email' => $row['email'],
                'phone' => $row['phone'],
                'plot_id' => $row['plot_id'],
            ];
        } else {
            return [
                'user_id' => 0,
                'access' => 0,
                'first_name' => '',
                'last_name' => '',
                'email' => '',
                'phone' => '',
                'plot_id' => ''
            ];
        }
    }

                
    public static function users_list($d = []) {
        // vars
        $search = isset($d['search']) && trim($d['search']) ? $d['search'] : '';
        $offset = isset($d['offset']) && is_numeric($d['offset']) ? $d['offset'] : 0;
        $limit = 20;
        $items = [];
        // where
        $where = [];
        if ($search) $where[] = "CONCAT_WS( phone, first_name, last_name, email ) LIKE '%".$search."%'";
        $where = $where ? "WHERE ".implode(" AND ", $where) : "";
        // info
        $q = DB::query("SELECT user_id, plot_id, first_name, last_name, email, phone, last_login
            FROM users ".$where." ORDER BY user_id LIMIT ".$offset.", ".$limit.";") or die (DB::error());
        while ($row = DB::fetch_row($q)) {
            $items[] = [
                'user_id' => (int) $row['user_id'],
                'plot_id' => $row['plot_id'],
                'first_name' => $row['first_name'],
                'last_name' => $row['last_name'],
                'email' => $row['email'],
                'phone' => $row['phone'],
                'last_login' => $row['last_login']
            ];
        }
        // paginator
        $q = DB::query("SELECT count(*) FROM users ".$where.";");
        $count = ($row = DB::fetch_row($q)) ? $row['count(*)'] : 0;
        $url = 'users?';
        if ($search) $url .= '&search='.$search;
        paginator($count, $offset, $limit, $url, $paginator);
        // output
        return ['items' => $items, 'paginator' => $paginator];
    }

    public static function users_fetch($d = []) {
        $info = User::users_list($d);
        HTML::assign('users', $info['items']);
        return ['html' => HTML::fetch('./partials/users_table.html'), 'paginator' => $info['paginator']];
    }

    public static function users_list_plots($number) {
        // vars
        $items = [];
        // info
        $q = DB::query("SELECT user_id, plot_id, first_name, email, phone
            FROM users WHERE plot_id LIKE '%".$number."%' ORDER BY user_id;") or die (DB::error());
        while ($row = DB::fetch_row($q)) {
            $plot_ids = explode(',', $row['plot_id']);
            $val = false;
            foreach($plot_ids as $plot_id) if ($plot_id == $number) $val = true;
            if ($val) $items[] = [
                'user_id' => (int) $row['user_id'],
                'first_name' => $row['first_name'],
                'email' => $row['email'],
                'phone_str' => phone_formatting($row['phone'])
            ];
        }
        // output
        return $items;
    }


    // ACTIONS

    public static function user_edit_window($d = []) {
        $user_id = isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0;
        HTML::assign('user', User::user_info($user_id));
        return ['html' => HTML::fetch('./partials/user_edit.html')];
    }

    public static function user_edit_update($d = []) {
        // vars
        $user_id = isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0;
        $first_name = isset($d['first_name']) ? $d['first_name'] : '';
        $last_name = isset($d['last_name']) ? $d['last_name'] : '';
        $email = isset($d['email']) ? $d['email'] : '';
        $phone = isset($d['phone']) ? $d['phone'] : '0';
        $plot_id = isset($d['plot_id']) ? $d['plot_id'] : '';
        $offset = isset($d['offset']) ? preg_replace('~\D+~', '', $d['offset']) : 0;
        // update
        if ($user_id) {
            $set = [];
            $set[] = "first_name='".$first_name."'";
            $set[] = "last_name='".$last_name."'";
            $set[] = "email='".$email."'";
            $set[] = "phone=".$phone."";
            $set[] = "plot_id='".$plot_id."'";
            $set = implode(", ", $set);
            DB::query("UPDATE users SET ".$set." WHERE user_id='".$user_id."' LIMIT 1;") or die (DB::error());
        } else {
            DB::query("INSERT INTO users (
                first_name,
                last_name,
                email,
                phone,
                plot_id
            ) VALUES (
                '".$first_name."',
                '".$last_name."',
                '".$email."',
                '".$phone."',
                '".$plot_id."'
            );") or die (DB::error());
        }
        // output
        return User::users_fetch(['offset' => $offset]);
    }

    public static function user_delete_window($d = []) {
        $user_id = isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0;
        HTML::assign('user', User::user_info($user_id));
        return ['html' => HTML::fetch('./partials/user_delete.html')];
    }

    public static function user_delete_accept($d = []) {
        // vars
        $user_id = isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0;
        // update
        if ($user_id) {
            DB::query("DELETE FROM users WHERE user_id='".$user_id."';") or die (DB::error());
        }
        // output
        return User::users_fetch(['offset' => $offset]);
    }

    private static function plot_status_str($id) {
        if ($id == 1) return 'Reserved';
        if ($id == 2) return 'Sold';
        return 'Free';
    }
}
