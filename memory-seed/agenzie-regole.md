---
name: agenzie-regole
description: In {{PROJECT_NAME}} le agenzie si usano come ruoli della sessione principale, senza subagent; ogni decisione finale va confermata dall'utente
metadata:
  type: feedback
---

Sviluppo e verifiche nella sessione principale lavorando nei ruoli delle agenzie (AGENTS.md, «Agenzie»), **senza avviare subagent** salvo richiesta esplicita. Ogni decisione finale (backlog, specifiche, dipendenze, commit, merge, push, migrazioni) passa dalla conferma dell'utente.

**Why:** i subagent sono la voce più cara: un audit con molti subagent in parallelo può esaurire i limiti dell'abbonamento. Lavorare nei ruoli contiene i consumi e lascia all'utente il controllo delle decisioni.

**How to apply:** non lanciare subagent salvo richiesta esplicita; proponi con AskUserQuestion ([[decisioni-con-tendina]]) e attendi l'ok prima di commit, merge e push. Vedi [[clear-dopo-ogni-fase]].
