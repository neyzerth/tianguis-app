<?php
require_once('mysql.php');
require_once('message.php');

class Stand {
    private static $select_all = "SELECT id, name, description, created_at, disable, owner, category 
        FROM stand ORDER BY name";
    private static $select_one = "SELECT id, name, description, created_at, disable, owner, category 
        FROM stand WHERE id = ?";
    private static $insert = "INSERT INTO stand (name, description, owner, category) 
        VALUES (?, ?, ?, ?)";

    public $id, $name, $description, $created_at, $disable, $owner, $category;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->name = $data['name'] ?? '';
        $this->description = $data['description'] ?? '';
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->disable = $data['disable'] ?? 0;
        $this->owner = $data['owner'] ?? 0;
        $this->category = $data['category'] ?? null;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ssis', 
            $this->name,
            $this->description,
            $this->owner,
            $this->category
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Stand added successfully')
            : Message::get_message(1, 'Could not add stand');
    }

    public static function get($id = null) {
        $conn = MySqlConnection::get_connection();
        if ($id === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_one);
            $stmt->bind_param('i', $id);
        }

        if (!$stmt->execute()) {
            return Message::get_message(1, 'Error executing query: ' . $conn->error);
        }

        $result = $stmt->get_result();
        if (!$result) {
            return Message::get_message(1, 'Error getting result: ' . $conn->error);
        }

        $stands = [];
        while ($row = $result->fetch_assoc()) {
            $stands[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'stands' => $id ? ($stands[0] ?? null) : $stands
        ], JSON_PRETTY_PRINT);
    }
}