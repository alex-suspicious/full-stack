<?php

class User {

    // GENERAL

    public static function user_info($d) {
        // vars
        $user_id = isset($d['user_id']) && is_numeric($d['user_id']) ? $d['user_id'] : 0;
        $phone = isset($d['phone']) ? preg_replace('~\D+~', '', $d['phone']) : 0;
        // where
        if ($user_id) $where = "user_id='".$user_id."'";
        else if ($phone) $where = "phone='".$phone."'";
        else return [];
        // info
        $q = DB::query("SELECT user_id, phone, access FROM users WHERE ".$where." LIMIT 1;") or die (DB::error());
        if ($row = DB::fetch_row($q)) {
            return [
                'id' => (int) $row['user_id'],
                'access' => (int) $row['access']
            ];
        } else {
            return [
                'id' => 0,
                'access' => 0
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
                'id' => (int) $row['user_id'],
                'plot_id' => (int) $row['plot_id'],
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
                'id' => (int) $row['user_id'],
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
        $plot_id = isset($d['plot_id']) && is_numeric($d['plot_id']) ? $d['plot_id'] : 0;
        $status = isset($d['status']) && is_numeric($d['status']) ? $d['status'] : 0;
        $billing = isset($d['billing']) && in_array($d['billing'], [0,1]) ? $d['billing'] : 0;
        $number = isset($d['number']) && trim($d['number']) ? trim($d['number']) : '';
        $size = isset($d['size']) ? preg_replace('~\D+~', '', $d['size']) : 0;
        $price = isset($d['price']) ? preg_replace('~\D+~', '', $d['price']) : 0;
        $offset = isset($d['offset']) ? preg_replace('~\D+~', '', $d['offset']) : 0;
        // update
        if ($plot_id) {
            $set = [];
            $set[] = "status='".$status."'";
            $set[] = "billing='".$billing."'";
            $set[] = "number='".$number."'";
            $set[] = "size='".$size."'";
            $set[] = "price='".$price."'";
            $set[] = "updated='".Session::$ts."'";
            $set = implode(", ", $set);
            DB::query("UPDATE plots SET ".$set." WHERE plot_id='".$plot_id."' LIMIT 1;") or die (DB::error());
        } else {
            DB::query("INSERT INTO plots (
                status,
                billing,
                number,
                size,
                price,
                updated
            ) VALUES (
                '".$status."',
                '".$billing."',
                '".$number."',
                '".$size."',
                '".$price."',
                '".Session::$ts."'
            );") or die (DB::error());
        }
        // output
        return Plot::plots_fetch(['offset' => $offset]);
    }

    private static function plot_status_str($id) {
        if ($id == 1) return 'Reserved';
        if ($id == 2) return 'Sold';
        return 'Free';
    }
}
