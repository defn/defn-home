export CUE_SCHEME="$(cat ~/.cue_scheme 2>&- || true)"
source ~/.bashrc || echo "ERROR: something's wrong with bashrc"
