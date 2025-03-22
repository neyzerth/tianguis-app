<?php
require_once('mysql.php');
require_once('message.php');

class Tianguis {
    private static $select_all = "SELECT 
        t.id, t.name, t.address, 
        ST_AsText(t.location) as location,
        t.created_at, t.updated_at, t.disable 
        FROM tianguis t ORDER BY t.id";
        
    private static $select_schedules = "SELECT 
        day, tianguis, open_time, close_time 
        FROM tianguis_schedule 
        WHERE tianguis = ? 
        ORDER BY FIELD(day, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')";
        
    private static $select_stands = "SELECT 
        s.id, s.name, s.description, s.created_at, s.disable, s.owner, s.category,
        sl.id as location_id, sl.address, ST_AsText(sl.location) as location, sl.tianguis_dependece
        FROM stand s
        INNER JOIN stand_location sl ON sl.stand_info = s.id
        WHERE sl.tianguis = ?";

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
        $this->disable = false;
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

    private function parseLocation($locationStr) {
        if (empty($locationStr)) return null;
        
        if (strpos($locationStr, 'POINT') === 0) {
            // Handle POINT(lng lat)
            preg_match('/POINT\((.*?)\)/', $locationStr, $matches);
            if (isset($matches[1])) {
                list($lng, $lat) = explode(' ', $matches[1]);
                return [
                    'type' => 'Point',
                    'coordinates' => [$lng, $lat]
                ];
            }
        } else if (strpos($locationStr, 'MULTILINESTRING') === 0) {
            // Handle MULTILINESTRING((lng lat, lng lat),(lng lat, lng lat))
            preg_match('/MULTILINESTRING\((.*)\)/', $locationStr, $matches);
            if (isset($matches[1])) {
                $lines = explode('),(', trim($matches[1], '()'));
                $coordinates = array_map(function($line) {
                    return array_map(function($point) {
                        list($lng, $lat) = explode(' ', $point);
                        return [(float)$lng, (float)$lat];
                    }, explode(',', $line));
                }, $lines);
                
                return [
                    'type' => 'MultiLineString',
                    'coordinates' => $coordinates
                ];
            }
        }
        return null;
    }

    public static function get($id = null) {
        $conn = MySqlConnection::get_connection();
        if ($id === null) {
            $stmt = $conn->prepare(self::$select_all);
        } else {
            $stmt = $conn->prepare(self::$select_all . " WHERE t.id = ?");
            $stmt->bind_param('i', $id);
        }

        if (!$stmt->execute()) {
            return Message::get_message(1, 'Error executing query: ' . $conn->error);
        }

        $result = $stmt->get_result();
        $tianguis = [];

        while ($row = $result->fetch_assoc()) {
            // Parse location to GeoJSON
            $row['location'] = (new self)->parseLocation($row['location']);
            
            // Get schedules for this tianguis
            $scheduleStmt = $conn->prepare(self::$select_schedules);
            $scheduleStmt->bind_param('i', $row['id']);
            $scheduleStmt->execute();
            $scheduleResult = $scheduleStmt->get_result();
            $row['schedules'] = [];
            while ($schedule = $scheduleResult->fetch_assoc()) {
                $row['schedules'][] = $schedule;
            }

            // Get stands for this tianguis
            $standStmt = $conn->prepare(self::$select_stands);
            $standStmt->bind_param('i', $row['id']);
            $standStmt->execute();
            $standResult = $standStmt->get_result();
            $row['stands'] = [];
            while ($stand = $standResult->fetch_assoc()) {
                // Parse stand location to GeoJSON
                $stand['location'] = (new self)->parseLocation($stand['location']);
                $row['stands'][] = $stand;
            }

            $tianguis[] = $row;
        }

        return json_encode([
            'status' => 0, 
            'tianguis' => $id ? ($tianguis[0] ?? null) : $tianguis
        ], JSON_PRETTY_PRINT);
    }
}
?>