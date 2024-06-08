#!/bin/bash

phonebook="phonebook.txt"

if [[ $# -ne 2 ]]; then
  echo "인수는 2개가 입력되어야 합니다."
  exit 1
fi

name="$1"
phone_number="$2"

if ! [[ "$phone_number" =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then # 000-0000-0000 형식인지 확인
  echo "전화번호는 숫자와 하이픈(-)으로만 이루어져야 합니다."
  exit 1
fi

area_number=$(echo "$phone_number" | cut -d'-' -f1) # - 전까지 끊어서 지역번호 확인
area=""

case $area_number in
  "02") area="서울" ;;
  "051") area="부산" ;;
  "052") area="울산" ;;
  "063") area="전북" ;;
  "064") area="제주" ;;
  "010") area="" ;;
  *)
    echo "입력하신 지역번호는 지원하지 않습니다."
    exit 1
    ;;
esac

if [ ! -f "$phonebook" ]; then # 파일 생성 
  touch "$phonebook" 
fi

already_existed=$(grep "^$name " "$phonebook")

if [ -n "$already_existed" ]; then
  already_existed=$(echo "$already_existed" | cut -d' ' -f2)
  if [ "$already_existed" == "$phone_number" ]; then
    echo "동일한 전화번호가 이미 존재합니다."
    exit 0
  else
    sed -i "/^$name /d" "$phonebook"
  fi
fi

echo "$name $phone_number $area" >> "$phonebook" # 파일에 추가

sort -o "$phonebook" "$phonebook" #정렬

echo "새로운 전화번호가 추가되었습니다."

exit 0
