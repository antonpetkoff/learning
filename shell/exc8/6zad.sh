#!/bin/bash

function prompt {
    echo "enter FN:"
    read FN
}

prompt

while [ "$FN" -lt 100 -o "$FN" -gt 9999 ]; do
    prompt
    echo test "$FN" -eq "$FN"
done

echo "You entered $FN"

case "$((($FN % 100) / 10))" in
    1)
        echo "Вие сте от първа група"
        ;;
    2)
        echo "Вие сте от втора група"
        ;;
    3)
        echo "Вие сте от трета група"
        ;;
    4)
        echo "Вие сте от четвърта група"
        ;;
    *)
        exit
esac

