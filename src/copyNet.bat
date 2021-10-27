@echo on
chcp 65001 
dir \1c\dt

if !%1!==!! (
	echo ’…“…’‘Ÿ €€Œ…’ 1 - Ž‹Ž… ˆŒŸ ”€‰‹€
	exit 3
)
if !%2!==!! (
	echo ’…“…’‘Ÿ €€Œ…’ 2 - ‘…’…‚Ž‰ Š€’€‹Žƒ
	exit 3
)

if !%3!==!! (
	echo ’…“…’‘Ÿ €€Œ…’ 3 - „ŽŒ…Ž… ˆŒŸ Ž‹œ‡Ž‚€’…‹Ÿ
	exit 3
)

if !%4!==!! (
	echo ’…“…’‘Ÿ €€Œ…’ 4 - ‘…’…‚Ž‰ €Ž‹œ
	exit 3
)

if not exist %2 net use %2
if not exist %2 net use %2 %4 /user:%3
if not exist %2 (
	echo … “„€‹Ž‘œ Ž„Š‹ž—ˆ’œ „ˆ‘Š %2
        exit 5
)

xcopy /V /I /Y /Z %1 %2
::  /Y
