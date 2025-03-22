<?php
require_once('mysql.php');
require_once('message.php');

class Favorite {
    private static $select_all = "SELECT item, user FROM favorite ORDER BY item";
    private static $select_one = "SELECT item, user FROM favorite WHERE item = ? AND user = ?";
    private static $insert = "INSERT INTO favorite (item, user) VALUES (?, ?)";
    private static $delete = "DELETE FROM favorite WHERE item = ? AND user = ?";

    public $item, $user;

    public function __construct($data = []) {
        $this->item = $data['item'] ?? 0;
        $this->user = $data['user'] ?? 0;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ii', 
            $this->item,
            $this->user
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Favorite added successfully')
            : Message::get_message(1, 'Could not add favorite');
    }

    public function delete() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$delete);
        $stmt->bind_param('ii', 
            $this->item,
            $this->user
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Favorite removed successfully')
            : Message::get_message(1, 'Could not remove favorite');
    }

    public static function get($item = null, $user = null) {
        $conn = MySqlConnection::get_connection();
        if ($item === null || $user === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_one);
            $stmt->bind_param('ii', $item, $user);
        }

        if (!$stmt->execute()) {
            return Message::get_message(1, 'Error executing query');
        }

        $result = $stmt->get_result();
        $favorites = [];

        while ($row = $result->fetch_assoc()) {
            $favorites[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'favorites' => $item ? ($favorites[0] ?? null) : $favorites
        ], JSON_PRETTY_PRINT);
    }
}