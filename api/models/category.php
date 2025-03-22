<?php
require_once('mysql.php');
require_once('message.php');

class Category {
    private static $select_all = "SELECT code, name, disable FROM category ORDER BY name";
    private static $select_one = "SELECT code, name, disable FROM category WHERE code = ?";
    private static $insert = "INSERT INTO category (code, name) VALUES (?, ?)";

    public $code, $name, $disable;

    public function __construct($data = []) {
        $this->code = $data['code'] ?? '';
        $this->name = $data['name'] ?? '';
        $this->disable = $data['disable'] ?? 0;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ss', 
            $this->code,
            $this->name
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Category added successfully')
            : Message::get_message(1, 'Could not add category');
    }

    public static function get($code = null) {
        $conn = MySqlConnection::get_connection();
        if ($code === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_one);
            $stmt->bind_param('s', $code);
        }

        if (!$stmt->execute()) {
            return Message::get_message(1, 'Error executing query: ' . $conn->error);
        }

        $result = $stmt->get_result();
        if (!$result) {
            return Message::get_message(1, 'Error getting result: ' . $conn->error);
        }

        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'categories' => $code ? ($categories[0] ?? null) : $categories
        ], JSON_PRETTY_PRINT);
    }
}
?>