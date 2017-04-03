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
}

?>

<form method="post" action="<?php echo "update.php?id={$id}"; ?>">
  <p>
    <label for="title">Title</label>
    <input type="text" name="title" value="<?php echo $row['title']; ?>" />
  </p>
  <p>
    <label for="description">Description</label>
    <input type="text" name="description" value="<?php echo $row['description']; ?>" />
  </p>
  <p>
    <label for="lecturer">Lecturer</label>
    <input type="text" name="lecturer" value="<?php echo $row['lecturer']; ?>" />
  </p>
  <input type="submit" value="Edit Elective" />
</form>

