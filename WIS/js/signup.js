const signup = document.querySelector('#sign-up-form-form');

if (signup)
  signup.addEventListener('submit', e => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('nome', document.querySelector('#new-name').value);
    formData.append('cognome', document.querySelector('#new-last-name').value);
    formData.append('datadinascita', document.querySelector('#new-birth-date').value);
    formData.append('luogodinascita', document.querySelector('#new-birth-place').value);
    formData.append('telefono', document.querySelector('#new-phone').value);
    formData.append('email', document.querySelector('#new-user-email').value);
    formData.append('password', document.querySelector('#new-user-password').value);
    formData.append('professione', document.querySelector('#new-user-job').value);

    fetch('/API/signup.php', {
      method: 'POST',
      body: formData
    })
        .then( res => {
          if (res.ok) {
            alert('Registrazione avvenuta con successo!');
            document.cookie = 'email=' + email;
            location.reload();
          }
          else alert('Invalid input')
        })
        .catch(err => console.log(err));

  });
