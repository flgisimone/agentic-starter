# Piano di {{PROJECT_NAME}}

<!-- Una o due frasi: cos'è il prodotto e per chi. -->

Questo piano raccoglie le decisioni prese e le fasi di lavoro, una per file.

## Come si lavora a una fase

- Ogni fase ha un file `NN-nome.md` con obiettivo, stato, agenzie, backlog, criteri di accettazione e, a fine fase, «Fatto», «Verifiche» e «Rilievi aperti» (modello: [00-base.md](00-base.md)).
- Si lavora su un branch `fase/fN-nome`, partendo da `develop`; le correzioni fuori fase su `fix/nome`.
- Prima del commit passa `npm run verify`; prima del merge passa anche `npm run verify:e2e` (dalla fase che lo introduce).
- Commit, merge in `develop` e push avvengono **solo dopo la conferma dell'utente**, come ogni decisione finale delle agenzie (AGENTS.md, «Agenzie»).
- A fine fase lo stato del file diventa «completata» con l'hash del merge, l'elenco di cosa è stato fatto e dei rilievi rimasti aperti; la riga in «Fasi» si aggiorna.
- Dopo il merge in `develop` si aggiorna l'indice del codice con `tokensave sync`, poi `/clear`.
- Le «proposte da confermare» nei file di fase si decidono con l'utente all'apertura di ciascuna.

## Decisioni

| Tema | Decisione | Motivo |
|---|---|---|
| Struttura | Repository creato da agentic-starter: AGENTS, CONVENTIONS, plan, agenzie, audit e docs versionati | Scelta dell'utente ({{DATE}}) |
| Agenzie | <!-- quali sono attive, quali tolte --> ; attivate solo quando un'attività lo richiede; ogni decisione finale passa dalla conferma dell'utente | <!-- F0 --> |
| Stack | <!-- da decidere in F0 --> | |
| Test | <!-- es. unitari con `node --test` su `src/lib`, e2e con Playwright su dati finti --> | |
| Rilascio | <!-- solo in locale fino a FN; poi hosting, deploy solo dopo l'approvazione dell'utente --> | |
| Lingua | Documentazione, piani, convenzioni e testi dell'interfaccia in italiano | Predefinito di agentic-starter |
| Branch | `develop` per lo sviluppo, `main` per le versioni stabili; una fase = un branch `fase/fN-nome` | Predefinito di agentic-starter |

## Glossario

<!-- I termini dell'interfaccia e del dominio, con le scelte dell'utente e la data. -->

## Fasi

| Fase | File | Contenuto | Stato |
|---|---|---|---|
| F0 | [00-base.md](00-base.md) | Base tecnica: stack, struttura, verify, CI, tokensave, agenzie attive | da fare |

Ordine: F0 → FN in sequenza; ogni fase si apre dopo il merge della precedente.
