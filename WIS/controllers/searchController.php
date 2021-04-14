<?php
require_once('./core/Application.php');

class searchController {

    private $queries = [
        'biblioteche' => 'SELECT * FROM GetBiblioteche()',
        'postilettura' => 'SELECT * FROM PostiLetturaBiblioteca()',
        'libri' => 'SELECT * FROM LibriBiblioteca()'
    ];

    public function ricerca(){
        $parsed_url = parse_url($_SERVER['REQUEST_URI']);
        $category = substr($parsed_url['path'],1);
        $query_parameters = explode('&', substr($parsed_url['query'], 2));

        /* Utilizzo $category come chiave nel dizionario per ottenere il valore, cioè la query SQL */
        if ($query_parameters[0] === "") {
            $sql = $this -> queries[$category];
        } else {
            $query = '';
            foreach ($query_parameters as $parameter) {
                $query = $query."'$parameter', ";
            };
            $sql = substr($this -> queries[$category], 0, -1).substr($query, 0, -2).")";
        }

        /* Anche qui, utilizzo $category per richiamare la function a cui passo la query SQL */
        $params = $this->$category($sql);

//        if (empty($params['libraries'])){
//            Application::$app->response->setStatusCode(404);
//            return Application::$app->router->renderContent("404 - Invalid url query!");
//        }

        /* Allo stesso modo utilizzo %category per richiamare il layout*/
        return Application::$app->router->renderView($category, $params);
    }

    private function biblioteche($sql){
        $results = Application::$pdo->query($sql);
        $libraries = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
            if (isset($libraries[$row['nome']])) {
                array_push($libraries[$row['nome']]['numeri'], $row['numero']);
            }
            else {
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
        }
        return $params = ['libraries' => $libraries ];
    }

    private function postilettura($sql){
        $results = Application::$pdo->query($sql);
        $postilettura = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
            if (isset($postilettura[$row['nomebiblioteca']])) {
                array_push(
                    $postilettura[$row['nomebiblioteca']],
                    $row['numposto'] =
                        [
                            'presacorr' => $row['presacorr'],
                            'presaeth' => $row['presaeth']
                        ]
                );
            }
            else {
                $postilettura[$row['nomebiblioteca']] =
                    [
                        $row['numposto'] =
                            [
                                'presacorr' => $row['presacorr'],
                                'presaeth' => $row['presaeth']
                            ]
                    ];
            }
        }
        return $params = ['postilettura' => $postilettura ];
    }

    private function libri($sql){
        $results = Application::$pdo->query($sql);
        $ebooks = [];
        $libricartacei = [];

        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
            if ($row['titolocartaceo']){
                if (isset($libricartacei[$row['titolocartaceo']])) {
                    array_push($libricartacei[$row['titolocartaceo']]['nomeautore'], $row['nomeautore']);
                    array_push($libricartacei[$row['titolocartaceo']]['cognomeautore'], $row['cognomeautore']);
                }
                else{
                    $libricartacei[$row['titolocartaceo']] = [
                        'codicelibrocartaceo' => $row['codicelibrocartaceo'],
                        'titolocartaceo' => $row['titolocartaceo'],
                        'nomeedizionecartaceo' => $row['nomeedizionecartaceo'],
                        'annopubblicazionecartaceo' => $row['annopubblicazionecartaceo'],
                        'generecartaceo' => $row['generecartaceo'],
                        'nomebibliotecacartaceo' => $row['nomebibliotecacartaceo'],
                        'statoprestito' => $row['statoprestito'],
                        'statoconservazione' => $row['statoconservazione'],
                        'numpagine' => $row['numpagine'],
                        'numscaffale' => $row['numscaffale'],
                        'nomeautore' => [$row['nomeautore']],
                        'cognomeautore' => [$row['cognomeautore']]
                    ];
                }
            } else {
                $ebooks[] = [
                    'codiceebook' => $row['codiceebook'],
                    'titoloebook' => $row['titoloebook'],
                    'nomeedizioneebook' => $row['nomeedizioneebook'],
                    'annopubblicazioneebook' => $row['annopubblicazioneebook'],
                    'genereebook' => $row['genereebook'],
                    'nomebibliotecaebook' => $row['nomebibliotecaebook'],
                    'pdf' => $row['pdf']
                ];
            }
        }

        return $params = [
//            'ebooks' => $ebooks,
            'libricartacei' => $libricartacei
        ];
    }
}


