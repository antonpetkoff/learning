<?php
$clean_data = array();
$errors = array();

function persist($title, $description, $lecturer) {
  $host   = "localhost";
  $db     = "electives";
  $user   = "root";
  $pass   = "";

  $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);

  $stmt = $conn->prepare("
    INSERT INTO electives (title, description, lecturer, created_at)
    VALUES (:title, :description, :lecturer, :created_at)");
  $stmt->bindParam(':title', $title);
  $stmt->bindParam(':description', $description);
  $stmt->bindParam(':lecturer', $lecturer);
  $stmt->bindParam(':created_at', date('Y-m-d h:i:sa'));

  return $stmt->execute();
}

if ($_POST) {
  $title = $_POST['title'];
  $lecturer = $_POST['lecturer'];
  $description = $_POST['description'];

  if ($title && strlen($title) <= 150) {
    $clean_data['title'] = $title;
  } else {
    $errors['title'] = '* задължително, с максимална дължина - 150 символа';
  }

  if ($lecturer && strlen($lecturer) <= 200) {
    $clean_data['lecturer'] = $lecturer;
  } else {
    $errors['lecturer'] = '* задължително, с максимална дължина - 200 символа';
  }

  if ($description && strlen($description) >= 10) {
    $clean_data['description'] = $description;
  } else {
    $errors['description'] = '* задължително, минимална дължина - 10 символа';
  }

  $result = persist($_POST['title'], $_POST['description'], $_POST['lecturer']);

  if($result) {
    header('Location: all.php'); // set HTTP status to 302 and redirect to all.php
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
    <label for="lecturer">Lecturer</label>
    <input type="text" name="lecturer" />
  </p>
  <input type="submit" value="Add Elective" />
</form>

<?php
  // print what was saved
  if (!$errors && $clean_data) {
    echo '<h2>Избираемата е записана успешно:</h2>';
    foreach ($clean_data as $key => $value) {
      echo '<li>' . $key . ': ' . $value . '</li>';
    }
  } else {
    echo '<h2>Грешка: Имате неправилно попълнени полета!</h2>';
  }
?>
