<?php 

  require_once('./core/Application.php');

  class userViewController {

    private function getUser($email) {

      $sql = "SELECT * FROM UTENTE WHERE emailutente = '".$email."'";
      $result = Application::$pdo->query($sql);
      $user = $result->fetch(\PDO::FETCH_ASSOC);
      if (!$user) {return false;}

      $sql = "SELECT * FROM UTILIZZATORE WHERE emailutilizzatore = '".$email."'";
      $result = Application::$pdo->query($sql);
      $userRole = $result->fetch(\PDO::FETCH_ASSOC);
      if ($userRole) {
        $userRole['ruolo'] = 'utilizzatore';
        return array_merge( $user, $userRole);
      }

      $sql = "SELECT * FROM VOLONTARIO WHERE emailvolontario = '".$email."'";
      $result = Application::$pdo->query($sql);
      $userRole = $result->fetch(\PDO::FETCH_ASSOC);
      if ($userRole) {
        $userRole['ruolo'] = 'volontario';
        return array_merge( $user, $userRole);
      }

      $sql = "SELECT * FROM AMMINISTRATORE WHERE emailamministratore = '".$email."'";
      $result = Application::$pdo->query($sql);
      $userRole = $result->fetch(\PDO::FETCH_ASSOC);
      if ($userRole) {
        $userRole['ruolo'] = 'amministratore';
        return array_merge( $user, $userRole);
      }

      return false;
    }
    public function user() {
      // $email = 'mario.rossi@unibo.it'; //utilizzatore
      // $email = 'anna.azzurri@unibo.it'; //volontario
      $email = 'elena.azzurri@unibo.it'; //amministratore

      $user = $this->getUser($email);
      if (!$user) {return header("Location: /home");}

      $params = [
        'user' => $user
      ];

      if ($user['ruolo'] == 'utilizzatore') {
        //ottieni prenotazioni
        // $sql = "SELECT * FROM PRENOTAZIONE WHERE emailutilizzatore = '".$email."'";
        $sql = "SELECT * FROM GetPrenotazioniUtente('".$email."')";
        $results = Application::$pdo->query($sql);
        $prenotazioni = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
          $prenotazioni[] = [
            'Codice' => $row['codice'],
            'DataAvvio' => $row['dataavvioprenotazione'],
            'DataFine' => $row['datafineprenotazione'],
            'CodiceLibro' => $row['codicelibro'] 
          ];
        };

        $params['prenotazioni'] = $prenotazioni;

        //ottieni consegne
        $sql = "SELECT * FROM GetConsegneByUtente('".$email."')";
        $results = Application::$pdo->query($sql);
        $consegne = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
          $consegne[] = [
            'Codice' => $row['codice'],
            'Note' => $row['noteconsegna'],
            'Data' => $row['dataconsegna'],
            'Tipo' => $row['tipoconsegna'],
            'Codice Prenotazione' => $row['codice_prenotazione']
          ];
        };

        $params['consegne'] = $consegne;
      }
      else if ($user['ruolo'] == 'volontario') {
        $sql = "SELECT * FROM PRENOTAZIONE";
        $results = Application::$pdo->query($sql);
        $prenotazioni = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
          $prenotazioni[] = [
            'Codice' => $row['codiceprenotazione'],
            'Data Avvio' => $row['dataavvio'],
            'Data Fine' => $row['datafine'],
            'Email Utente' => $row['emailutilizzatore'],
            'Codice Libro' => $row['codicelibrocartaceo']
          ];
        };

        $params['prenotazioni'] = $prenotazioni;
      } 
      else if ($user['ruolo'] == 'amministratore') {
        $sql = "SELECT * FROM getPrenotazioni('".$email."', '".$user['nomebiblioteca']."')";
        $results = Application::$pdo->query($sql);
        $prenotazioni = [];
        while ($row = $results->fetch(\PDO::FETCH_ASSOC)) {
          $prenotazioni[] = [
            'Codice' => $row['codice'],
            'Data Avvio' => $row['datai'],
            'Data Fine' => $row['dataf'],
            'Email Utente' => $row['emailu'],
            'Codice Libro' => $row['codicelibroc'] 
          ];
        };

        $params['prenotazioni'] = $prenotazioni;
      } 
      
      return Application::$app->router->renderView('user', $params);
    }


  }
?>