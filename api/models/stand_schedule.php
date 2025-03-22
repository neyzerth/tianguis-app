<?php
require_once('mysql.php');
require_once('message.php');

class StandSchedule {
    private static $select_all = "SELECT 
        day, stand, open_time, close_time, tianguis_dependence 
        FROM stand_schedule ORDER BY stand, 
        FIELD(day, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')";
    private static $select_one = "SELECT 
        day, stand, open_time, close_time, tianguis_dependence 
        FROM stand_schedule WHERE stand = ?";
    private static $insert = "INSERT INTO stand_schedule 
        (day, stand, open_time, close_time, tianguis_dependence) 
        VALUES (?, ?, ?, ?, ?)";

    public $day, $stand, $open_time, $close_time, $tianguis_dependence;

    public function __construct($data = []) {
        $this->day = $data['day'] ?? '';
        $this->stand = $data['stand'] ?? 0;
        $this->open_time = $data['open_time'] ?? null;
        $this->close_time = $data['close_time'] ?? null;
        $this->tianguis_dependence = $data['tianguis_dependence'] ?? 1;
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('sissi', 
            $this->day,
            $this->stand,
            $this->open_time,
            $this->close_time,
            $this->tianguis_dependence
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Schedule added successfully')
            : Message::get_message(1, 'Could not add schedule');
    }

    public static function get($stand = null) {
        $conn = MySqlConnection::get_connection();
        if ($stand === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_one);
            $stmt->bind_param('i', $stand);
        }

        if (!$stmt->execute()) {
            return Message::get_message(1, 'Error executing query: ' . $conn->error);
        }

        $result = $stmt->get_result();
        if (!$result) {
            return Message::get_message(1, 'Error getting result: ' . $conn->error);
        }

        $schedules = [];
        while ($row = $result->fetch_assoc()) {
            $schedules[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'schedules' => $stand ? $schedules : $schedules
        ], JSON_PRETTY_PRINT);
    }
}