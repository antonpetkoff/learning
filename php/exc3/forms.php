<?php
$clean_data = array();
$errors = array();

if ($_POST) {
  $input_title = $_POST['title'];
  if ($input_title && strlen($input_title) < 150) {
    $clean_data['title'] = $input_title;
  } else {
    $errors['title'] = 'Името е задължително поле с максимална дължина 150 символа.';
  }
}

// TODO: field validation

// function required($field, $errors) {
//   if (!$_POST || !$_POST[$field]) {
//     $errors['field'] =
//   }
// }

// $fields = array(
//   array(
//     'name' => 'title',
//     'type' => 'text',
//     'label' => 'Заглавие',
//     'validators' => array(required)
//   )
// );

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
      <label for="title">Заглавие</label>
      <input type="text" name="title" id="title"></input>

    </p>
    <p>
      <label for="teacher">Преподавател</label>
      <input type="text" name="teacher" id="teacher"></input>
    </p>
    <p>
      <label for="credits">Кредити</label>
      <input type="number" step="0.5" name="credits" id="credits"></input>
    </p>
    <p>
      <label for="category">Категория</label>
      <select name="category">
        <option>ЯКН</option>
        <option>ОКН</option>
        <option>ПМ</option>
        <option>Ст</option>
        <option>М</option>
      </select>
    </p>
    <p>
      <label for="capacity">Брой хора</label>
      <input type="number" name="capacity" id="capacity"></input>
    </p>
    <p>
      <label for="description">Описание</label>
      <textarea name="description"></textarea>
    </p>
    <input type="submit" value="Добави">
  </form>

  <?php
    // print what was saved
    if ($clean_data) {
      echo '<h2>Избираемата е записана успешно:</h2>';
      foreach ($clean_data as $key => $value) {
        echo '<li>' . $key . ' => ' . $value . '</li>';
      }
    }
  ?>
</body>
</html>