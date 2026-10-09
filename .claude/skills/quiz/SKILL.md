---
description: Quiz façon examinateur (récupération espacée et entrelacée), quiz sur les compétences affichées au CV, ou auto-test du polycopié.
argument-hint: "[thème | veille | cumul | cv | autotest]"
disable-model-invocation: true
---

Quiz : $ARGUMENTS (vide = cumul).

- `autotest` : les 10 questions de l'auto-test de `docs/polycopie.md`, sans aide, correction seulement à la fin, score comparé à la ligne de base du J0 notée dans TUTOR_NOTES.
- `cv` : 5 questions sur les compétences affichées au CV de John et déjà traitées dans le projet (CLT/ABD, Tsai-Wu, Hashin, Puck, GCI, CS-23, MIL-STD-810H, random, Capella). Niveau entretien de bureau d'études : définition, hypothèses, limite de validité, application chiffrée.
- `veille`, `cumul` ou un thème : 5 questions, UNE à la fois, entrelacées :
  - 2 sur la veille ;
  - 2 sur les jours précédents ou la file de révision (priorité aux « trous sur compétence affichée ») ;
  - 1 question piège d'examinateur.
  Formats variés : petit calcul à la main avec unités, « pourquoi », lecture d'un résultat, détection d'erreur dans un énoncé, hypothèse à défendre.
- Pour chaque question : confiance de 1 à 5 avant correction ; correction brève ; en cas d'erreur, John reformule la bonne idée avec ses mots.
- À la fin : score, écart confiance/justesse (surconfiance ou sous-confiance), 2 points à revoir ajoutés à la file de révision avec une date de reprise.
- N'interroge que sur ce qui a été traité dans le projet ou dans les fiches de cours déjà ouvertes.
