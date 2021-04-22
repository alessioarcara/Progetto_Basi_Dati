<?php
    class Log {
        
        public function writeLog ($user, $string) {
            $conn = new MongoDB\Driver\Manager("mongodb://localhost:27017");
            $bulk = new MongoDB\Driver\BulkWrite;
            $bulk -> insert([
                'user' => $user,
                'operation' => $string,
                'date' => new MongoDB\BSON\UTCDateTime()
            ]);
            $conn -> executeBulkWrite('EBIBLIO.Log', $bulk);
        }

    }