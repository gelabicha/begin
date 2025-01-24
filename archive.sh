#!/bin/bash

# შეამოწმეთ, არის თუ არა არგუმენტი
if [ "$#" -ne 1 ]; then
  echo "გამოყენება: $0 <log-directory>"
  exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="archived_logs"

# შეამოწმეთ, არსებობს თუ არა მითითებული დირექტორია
if [ ! -d "$LOG_DIR" ]; then
  echo "შეცდომა: მითითებული დირექტორია '$LOG_DIR' არ არსებობს."
  exit 1
fi

# შექმენით არქივის დირექტორია, თუ არ არსებობს
if [ ! -d "$ARCHIVE_DIR" ]; then
  mkdir "$ARCHIVE_DIR"
fi

# შექმენით არქივის ფაილის სახელი
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="$ARCHIVE_DIR/logs_archive_$TIMESTAMP.tar.gz"

# შეკუმშეთ ჟურნალების დირექტორია
tar -czf "$ARCHIVE_FILE" -C "$LOG_DIR" .

# შეამოწმეთ, წარმატებით დასრულდა თუ არა შეკუმშვა
if [ $? -eq 0 ]; then
  echo "ჟურნალები წარმატებით შეკუმშულია: $ARCHIVE_FILE"
else
  echo "შეცდომა: შეკუმშვა ვერ შესრულდა."
  exit 1
fi
