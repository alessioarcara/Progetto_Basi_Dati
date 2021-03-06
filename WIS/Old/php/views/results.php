<?php 

if ($library) {

  $markup = 
  "
  <h2>".$library['nome']."</h2> <br/>
  <h4>".$library['indirizzo']."</h4> <br/>
  <h4>".$library['email']."</h4> <br/>
  <h4>".$library['sitoweb']."</h4> <br/>
  <h4>".$library['lat']."</h4> <br/>
  <h4>".$library['long']."</h4> <br/>
  <br/>
  <a href='biblioteca?n=".$library['nome']."&section=libri'>Vedi libri</a>
  "
  ;
  echo $markup;

}
else if ($books) {

  echo "<h1>Libri in ".$libraryName."</h1> <br/>";

  foreach ($books as $book) {

    $markup = 
    "
    <h3>".$book['codice']."  ".$book['titolo']."  ".$book['genere']."</h3> 
    "
    ;
    echo $markup;
  }
  echo "<a href='biblioteca?n=".$libraryName."'>Indietro</a>";
}
else {
  echo '<h3>Non esiste una biblioteca con questo nome.</h3>';
}

?>