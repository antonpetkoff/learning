<ul>
<?php

foreach ($params['errors'] as $error) {
    echo "<li>$error</li>";
}

?>
</ul>

<form method="post">
Email: <br />
<input type="text" name="email"><br />
Password: <br />
<input type="password" name="password"> <br />
Confirm password: <br />
<input type="password" name="confirm"> <br />
<br />
<input type="submit" value="Submit">
</form>