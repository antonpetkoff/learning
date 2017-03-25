<?php

$host   = "localhost";
$db     = "electives";
$user   = "root";
$pass   = "";

if ($_GET) {
  $id = $_GET['id'];

  $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
  $sql     = "SELECT * FROM electives WHERE id = $id";
  $query   = $conn->query($sql) or die("failed!");

  $row = $query->fetch(PDO::FETCH_ASSOC);

  if (!$row) {
    die("Elective not found!");
  }
} else if ($_PUT) {
  $id = $_PUT['id'];

  echo $id;
}

?>

<form method="put">
  <p>
    <label for="title">Title</label>
    <input type="text" name="title" value="<?php echo $row['title']; ?>" />
  </p>
  <p>
    <label for="description">Description</label>
    <input type="text" name="description" value="<?php echo $row['description']; ?>" />
  </p>
  <p>
    <label for="teacher">Teacher</label>
    <input type="text" name="teacher" value="<?php echo $row['teacher']; ?>" />
  </p>
  <p>
    <label for="credits">Credits</label>
    <input type="text" name="credits" value="<?php echo $row['credits']; ?>" />
  </p>
  <input type="submit" value="Edit Elective" />
</form>

