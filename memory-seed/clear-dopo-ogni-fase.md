---
name: clear-dopo-ogni-fase
description: "In {{PROJECT_NAME}} l'utente riparte con /clear alla fine di ogni fase di plan/: lo stato va lasciato completo in plan/, git e memoria"
metadata:
  type: feedback
---

Alla fine di ogni fase di `plan/` l'utente lancia `/clear` e riparte da una sessione nuova.

**Why:** contiene i consumi (limiti di 5 ore e settimanali dell'abbonamento) ed è la regola «una sessione per fase» di AGENTS.md.
**How to apply:** chiudi la fase con la procedura di CONVENTIONS §13.7: piano aggiornato, verify, un'unica conferma dell'utente per commit, merge `--no-ff` in `develop`, push e `tokensave sync`, poi digli esplicitamente che può fare `/clear`. Il merge in `main` solo se lo chiede (§13.8). A inizio sessione riparti leggendo `plan/README.md` e il file della fase in corso. Vedi anche [[agenzie-regole]].
