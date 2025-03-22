<?php
require_once('mysql.php');
require_once('message.php');

class StandLocation {
    private static $select_all = "SELECT 
        id, address, ST_AsText(location) as location, tianguis_dependece,
        created_at, disable, tianguis, stand_info 
        FROM stand_location ORDER BY id";
    private static $select_one = "SELECT 
        id, address, ST_AsText(location) as location, tianguis_dependece,
        created_at, disable, tianguis, stand_info 
        FROM stand_location WHERE id = ?";
    private static $insert = "INSERT INTO stand_location 
        (address, location, tianguis_dependece, tianguis, stand_info) 
        VALUES (?, ST_GeomFromText(?, 4326), ?, ?, ?)";

    public $id, $address, $location, $tianguis_dependece, $created_at, $disable, $tianguis, $stand_info;

    public function __construct($data = []) {
        $this->id = $data['id'] ?? 0;
        $this->address = $data['address'] ?? '';
        $this->location = $data['location'] ?? '';
        $this->tianguis_dependece = $data['tianguis_dependece'] ?? 1;
        $this->created_at = $data['created_at'] ?? date('Y-m-d H:i:s');
        $this->disable = $data['disable'] ?? 0;
        $this->tianguis = $data['tianguis'] ?? null;
        $this->stand_info = $data['stand_info'] ?? 0;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('ssiii', 
            $this->address,
            $this->location,
            $this->tianguis_dependece,
            $this->tianguis,
            $this->stand_info
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Stand location added successfully')
            : Message::get_message(1, 'Could not add stand location');
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

        $locations = [];
        while ($row = $result->fetch_assoc()) {
            $locations[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'locations' => $id ? ($locations[0] ?? null) : $locations
        ], JSON_PRETTY_PRINT);
    }
}