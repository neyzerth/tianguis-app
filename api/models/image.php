<?php
require_once('mysql.php');
require_once('message.php');

class Image {
    private static $select_all = "SELECT id, url, `order`, created_at, tianguis, item, stand, user 
        FROM image ORDER BY created_at DESC";
    private static $select_one = "SELECT id, url, `order`, created_at, tianguis, item, stand, user 
        FROM image WHERE id = ?";
    private static $insert = "INSERT INTO image (url, `order`, tianguis, item, stand, user) 
        VALUES (?, ?, ?, ?, ?, ?)";

    public $id, $url, $order, $created_at, $tianguis, $item, $stand, $user;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->url = $data['url'] ?? '';
        $this->order = $data['order'] ?? null;
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->tianguis = $data['tianguis'] ?? null;
        $this->item = $data['item'] ?? null;
        $this->stand = $data['stand'] ?? null;
        $this->user = $data['user'] ?? null;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('siiiiii', 
            $this->url,
            $this->order,
            $this->tianguis,
            $this->item,
            $this->stand,
            $this->user
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Image added successfully')
            : Message::get_message(1, 'Could not add image');
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
        $images = [];

        while ($row = $result->fetch_assoc()) {
            $images[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'images' => $id ? ($images[0] ?? null) : $images
        ], JSON_PRETTY_PRINT);
    }
}