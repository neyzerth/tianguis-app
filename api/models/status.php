<?php
require_once('mysql.php');
require_once('message.php');

class Status {
    private static $select_all = "SELECT code, name, disable FROM status ORDER BY name";
    private static $select_one = "SELECT code, name, disable FROM status WHERE code = ?";
    private static $insert = "INSERT INTO status (code, name) VALUES (?, ?)";

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
            ? Message::get_message(0, 'Status added successfully')
            : Message::get_message(1, 'Could not add status');
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

        $statuses = [];
        while ($row = $result->fetch_assoc()) {
            $statuses[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'statuses' => $code ? ($statuses[0] ?? null) : $statuses
        ], JSON_PRETTY_PRINT);
    }
}
?>