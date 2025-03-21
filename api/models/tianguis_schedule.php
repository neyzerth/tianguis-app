<?php
require_once('mysql.php');
require_once('message.php');

class TianguisSchedule {
    private static $select_all = "SELECT 
        day, tianguis, open_time, close_time 
        FROM tianguis_schedule ORDER BY tianguis, FIELD(day, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')";
    private static $select_one = "SELECT 
        day, tianguis, open_time, close_time 
        FROM tianguis_schedule WHERE tianguis = ?";
    private static $insert = "INSERT INTO tianguis_schedule (day, tianguis, open_time, close_time) 
        VALUES (?, ?, ?, ?)";

    public $day, $tianguis, $open_time, $close_time;

    public function __construct($data = []) {
        $this->day = $data['day'] ?? '';
        $this->tianguis = $data['tianguis'] ?? 0;
        $this->open_time = $data['open_time'] ?? '';
        $this->close_time = $data['close_time'] ?? '';
    }

    public function add() {
        $conn = MySqlConnection::get_connection();
        $stmt = $conn->prepare(self::$insert);
        $stmt->bind_param('siss', 
            $this->day,
            $this->tianguis,
            $this->open_time,
            $this->close_time
        );
        
        return $stmt->execute()
            ? Message::get_message(0, 'Schedule added successfully')
            : Message::get_message(1, 'Could not add schedule');
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
        $schedules = [];

        while ($row = $result->fetch_assoc()) {
            $schedules[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'schedules' => $id ? $schedules : $schedules
        ], JSON_PRETTY_PRINT);
    }
}
?>