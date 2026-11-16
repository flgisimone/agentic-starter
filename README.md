# agentic-starter

> **Archiviato il 2026-11-16.** Lo starter è confluito nel pacchetto [`@agentrica/mcp`](https://github.com/flgisimone/agentrica/tree/main/packages/mcp): un progetto nuovo, con le regole aggiornate e le stesse agenzie, si crea con
>
> ```sh
> npx -y @agentrica/mcp@0.4.0 init mio-progetto --name "Mio progetto"
> ```
>
> Il modello di progetto è in [`starter/`](https://github.com/flgisimone/agentrica/tree/main/starter) del repository di Agentrica. Questo repository resta in sola lettura con la versione del 2026-11-15.

Scaffolding per progetti sviluppati con Claude Code e un sistema di agenzie di ruoli (software, web design, privacy, business, cybersecurity). Contiene solo la governance: regole per gli agenti, convenzioni, piano a fasi, agenzie, audit e CI. Lo stack si sceglie nella fase F0 di ogni progetto.

Documenti e ruoli sono in italiano.

## Requisiti

- macOS o Linux con `bash`, `git` e `perl`
- [Claude Code](https://claude.com/claude-code)
- facoltativo: [tokensave](https://github.com/aovestdipaperino/tokensave) per l'indice del codice, [GitHub CLI](https://cli.github.com) per creare il repository

## Creare un progetto

```sh
git clone https://github.com/<owner>/agentic-starter.git
cd agentic-starter
./new-project.sh my-app "My App"                  # crea ../my-app
./new-project.sh my-app "My App" ~/progetti       # in un'altra cartella
NO_MEMORY=1 ./new-project.sh my-app               # senza memorie di Claude Code
```

Lo script:

1. copia `template/` nella cartella nuova;
2. sostituisce i segnaposto `{{PROJECT_NAME}}`, `{{PROJECT_SLUG}}`, `{{PROJECT_PATH}}` (il `graph_root` di tokensave in `AGENTS.md`) e `{{DATE}}`;
3. installa le memorie di `memory-seed/` in `~/.claude/projects/<percorso>/memory`, se la cartella è vuota;
4. fa il primo commit su `main` e lascia attivo `develop`.

Poi si apre Claude Code nel progetto e si parte da `plan/00-base.md`.

## Cosa c'è

| Percorso | Contenuto |
|---|---|
| `template/CLAUDE.md` | `@AGENTS.md` |
| `template/AGENTS.md` | tokensave, scala Ponytail, efficienza, verifica, le cinque agenzie con le due regole sempre valide, adattamenti da compilare |
| `template/CONVENTIONS.md` | §1–19: flusso di lavoro, codice, TypeScript, architettura, test, pubblicazione, Definition of Done; le parti legate allo stack sono marcate «da compilare» |
| `template/plan/` | `README.md` (come si lavora, Decisioni, Glossario, Fasi) e `00-base.md`, modello di ogni file di fase |
| `template/agents/` | cinque agenzie, 56 ruoli: un `README.md`, le regole comuni `00-common-rules.md` e un file per ruolo |
| `template/.claude/agents/` | un subagent per ruolo, che rimanda al suo file in `agents/` |
| `template/audit/`, `template/docs/` | struttura e regole; `docs/AI Multi-Agency System.md` è il prompt originale delle agenzie |
| `template/.github/workflows/ci.yml` | `npm run verify` e `npm run verify:e2e`, Node da `.nvmrc`; salta i passi finché F0 non crea gli script |
| `template/.gitignore` | `agents/`, `.claude/agents/`, `plan/`, `docs/`, `audit/` versionati; riga commentata per `audit/*/evidenze/` |
| `memory-seed/` | tre memorie di Claude Code: clear dopo ogni fase, agenzie senza subagent, decisioni con AskUserQuestion |

## Il metodo in breve

- **Una fase alla volta.** Ogni fase ha un file in `plan/` e un branch `fase/fN-nome` da `develop`. Si chiude con la procedura di CONVENTIONS §13.7: piano aggiornato, verify, un'unica conferma, poi commit, merge `--no-ff` in `develop`, push, `tokensave sync` e `/clear`. Il merge in `main` è un rilascio a parte, su richiesta (§13.8).
- **Agenzie su richiesta.** I ruoli sono un modo di lavorare della sessione principale; i subagent si avviano solo per gli audit o quando l'utente li chiede, e mai tutti insieme.
- **Conferma dell'utente.** Ogni decisione finale (backlog, architettura, dipendenze, commit, merge, push, deploy) è una proposta finché l'utente non la conferma.
- **Controlli.** `npm run verify` prima di ogni commit, `npm run verify:e2e` prima del merge di una fase; la CI esegue gli stessi due script.

## Aggiornare lo starter

Quando una regola migliora in un progetto e vale per tutti, si riporta in `template/`. I progetti già creati non si aggiornano da soli.
