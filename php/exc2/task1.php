<?php

$data = array(
  'webgl' => array(
    'title' => 'Компютърна графика с WebGL',
    'description' => '...',
    'lecturer' => 'доц. П. Бойчев',
  ),
  'go' => array(
    'title' => 'Програмиране с Go',
    'description' => '...',
    'lecturer' => 'Николай Бачийски',
  )
);

function show_page($pageId, $electives) {
  if (!$pageId || !array_key_exists($pageId, $electives)) {
    return "Избираемата дисциплина не съществува!";
  }

  return
    "<h1>{$electives[$pageId]['title']}</h1>".
    "<h2>{$electives[$pageId]['lecturer']}</h2>".
    "<p>{$electives[$pageId]['description']}</p>";
}

function show_nav($electives, $pageId) {
  $links = "";

  foreach ($electives as $id => $data) {
    $class = ($id === $pageId ? 'class="selected"' : '');
    $links .= "<a href=\"?page=$id\" $class>{$electives[$id]['title']}</a>";
  }

  return "<nav>".$links."</nav>";
}

$body = "";

if ($_GET) {
  $body = show_page($_GET['page'], $data);
} else {
  $body = 'Моля изберете дисциплина';
}

echo show_nav($data, null);
echo $body;

?>