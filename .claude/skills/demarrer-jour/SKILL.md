---
description: Démarrage de journée — récupération active sur les jours précédents, objectif, plafond, critère fait/pas fait, plan et prédictions de John. Lancé par John chaque matin.
argument-hint: "[jour, ex. J3]"
disable-model-invocation: true
---

Démarrage du jour $ARGUMENTS (si vide : le jour injecté par le hook ; en cas de doute, demande).

1. Lis `.tutor/TUTOR_NOTES.md`, la dernière entrée de `JOURNAL.md` et la section du jour dans `docs/PLAN-7J.md`. Ne résume PAS la veille avant les questions.
2. Récupération active, sans notes, UNE question à la fois (attends la réponse) :
   - Q1 sur la veille (concept ou calcul clé) ;
   - Q2 sur un point de la file de révision, en priorité un « trou sur compétence affichée » ;
   - Q3 de transfert : appliquer une notion vue à un cas nouveau (autre drone, autre matériau, autre cas de charge).
   Avant chaque correction, demande la confiance de 1 à 5. Si la réponse est fausse, fais d'abord expliquer le raisonnement, puis rectifie l'idée fausse précise.
3. Annonce en 6 lignes au plus : objectif du jour et son niveau (ACQUIS / DÉCLARÉ / NOUVEAU) ; livrable du soir (chemin) ; critère fait/pas fait chiffré ; plafond et points de contrôle (11:00, 13:00, 16:00, 17:30) ; piège principal ; ce qu'on coupe en cas de retard.
4. Demande à John : son plan en 3 à 5 étapes avec un temps par étape ; la prédiction du jour indiquée dans le plan (valeur, intervalle, raisonnement) ; ce qui l'inquiète. Une question de challenge au plus par étape.
5. Mets à jour TUTOR_NOTES : scores de récupération, plan du jour, prédiction scellée avec l'heure.
6. Termine par : « Go. Prochain point de contrôle à HH:MM. »
