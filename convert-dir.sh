for file in "$@"; do
    echo $file
    if [[ $file = "index.md" ]]; then
        .venv/bin/python3 paste.py $file templates/_index.html
    else
        .venv/bin/python3 paste.py $file templates/base.html
    fi
done
