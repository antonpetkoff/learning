<?php

$host   = "localhost";
$db     = "electives";
$user   = "root";
$pass   = "";

$conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
$sql     = "SELECT * FROM electives";
$query   = $conn->query($sql) or die("failed!");

echo "<ul>";
while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
  $edit_link = "<a href=\"edit.php?id={$row['id']}\">[Edit]</a>";
  $view_link = "<a href=\"view.php?id={$row['id']}\">[View]</a>";
  echo "<li>" . $row['title'] . " " . $edit_link . " " . $view_link . '</li>';
}
echo "</ul>";

?>
