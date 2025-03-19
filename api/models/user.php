<?php
    require_once('mysql.php');
    require_once('message.php');

    class User {
        //sql commands
        private static $select_all = '
            SELECT id, first_name, last_name, email, password, phone, role, created_at, disable, photo
            FROM user 
            ORDER BY first_name';
        private static $select_one = '
            SELECT id, first_name, last_name, email, password, phone, role, created_at, disable, photo
            FROM user 
            WHERE id = ?';
        private static $insert = '
            INSERT INTO user (first_name, last_name, email, password, phone, role, photo) 
            VALUES (?, ?, ?, ?, ?, ?, ?)';

        //attributes
        private $id;
        private $first_name;
        private $last_name;
        private $email;
        private $password;
        private $phone;
        private $role;
        private $created_at;
        private $disable;
        private $photo;

        //getters and setters
        public function get_id() { return $this->id; }
        public function set_id($value) { $this->id = $value; }
        public function get_first_name() { return $this->first_name; }
        public function set_first_name($value) { $this->first_name = $value; }
        public function get_last_name() { return $this->last_name; }
        public function set_last_name($value) { $this->last_name = $value; }
        public function get_email() { return $this->email; }
        public function set_email($value) { $this->email = $value; }
        public function get_password() { return $this->password; }
        public function set_password($value) { $this->password = $value; }
        public function get_phone() { return $this->phone; }
        public function set_phone($value) { $this->phone = $value; }
        public function get_role() { return $this->role; }
        public function set_role($value) { $this->role = $value; }
        public function get_created_at() { return $this->created_at; }
        public function set_created_at($value) { $this->created_at = $value; }
        public function get_disable() { return $this->disable; }
        public function set_disable($value) { $this->disable = $value; }
        public function get_photo() { return $this->photo; }
        public function set_photo($value) { $this->photo = $value; }

        //constructor
        public function __construct() {
            if (func_num_args() == 0) {
                $this->id = 0;
                $this->first_name = '';
                $this->last_name = '';
                $this->email = '';
                $this->password = '';
                $this->phone = '';
                $this->role = 'customer';
                $this->created_at = date('Y-m-d H:i:s');
                $this->disable = 0;
                $this->photo = 39; // default photo id
            }
            if (func_num_args() == 10) {
                $args = func_get_args();
                $this->id = $args[0];
                $this->first_name = $args[1];
                $this->last_name = $args[2];
                $this->email = $args[3];
                $this->password = $args[4];
                $this->phone = $args[5];
                $this->role = $args[6];
                $this->created_at = $args[7];
                $this->disable = $args[8];
                $this->photo = $args[9];
            }
        }

        //instance methods
        public function add() {
            $connection = MySqlConnection::get_connection();
            $command = $connection->prepare(self::$insert);
            $command->bind_param('ssssssi', 
                $this->first_name,
                $this->last_name,
                $this->email,
                $this->password,
                $this->phone,
                $this->role,
                $this->photo
            );
            if ($command->execute())
                return Message::get_message(0, 'User added successfully');
            else
                return Message::get_message(1, 'Could not add user');
        }

        public function to_json() {
            return json_encode(array(
                'id' => $this->id,
                'first_name' => $this->first_name,
                'last_name' => $this->last_name,
                'email' => $this->email,
                'password' => $this->password,
                'phone' => $this->phone,
                'role' => $this->role,
                'created_at' => $this->created_at,
                'disable' => $this->disable,
                'photo' => $this->photo
            ));
        }

        private function to_json_object() {
            return json_encode(array(
                'status' => 0,
                'user' => json_decode($this->to_json())
            ));
        }      

        private static function to_json_array($list) {
            return json_encode(array(
                'status' => 0,
                'users' => $list
            ));
        }
        
        //class methods
        public static function get() {
            $connection = MySqlConnection::get_connection();
            $returnValue = null;    
            
            if (func_num_args() == 0) {
                $list = Array();
                $command = $connection->prepare(self::$select_all);
                $command->execute();
                $command->bind_result($id, $first_name, $last_name, $email, $password, $phone, $role, $created_at, $disable, $photo);
                while($command->fetch()) {
                    $user = new User($id, $first_name, $last_name, $email, $password, $phone, $role, $created_at, $disable, $photo);
                    array_push($list, json_decode($user->to_json()));
                }
                $returnValue = self::to_json_array($list);
            }   

            if (func_num_args() == 1) {
                $id = func_get_arg(0);
                $command = $connection->prepare(self::$select_one);
                $command->bind_param('i', $id);
                $command->execute();
                $command->bind_result($id, $first_name, $last_name, $email, $password, $phone, $role, $created_at, $disable, $photo);
                if($command->fetch()) {
                    $user = new User($id, $first_name, $last_name, $email, $password, $phone, $role, $created_at, $disable, $photo);
                    $returnValue = $user->to_json_object();
                }
                else
                    $returnValue = Message::get_message(1, 'Could not find user');
            }       
            return $returnValue;
        }
    }
?>