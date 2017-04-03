<?php
$clean_data = array();
$errors = array();

function update($id, $title, $description, $lecturer) {
  $host   = "localhost";
  $db     = "electives";
  $user   = "root";
  $pass   = "";

  $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);

  $stmt = $conn->prepare("
    UPDATE electives SET title = :title, description = :description, lecturer = :lecturer WHERE id = :id");
  $stmt->bindParam(':id', $id);
  $stmt->bindParam(':title', $title);
  $stmt->bindParam(':description', $description);
  $stmt->bindParam(':lecturer', $lecturer);

  return $stmt->execute();
}

if ($_POST) {
  if ($_GET) {
    $id = $_GET['id'];
  } else {
    die("No elective ID passed!");
  }

  $title = $_POST['title'];
  $lecturer = $_POST['lecturer'];
  $description = $_POST['description'];

  $result = update($id, $title, $description, $lecturer);

  if($result) {
    header('Location: all.php'); // set HTTP status to 302 and redirect to all.php
  }
}

?>
