@echo on
chcp 65001 
dir \1c\dt

if !%1!==!! (
	echo ��������� �������� 1 - ������ ��� �����
	exit 3
)
if !%2!==!! (
	echo ��������� �������� 2 - ������� �������
	exit 3
)

if !%3!==!! (
	echo ��������� �������� 3 - �������� ��� ������������
	exit 3
)

if !%4!==!! (
	echo ��������� �������� 4 - ������� ������
	exit 3
)

if not exist %2 net use %2
if not exist %2 net use %2 %4 /user:%3
if not exist %2 (
	echo �� ������� ���������� ���� %2
        exit 5
)

xcopy /V /I /Y /Z %1 %2
::  /Y
