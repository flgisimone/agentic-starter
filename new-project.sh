#!/usr/bin/env bash
# Crea un progetto nuovo da agentic-starter.
#
#   ./new-project.sh <slug> ["Nome visualizzato"] [cartella-madre]
#
# slug: nome della cartella e del repository (minuscole, cifre, trattini), es. my-app
# Nome visualizzato: quello nei documenti, es. "My App" (predefinito: lo slug)
# cartella-madre: dove creare il progetto (predefinito: la cartella che contiene agentic-starter)
#
# NO_MEMORY=1 salta l'installazione delle memorie di Claude Code.
set -euo pipefail

STARTER="$(cd "$(dirname "$0")" && pwd)"

die() { echo "errore: $*" >&2; exit 1; }

[ $# -ge 1 ] || die "uso: $0 <slug> [\"Nome visualizzato\"] [cartella-madre]"
SLUG="$1"
NAME="${2:-$1}"
PARENT="${3:-$(dirname "$STARTER")}"

[[ "$SLUG" =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "slug non valido: «$SLUG» (minuscole, cifre e trattini)"
[ -d "$PARENT" ] || die "la cartella madre non esiste: $PARENT"
PARENT="$(cd "$PARENT" && pwd)"
DEST="$PARENT/$SLUG"
[ -e "$DEST" ] && die "esiste già: $DEST"
command -v git >/dev/null || die "git non è installato"

# 1. Copia del template
cp -R "$STARTER/template" "$DEST"
find "$DEST" -name .DS_Store -delete

# 2. Segnaposto. perl legge i valori dall'ambiente: nessun problema con /, & o | nel nome.
export SP_NAME="$NAME" SP_SLUG="$SLUG" SP_PATH="$DEST" SP_DATE="$(date +%F)"
SP_EXPR='s/\{\{PROJECT_NAME\}\}/$ENV{SP_NAME}/g; s/\{\{PROJECT_SLUG\}\}/$ENV{SP_SLUG}/g; s/\{\{PROJECT_PATH\}\}/$ENV{SP_PATH}/g; s/\{\{DATE\}\}/$ENV{SP_DATE}/g'
replace() { perl -pi -e "$SP_EXPR" "$@"; }
find "$DEST" -type f \( -name '*.md' -o -name '*.yml' -o -name '.env.example' \) -exec perl -pi -e "$SP_EXPR" {} +

# 3. Memorie di Claude Code: la cartella è il percorso del progetto con i caratteri non alfanumerici sostituiti da «-».
if [ "${NO_MEMORY:-}" != "1" ]; then
  MEM="$HOME/.claude/projects/$(printf '%s' "$DEST" | sed 's/[^A-Za-z0-9]/-/g')/memory"
  if [ -d "$MEM" ] && [ -n "$(ls -A "$MEM")" ]; then
    echo "memorie: $MEM non è vuota, lasciata com'è"
  else
    mkdir -p "$MEM"
    cp "$STARTER"/memory-seed/*.md "$MEM/"
    replace "$MEM"/*.md
    echo "memorie: installate in $MEM"
  fi
fi

# 4. Git: primo commit su main, poi develop
cd "$DEST"
git init -q -b main
git add -A
if git commit -q -m "Scaffolding da agentic-starter"; then
  git branch develop
  git checkout -q develop
  echo "git: commit iniziale su main, branch develop attivo"
else
  echo "git: commit non riuscito (configura user.name e user.email), file lasciati in stage"
fi

LEFT="$(grep -rl '{{PROJECT_' "$DEST" --exclude-dir=.git || true)"
[ -z "$LEFT" ] || { echo "attenzione: segnaposto rimasti in:"; echo "$LEFT"; }

cat <<EOF

Progetto creato: $DEST
Prossimi passi:
  1. cd "$DEST" e apri Claude Code
  2. chiedi di aprire la fase F0 (plan/00-base.md): stack, agenzie attive, sezioni «da compilare»
  3. quando vuoi pubblicarlo: gh repo create $SLUG --private --source . --push
EOF
