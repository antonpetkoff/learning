<?php
$clean_data = array();
$errors = array();

if ($_POST) {
  $title = $_POST['title'];
  $teacher = $_POST['teacher'];
  $description = $_POST['description'];
  $credits = $_POST['credits'];

  if ($title && strlen($title) <= 150) {
    $clean_data['title'] = $title;
  } else {
    $errors['title'] = '* задължително, с максимална дължина - 150 символа';
  }

  if ($teacher && strlen($teacher) <= 200) {
    $clean_data['teacher'] = $teacher;
  } else {
    $errors['teacher'] = '* задължително, с максимална дължина - 200 символа';
  }

  if ($description && strlen($description) >= 10) {
    $clean_data['description'] = $description;
  } else {
    $errors['description'] = '* задължително, минимална дължина - 10 символа';
  }

  if ($credits && $credits > 0) {
    $clean_data['credits'] = $credits;
  } else {
    $errors['credits'] = '* цяло положително число';
  }
}

?>

<!DOCTYPE html>
<html>
<head>
  <title>Добавяне на курс</title>
  <meta charset="utf-8">
</head>
<body>
  <h1>Добавяне на курс</h1>
  <form method="post" action="">
    <p>
      <label for="title">Име на предмета</label>
      <input type="text" name="title" id="title"></input>
      <?php if (array_key_exists('title', $errors)) {echo $errors['title'];} ?>
    </p>
    <p>
      <label for="teacher">Преподавател</label>
      <input type="text" name="teacher" id="teacher"></input>
      <?php if (array_key_exists('teacher', $errors)) {echo $errors['teacher'];} ?>
    </p>
    <p>
      <label for="description">Описание</label>
      <textarea name="description"></textarea>
      <?php if (array_key_exists('description', $errors)) {echo $errors['description'];} ?>
    </p>
    <p>
      <label for="category">Група</label>
      <select name="category">
        <option>М</option>
        <option>ПМ</option>
        <option>ОКН</option>
        <option>ЯКН</option>
      </select>
      <?php if (array_key_exists('category', $errors)) {echo $errors['category'];} ?>
    </p>
    <p>
      <label for="credits">Кредити</label>
      <input type="number" name="credits" id="credits"></input>
      <?php if (array_key_exists('credits', $errors)) {echo $errors['credits'];} ?>
    </p>
    <input type="submit" value="Добави">
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
</body>
</html>