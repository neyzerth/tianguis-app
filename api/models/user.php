<?php
require_once('mysql.php');
require_once('message.php');

class User {
    private static $select_all = "SELECT 
        id, first_name, last_name, email, password, phone, role, created_at, disable, photo 
        FROM user ORDER BY first_name";
    private static $select_one = "SELECT 
        id, first_name, last_name, email, password, phone, role, created_at, disable, photo
        FROM user WHERE id = ?";
    private static $insert = "INSERT INTO user (first_name, last_name, email, password, phone, role, photo) 
        VALUES (?, ?, ?, ?, ?, ?, ?)";

    public $id, $first_name, $last_name, $email, $password, $phone, $role, $created_at, $disable, $photo;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->first_name = $data['first_name'] ?? '';
        $this->last_name = $data['last_name'] ?? '';
        $this->email = $data['email'] ?? '';
        $this->password = $data['password'] ?? '';
        $this->phone = $data['phone'] ?? '';
        $this->role = $data['role'] ?? 'customer';
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->disable = $data['disable'] ?? 0;
        $this->photo = $data['photo'] ?? 39;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ssssssi', 
            $this->first_name,
            $this->last_name,
            $this->email,
            $this->password,
            $this->phone,
            $this->role,
            $this->photo
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'User added successfully')
            : Message::get_message(1, 'Could not add user');
    }

    public static function get($id = null) {
        $conn = MySqlConnection::get_connection();
        if ($id === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_one);
            $stmt->bind_param('i', $id);
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $users = [];

        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'users' => $id ? ($users[0] ?? null) : $users],
             JSON_PRETTY_PRINT
        );
    }
}
?>
