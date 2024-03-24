_update() {
    case $OSTYPE in
        darwin*)
            local FONTS_DIR="$HOME/Library/Fonts"
            ;;
        linux*)
            local FONTS_DIR="$HOME/.local/share/fonts"
            ;;
        *)
            echo "Unsupported OS"
            return 1
            ;;
    esac

    local dir=$(pwd)
    # Use find and xargs to handle filenames with spaces
        if [ "$1" == 'local' ]; then
            find "$dir" -type f \( -name "*.ttf" -o -name "*.otf" \) -print0 | while IFS= read -r -d '' file; do
                cp -v "$file" "$FONTS_DIR/$(basename "$file")"
            done
        elif [ "$1" == 'remote' ]; then
            find "$FONTS_DIR" -type f -print0 | while IFS= read -r -d '' file; do
                cp -v "$file" "$(basename "$file")"
            done
        fi
}

case $1 in
    "local")
        _update local
        ;;
    "remote")
        _update remote
        ;;
    *)
        echo "Usage: bash update.sh local or bash update.sh remote"
        ;;
esac
