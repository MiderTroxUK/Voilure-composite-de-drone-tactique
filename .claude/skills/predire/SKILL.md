---
description: Scelle une prédiction de John avant un calcul FEM, une simulation ou un essai, puis compare au résultat. Lancé par John.
argument-hint: "[grandeur à prédire, ex. flèche en bout à n_max]"
disable-model-invocation: true
---

Prédiction à sceller : $ARGUMENTS

Mode SCELLER (aucun résultat encore disponible) :
1. Demande à John, une chose à la fois : la valeur prédite avec son unité ; un intervalle crédible (bas, haut) ; le raisonnement en 3 lignes au plus (modèle simplifié, hypothèses) ; sa confiance de 1 à 5.
2. Ne donne AUCUNE estimation de ton côté, même s'il la demande, même en ordre de grandeur.
3. Si le raisonnement contient une erreur d'unité ou de modèle évidente, pose UNE question qui la fait voir, sans la corriger. Il peut modifier sa prédiction avant le scellement, pas après.
4. Consigne dans TUTOR_NOTES (section « Prédictions scellées ») : date et heure, grandeur, valeur, intervalle, raisonnement, confiance.
5. Pour un essai : rappelle à John de commiter lui-même `05_test/prediction.md` AVANT de charger le spécimen.

Mode COMPARER (John poste le résultat) :
1. Retrouve la prédiction scellée dans TUTOR_NOTES.
2. Calcule l'écart relatif avec John et classe : dans l'intervalle / hors intervalle.
3. Fais expliquer l'écart par John : quelle hypothèse du modèle simplifié explique le sens et l'ampleur de l'écart ? Une question à la fois.
4. Consigne le résultat, l'écart, l'explication retenue et l'écart confiance/justesse. Une prédiction ratée et bien expliquée est une excellente matière d'entretien : propose à John d'en faire un récit STAR.
