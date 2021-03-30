<?php
require_once('./core/Application.php');

class searchController {

    public function ricerca()
    {
        $parsed_url = parse_url($_SERVER['REQUEST_URI']);
        $category = substr($parsed_url['path'],1);
        $query_parameters = explode('&', substr($parsed_url['query'], 2));

        return $this -> $category($query_parameters);

//        Application::$app->response->setStatusCode(404);
//        return Application::$router->renderContent("404 - Invalid url query!");
    }

    private function biblioteche($query_parameters){

        if ($query_parameters[0] === "Tuttelebiblioteche") {
            $sql = 'SELECT *  FROM biblioteca LEFT JOIN recapitotelefonico r on biblioteca.nome = r.nomebiblioteca';

            $results = Application::$pdo->query($sql);
            $libraries = [];
            while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
                if (isset($libraries[$row['nome']]))
                {
                    array_push($libraries[$row['nome']]['numeri'], $row['numero']);
                }
                else
                {
                    $libraries[$row['nome']] =
                        [
                            'nome' => $row['nome'],
                            'via' => $row['via'],
                            'civico' => $row['civico'],
                            'cap' => $row['cap'],
                            'citta' => $row['citta'],
                            'email' => $row['email'],
                            'sitoweb' => $row['sitoweb'],
                            'lat' => $row['lat'],
                            'long' => $row['long'],
                            'notestoriche' => $row['notestoriche'],
                            'numeri' => [$row['numero']]
                        ];
                }
            };
            $params = [
                'libraries' => $libraries
            ];
            return Application::$app->router->renderView('biblioteca', $params);
        } else {

            // per ogni & crea una chiave
            // per ogni = crea un valore della chiave
            $params = [];
            foreach ($query_parameters as $parameter) {
                [$key, $value] = explode('=', $parameter);
                $params[$key] = $value;
                echo '<pre>'; print_r($params); echo '</pre>';
                };

            $nomebiblioteca = $query_parameters[0];


        }
    }

    private function postilettura($query_parameters){

    }

    private function libricartacei($query_parameters){

    }

    private function ebooks($query_parameters){

    }

//        $params = [];
//        foreach ($parameters as $parameter) {
//            [$key, $value] = explode('=', $parameter);
//            $params[$key] = $value;
//        };
//
//        //se nella query è specificato il nome della biblioteca
//        //allora si ottengono le informazioni della biblioteca specifica
//        if ($params['n']) {
//            //ottieni il nome biblioteca originale dall'url
//            $nomeBiblioteca = $params['n'];
//            $nomeBiblioteca = str_replace('%20', ' ', $nomeBiblioteca);
//            $nomeBiblioteca = str_replace('%22', '"', $nomeBiblioteca);
//
//            //se è presente 'section' nella query significa che vogliamo vedere
//            //o i posti lettura o i libri della biblioteca specifica
//            if ($params['section']) {
//
//                if ($params['section'] === 'libri') {
//                    $sql = "SELECT * FROM LibriBiblioteca( ' ".$nomeBiblioteca. " ')";
//
//                    $result = Application::$pdo->query($sql);
//                    $books = [];
//                    while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
//                        $books[] = [
//                            "codice" => $row['codice'],
//                            "titolo" => $row['titololibro'],
//                            "edizione" => $row['edizione'],
//                            "anno" => $row['anno'],
//                            "genere" => $row['generelibro']
//                        ];
//                    };
//
//                    $params = [
//                        'libraryName' => $nomeBiblioteca,
//                        'books' => $books
//                    ];
//
//                    return Application::$app->router->renderView('results', $params);
//
//                }
//
//            }
//
//            //se non è presente la 'section' nella query allora
//            //si restituiscono tutti i valori della specifica biblioteca
//
//            $sql = "SELECT * FROM BIBLIOTECA WHERE Nome = '".$nomeBiblioteca."'";
//
//            $result = Application::$pdo->query($sql);
//            $library = [];
//            while ($row = $result->fetch(\PDO::FETCH_ASSOC)) {
//                $library = [
//                    'nome' => $row['nome'],
//                    'indirizzo' => $row['indirizzo'],
//                    'email' => $row['email'],
//                    'sitoweb' => $row['sitoweb'],
//                    'lat' => $row['lat'],
//                    'long' => $row['long']
//                ];
//            };
//
//            $params = [
//                'library' => $library
//            ];
//
//            return Application::$app->router->renderView('results', $params);
//        }
}