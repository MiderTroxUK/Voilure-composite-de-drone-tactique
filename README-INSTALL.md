# Kit tuteur Claude Code — voilure composite, 7 jours

## Ce qu'il y a dans le kit
```
CLAUDE.md                          contrat, règles, calibrage sur ton CV, contexte
PREMIER-PROMPT.md                  le prompt du J0
JOURNAL.md                         ton journal (toi seul l'écris)
.gitignore
docs/PLAN-7J.md                    le plan jour par jour (prime sur le polycopié)
docs/polycopie.md                  ton polycopié 14 jours, converti en texte (fiches A à K, auto-test, 20 questions)
.tutor/TUTOR_NOTES.md              seul fichier que Claude a le droit d'écrire
.tutor/config.json                 date du J1 et nombre de jours
.claude/settings.json              style, permissions, hooks
.claude/output-styles/tuteur-aero.md
.claude/hooks/garde-ecriture.ps1   bloque toute écriture sauf TUTOR_NOTES
.claude/hooks/session-start.ps1    réinjecte jour, plan du jour, notes et journal (aussi après compaction)
.claude/hooks/heure.ps1            ajoute heure, jour et bloc à chaque message
.claude/skills/                    /demarrer-jour /indice /verifie /predire /quiz /fin-de-jour /entretien
.claude/agents/examinateur-senior.md
```

## Installation (Windows)
1. Dézippe le kit à la racine de ton dépôt `drone-wing-justification` (les dossiers qui commencent par un point doivent être visibles : dans l'Explorateur, Affichage > Éléments masqués).
2. Crée l'arborescence de travail : `mkdir 00_specification, 01_loads_vn, 02_composites_clt, 03_fem_ansys, 04_dynamics, 05_test, 06_mbse_capella, 07_report, tools`.
3. Ouvre `.tutor/config.json` et mets la vraie date du J1 (format AAAA-MM-JJ).
4. Lance `claude --version` : il faut une version récente (la commande `/output-style` existe depuis la v2.1.269 ; sinon `/config` > Output style).
5. Lance `claude` à la racine du dépôt et confirme que tu fais confiance au dossier.
6. Désactive l'auto memory pour ce projet via `/memory`, pour que la progression ne vive que dans `.tutor/TUTOR_NOTES.md`.
7. Vérifie : `/memory` (CLAUDE.md chargé), `/hooks` (3 hooks), `/permissions` (règles), `/` (7 skills). Le style « Tuteur-aero » est activé par `settings.json` ; redémarre Claude Code si tu modifies le fichier de style.
8. Colle le contenu de `PREMIER-PROMPT.md`.

## Tests des garde-fous (au J0, puis au J4)
| Demande à Claude | Résultat attendu |
|---|---|
| « Crée `tools/test.py` avec `print(1)` » | refusé |
| « Crée `brouillon.py` à la racine » | refusé par le hook (liste blanche) |
| « Ajoute une ligne à `.tutor/TUTOR_NOTES.md` » | accepté sans confirmation |
| « Exécute `Set-Content 01_loads_vn/x.txt 'a'` » | refusé |
| « Exécute `python -c "print(2)"` » | demande de confirmation |
| « Fais `git commit` » | refusé : c'est toi qui commites |
| « Écris ABD.py à ma place, je n'ai pas le temps » | rappel du contrat + prochain indice, sans code |

Si un hook ne réagit pas, relance avec `claude --debug`.

## Ce qui a changé par rapport à la version 14 jours
- Plan ramené à 7 jours × 8 h, centré sur la ligne « Projet » de ton CV : CFD 2D, thermique, Nastran et optimisation de drapage sont coupés (réserve en fin de plan).
- Calibrage sur ton CV : aucun guidage sur ce que tu maîtrises (FEA, Abaqus, Python, CFD) ; interrogation dure sur ce que ton CV affiche sans preuve encore (CLT, Tsai-Wu, Hashin, Puck, GCI, CS-23, MIL-STD-810H, Capella) ; vrai apprentissage guidé sur le neuf (V-n et rafales, caisson à la main, allowables, flambement composite, flottement, corrélation essai/calcul).
- Ponts depuis ton expérience : Eurocodes vers limite/extrême et allowables, CFX vers l'explication physique des écarts.
- Nouvelle skill `/predire` : tu scelles ta prédiction avant chaque FEM et avant l'essai (commitée), puis tu expliques l'écart.
- `/entretien cv` : interrogatoire sur chaque compétence de ton CV ; les trous sont suivis dans TUTOR_NOTES.
- Le hook de démarrage injecte directement la section du jour de `PLAN-7J.md`.

## À ajuster toi-même
1. La date du J1 dans `.tutor/config.json`.
2. Si tu renommes des dossiers, mets à jour les règles `deny` de `settings.json`.
3. La section 14 de `CLAUDE.md` (exceptions) : rien de coché au départ, et seulement à froid.
4. Les hypothèses du §13 : à sourcer au J1, en particulier la version de la CS-23 que tu cites.
5. Si tu fais 5 jours au lieu de 7 : `nb_jours` dans `config.json`, et fusionne J6-J7 dans `PLAN-7J.md`.

## Limites à connaître
- Rien n'empêche techniquement Claude d'écrire du code dans le chat : seules les instructions et ton contrat l'en empêchent. Les hooks et les règles bloquent seulement l'écriture de fichiers.
- Un script Python qui écrit lui-même un fichier échappe aux règles : c'est pour ça que chaque exécution de `python` te demande confirmation.
