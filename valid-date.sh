#!/bin/bash

if [ $# -ne 3 ]; then # 인수가 3개가 아닐 때
    echo "입력값 오류"
    exit 1
fi

case $(echo "$1" | tr '[:lower:]' '[:upper:]') in # case문으로 월 형태 맞추기
    JAN | JANUARY | 1) month="Jan" ;;
    FEB | FEBRUARY | 2) month="Feb" ;;
    MAR | MARCH | 3) month="Mar" ;;
    APR | APRIL | 4) month="Apr" ;;
    MAY | 5) month="May" ;;
    JUN | JUNE | 6) month="Jun" ;;
    JUL | JULY | 7) month="Jul" ;;
    AUG | AUGUST | 8) month="Aug" ;;
    SEP | SEPTEMBER | 9) month="Sep" ;;
    OCT | OCTOBER | 10) month="Oct" ;;
    NOV | NOVEMBER | 11) month="Nov" ;;
    DEC | DECEMBER | 12) month="Dec" ;;
    *) echo "월 오류, $month 는 유효하지 않은 월입니다."
        exit 1 ;;
esac

day=$2 # 입력받은 일
if ! [[ "$day" =~ ^[0-9]+$ ]]; then
    echo "날짜 오류, $day 는 유효하지 않은 날짜입니다."
    exit 1
fi

year=$3 # 입력받은 년
if ! [[ "$year" =~ ^[0-9]+$ ]]; then
    echo "연도 오류, $year 는 유효하지 않은 연도입니다."
    exit 1
fi

if (( year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) )); then #윤년인지 확인
    days_in_month=(31 29 31 30 31 30 31 31 30 31 30 31)
else
    days_in_month=(31 28 31 30 31 30 31 31 30 31 30 31)
fi


if (( day < 1 || day > days_in_month[$month - 1] )); then # 유효한 날짜인지
    echo "날짜 오류 : $day 는 유효하지 않은 날짜입니다."
    exit 1
fi

echo "$month $day $year" # 출력
