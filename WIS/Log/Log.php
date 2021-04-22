<?php
    class Log {
        
        public function writeLog ($user, $string) {
            $conn = new MongoDB\Driver\Manager("mongodb://argonauta.synology.me:32774");
            $bulk = new MongoDB\Driver\BulkWrite;
            $bulk -> insert([
                'user' => $user,
                'operation' => $string,
                'date' => new MongoDB\BSON\UTCDateTime()
            ]);
            $conn -> executeBulkWrite('EBIBLIO.Log', $bulk);
        }

    }