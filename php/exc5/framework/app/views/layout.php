<html>
    <head>
        <title>Electives</title>
    </head>
    <body>
        <h1>Electives @ FMI</h1>

        <p>
            <?php
                if ($_SESSION) {
                    $user_email = $_SESSION['user_email'];
                    if ($user_email) {
                        echo "Hello, $user_email | <a href=\"index.php?q=users/logout\">Log out</a>";
                    } else {
                        echo "<a href=\"index.php?q=users/login\">Log in</a>";
                        echo "<a href=\"index.php?q=users/register\">Register</a>";
                    }
                }
            ?>
        </p>

        <nav>
            <a href="index.php">Home</a>
        </nav>

        <?php echo $content; ?>
    </body>
</html>