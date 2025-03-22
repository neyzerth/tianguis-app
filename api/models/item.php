<?php
require_once('mysql.php');
require_once('message.php');

class Item {
    private static $select_all = "SELECT 
        id, name, description, price, selled, created_at, updated_at, 
        disable, stand, owner, status, category 
        FROM item ORDER BY created_at DESC";
    private static $select_one = "SELECT 
        id, name, description, price, selled, created_at, updated_at, 
        disable, stand, owner, status, category 
        FROM item WHERE id = ?";
    private static $insert = "INSERT INTO item 
        (name, description, price, stand, owner, status, category) 
        VALUES (?, ?, ?, ?, ?, ?, ?)";

    public $id, $name, $description, $price, $selled, $created_at, $updated_at;
    public $disable, $stand, $owner, $status, $category;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->name = $data['name'] ?? '';
        $this->description = $data['description'] ?? '';
        $this->price = $data['price'] ?? 0.0;
        $this->selled = $data['selled'] ?? 0;
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->updated_at = $data['updated_at'] ?? date('Y-m-d H:i:s');
        $this->disable = $data['disable'] ?? 0;
        $this->stand = $data['stand'] ?? null;
        $this->owner = $data['owner'] ?? 0;
        $this->status = $data['status'] ?? null;
        $this->category = $data['category'] ?? null;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ssdiiss', 
            $this->name,
            $this->description,
            $this->price,
            $this->stand,
            $this->owner,
            $this->status,
            $this->category
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Item added successfully')
            : Message::get_message(1, 'Could not add item');
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
            return Message::get_message(1, 'Error executing query');
        }

        $result = $stmt->get_result();
        $items = [];

        while ($row = $result->fetch_assoc()) {
            $items[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'items' => $id ? ($items[0] ?? null) : $items
        ], JSON_PRETTY_PRINT);
    }
}