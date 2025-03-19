<?php
    require_once('./config/config.php');
    class MySqlConnection {
        public static function get_connection() {
            //connection
            $connection = mysqli_connect(
                Config::$mysql_server,
                Config::$mysql_user,
                Config::$mysql_password,
                Config::$mysql_database
            );
            //test connection
            if ($connection === null) {
                echo 'Could not connect to MySql Server';
                die;
            }
            else
                return $connection;
        }
    }
?>