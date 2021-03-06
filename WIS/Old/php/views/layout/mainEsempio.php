<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EBIBLIO</title>
</head>
<body>
  <div style='display: flex;'>
    <a href="/" style="padding: 10px;">HOME</a>
    <a href="user" style="padding: 10px;">USER</a>
    <?php 
      if ($user) {
        echo "<a href='/' id='logout' style='padding: 10px;'> LOGOUT </a> ";
      }
    ?>
  </div>

  {{content}}

  <script>
    const logoutBtn = document.querySelector('#logout');
    if (logoutBtn)
      logoutBtn.addEventListener('click', () => {
        document.cookie = `user=; expires=${new Date()}`;
        location.assign('/');
      });
  </script>
</body>
</html>