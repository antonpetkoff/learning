<?php

$host   = "localhost";
$db     = "electives";
$user   = "root";
$pass   = "";

$id = $_GET['id'];

$conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
$sql     = "SELECT * FROM electives WHERE id = $id";
$query   = $conn->query($sql) or die("failed!");

$row = $query->fetch(PDO::FETCH_ASSOC);

if (!$row) {
  die("Elective not found!");
}

?>

<h1><?php echo $row['title']; ?></h1>

<h2><?php echo $row['teacher']; ?></h2>

<p><?php echo $row['description']; ?></p>

<p><?php echo $row['credits']; ?></p>
