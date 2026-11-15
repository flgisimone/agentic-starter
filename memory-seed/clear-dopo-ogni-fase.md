---
name: clear-dopo-ogni-fase
description: "In {{PROJECT_NAME}} l'utente riparte con /clear alla fine di ogni fase di plan/: lo stato va lasciato completo in plan/, git e memoria"
metadata:
  type: feedback
---

Alla fine di ogni fase di `plan/` l'utente lancia `/clear` e riparte da una sessione nuova.

**Why:** contiene i consumi (limiti di 5 ore e settimanali dell'abbonamento) ed è la regola «una sessione per fase» di AGENTS.md.
**How to apply:** prima di chiudere una fase aggiorna il file della fase in `plan/` (stato, esito, rilievi aperti) e `plan/README.md`; dopo commit/merge/push confermati dall'utente lancia `tokensave sync` dalla root, poi digli esplicitamente che può fare `/clear`. A inizio sessione riparti leggendo `plan/README.md` e il file della fase in corso. Vedi anche [[agenzie-regole]].
