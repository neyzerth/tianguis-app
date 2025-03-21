<?php
require_once('mysql.php');
require_once('message.php');

class Tianguis {
    private static $select_all = "SELECT 
        id, name, address, 
        ST_AsText(location) as location,
        created_at, updated_at, disable 
        FROM tianguis ORDER BY id";
    private static $select_one = "SELECT 
        id, name, address, 
        ST_AsText(location) as location,
        created_at, updated_at, disable
        FROM tianguis WHERE id = ?";
    private static $insert = "INSERT INTO tianguis (name, address, location) 
        VALUES (?, ?, ST_GeomFromText(?, 4326))";

    public $id, $name, $address, $location, $created_at, $updated_at, $disable;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->name = $data['name'] ?? '';
        $this->address = $data['address'] ?? '';
        $this->location = $data['location'] ?? '';
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->updated_at = $data['updated_at'] ?? date('Y-m-d H:i:s');
        $this->disable = $data['disable'] ?? 0;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('sss', 
            $this->name,
            $this->address,
            $this->location
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Tianguis added successfully')
            : Message::get_message(1, 'Could not add tianguis');
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

        $tianguis = [];
        while ($row = $result->fetch_assoc()) {
            $tianguis[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'tianguis' => $id ? ($tianguis[0] ?? null) : $tianguis
        ], JSON_PRETTY_PRINT);
    }
}
?>