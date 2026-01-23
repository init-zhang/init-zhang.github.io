ls -t blog/*.html | while read f; do
  md="${f%.html}.md"
  h1=$(sed -n '1s/# //p' "$md")
  date=$(date -d "@$(stat -c %Y "$md")" '+%Y-%m-%d')
  echo "$date [$h1](/$f)  "
done
