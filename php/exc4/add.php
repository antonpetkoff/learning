<?php

if ($_POST) {
  $host   = "localhost";
  $db     = "electives";
  $user   = "root";
  $pass   = "";

  $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);

  $stmt = $conn->prepare("
    INSERT INTO electives (title, description, teacher, credits)
    VALUES (:title, :description, :teacher, :credits)");
  $stmt->bindParam(':title', $title);
  $stmt->bindParam(':description', $description);
  $stmt->bindParam(':teacher', $teacher);
  $stmt->bindParam(':credits', $credits);

  // TODO: validate the request
  $title = $_POST['title'];
  $description = $_POST['description'];
  $teacher = $_POST['teacher'];
  $credits = $_POST['credits'];

  $result = $stmt->execute();

  if($result) {
    header('Location: db.php'); // set HTTP status to 302 and redirect to db.php
  }
}

?>

<form method="post">
  <p>
    <label for="title">Title</label>
    <input type="text" name="title" />
  </p>
  <p>
    <label for="description">Description</label>
    <input type="text" name="description" />
  </p>
  <p>
    <label for="teacher">Teacher</label>
    <input type="text" name="teacher" />
  </p>
  <p>
    <label for="credits">Credits</label>
    <input type="text" name="credits" />
  </p>
  <input type="submit" value="Add Elective" />
</form>
