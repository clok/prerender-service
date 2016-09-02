#!/bin/bash
set -e

VALUE="$1"

echo "Using input value: $VALUE"

s3=0
S3_HTML_CACHE=(
  S3_BUCKET_NAME
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  AWS_REGION
)
for unique in "${S3_HTML_CACHE[@]}"; do
  eval unique_value=\$$unique
  if [ "$unique_value" ]; then
    echo "s3HtmlCache Value Set [$unique]"
    s3=$[s3+1]
  fi
done

if [ $s3 -eq 4 ]; then
  echo "s3HtmlCache enabled"
  export S3_CACHE=true
fi

auth=0
AUTH=(
  BASIC_AUTH_USERNAME
  BASIC_AUTH_PASSWORD
)
for unique in "${AUTH[@]}"; do
  eval unique_value=\$$unique
  if [ "$unique_value" ]; then
    echo "basicAuth Value Set [$unique]"
    auth=$[auth+1]
  fi
done

if [ $auth -eq 2 ]; then
  echo "basicAuth enabled"
  export BASIC_AUTH=true
fi

OPTIONAL=(
  ALLOWED_DOMAINS
  BLACKLISTED_DOMAINS
  MEMORY_CACHE
  PRERENDER_NUM_ITERATIONS
  PRERENDER_NUM_WORKERS
)
for unique in "${OPTIONAL[@]}"; do
  eval unique_value=\$$unique
  if [ "$unique_value" ]; then
    echo "Optional Value Set [$unique]"
  else
    echo "Optional Value Not Set [$unique]"
  fi
done

case $VALUE in
prerender)
  echo "Starting the Prerender service..."
  /usr/bin/supervisord -c /etc/supervisor/conf.d/prerender.conf
  ;;
*)
  echo "Executing: $@"
  exec "$@"
  ;;
esac

echo "Goodbye!"
