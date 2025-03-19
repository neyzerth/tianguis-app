<?php
    class Message {
        public static function get_message($status, $message) {
            return json_encode(
                array(
                    'status' => $status,
                    'message' => $message
                )
            );
        }
    }
?>