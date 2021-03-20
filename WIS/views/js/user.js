const menu = document.querySelector('.user-menu');
const inserisciConsegna = document.querySelector('#inserisci-consegna-form');
const aggiornaConsegna = document.querySelector('#aggiorna-consegna-form');
const inserisciLibro = document.querySelector('#inserisci-libro-form');
const aggiornaLibro = document.querySelector('#aggiorna-libro-form');
const eliminaLibro = document.querySelector('#rimuovi-libro-form');
const inviaMessaggio = document.querySelector('#invia-messaggio-form');
const inviaSegnalazione = document.querySelector('#invia-segnalazione-form');
const rimuoviSegnalazioni = document.querySelector('#rimuovi-segnalazioni-form');

if (menu)
  menu.addEventListener('click', e => {
    const id = e.target.id || e.target.parentNode.id;

    document.querySelector('#title-and-role').style.display = 'none';
    Array.from( document.querySelector('.main-box').children ).forEach( child => {
      child.style.display = 'none';
    });
    document.querySelector(`#${id}-box`).style.display = 'block';
  });

if (inserisciConsegna)
  inserisciConsegna.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('note', document.querySelector('#new-note').value);
    formData.append('data', document.querySelector('#new-data').value);
    formData.append('tipo', document.querySelector('#new-tipo').value);
    formData.append('prenotazione', document.querySelector('#new-codice-prenotazione').value);

    fetch('API/inserisciConsegna.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      // console.log(res);
      if (res.ok) alert('Consegna inserita con successo!');
      else alert('Invalid input');
    })
    .catch(err => console.log(err));

  });

if (aggiornaConsegna) 
  aggiornaConsegna.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('consegna', document.querySelector('#update-codice-consegna').value);
    formData.append('note', document.querySelector('#update-note').value);
    formData.append('data', document.querySelector('#update-data').value);
    formData.append('tipo', document.querySelector('#update-tipo').value);
    formData.append('prenotazione', document.querySelector('#update-codice-prenotazione').value);

    fetch('/API/aggiornaConsegna.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Consegna aggiornata con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (inserisciLibro)
  inserisciLibro.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('codice', document.querySelector('#new-codice-libro').value);
    formData.append('titolo', document.querySelector('#new-titolo').value);
    formData.append('edizione', document.querySelector('#new-edizione').value);
    formData.append('anno', document.querySelector('#new-anno').value);
    formData.append('genere', document.querySelector('#new-genere').value);

    fetch('/API/inserisciLibro.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Libro inserito con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (aggiornaLibro)
  aggiornaLibro.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('codice', document.querySelector('#update-codice-libro').value);
    formData.append('titolo', document.querySelector('#update-titolo').value);
    formData.append('edizione', document.querySelector('#update-edizione').value);
    formData.append('anno', document.querySelector('#update-anno').value);
    formData.append('genere', document.querySelector('#update-genere').value);

    fetch('/API/aggiornaLibro.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Libro aggiornato con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (eliminaLibro)
  eliminaLibro.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('codice', document.querySelector('#del-codice-libro').value);

    fetch('/API/eliminaLibro.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Libro eliminato con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (inviaMessaggio)
  inviaMessaggio.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('email-utente', document.querySelector('#msg-email').value);
    formData.append('titolo', document.querySelector('#msg-titolo').value);
    formData.append('testo', document.querySelector('#msg-testo').value);

    fetch('/API/inviaMessaggio.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Messaggio inviato con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (inviaSegnalazione)
  inviaSegnalazione.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('email-utente', document.querySelector('#segn-email-dest').value);
    formData.append('testo', document.querySelector('#segn-testo').value);

    fetch('/API/inviaSegnalazione.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Segnalazione inviata con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

if (rimuoviSegnalazioni)
  rimuoviSegnalazioni.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('email-utente', document.querySelector('#email-utilizzatore').value);

    fetch('/API/rimuoviSegnalazioni.php', {
      method: 'POST',
      body: formData
    })
    .then( res => {
      if (res.ok) alert('Segnalazioni rimosse con successo!');
      else alert('Invalid input')
    })
    .catch(err => console.log(err));
  });

