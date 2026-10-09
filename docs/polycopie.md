> Polycopié d'origine (14 jours), converti en texte pour Claude Code.
> Sert de référence pour les fiches de cours A à K, l'auto-test, la grille et les 20 questions.
> Le PLANNING en vigueur est docs/PLAN-7J.md : en cas de conflit, PLAN-7J.md prime.
> Les encadrés « avec Claude Code » et le §4.5 « On délègue » sont CADUCS : John écrit tout lui-même (voir CLAUDE.md).

Justification structurale — voilure composite de drone tactique 10-15 kg 7 sept. 2026 · MAJ logiciels 15 sept. 2026

Polycopié de projet · 14 jours · 112 heures

# Conception, justification multiphysique et essai d'une voilure composite de drone tactique

Projet personnel intensif · 14 jours × 8 h (112 h, 7 j/7). Objectif : premier poste d'ingénieur calcul de structures (puis ingénieur système), écosystème aéro/spatial/défense de Toulouse.

Objet

Voilure composite

Classe

10-15 kg · ~3 m

Référentiel

STANAG 4671

Livrable

Dossier 20-30 p.

Date de rédaction / vérification web : 7 septembre 2026 · Mise à jour logiciels (SOLIDWORKS 2026 + Ansys Student 2026 R1) : 15 septembre 2026 · Auteur : ton encadrant (enseignant-chercheur structures aéro + ingénieur calcul senior BE)

## TL;DR

l'essentiel en 3 points

1

**Oui, ce projet est faisable en 112 h et il ferme exactement le trou de ton CV** (zéro aéro aujourd'hui) : en 14 jours tu produis une chaîne complète _exigences → aéro/charges → composites → vibratoire → thermique → système → essai réel_ , sur un seul objet (voilure de drone tactique ~10-15 kg, ~3 m), tracée au **STANAG 4671** et justifiée par une **matrice de conformité**. C'est précisément ce que demandent les offres « stress engineer » d'Airbus (produire des reserve factors/marges selon des méthodes validées, hand-calc + FEM).

2

**La boîte à outils tient en deux logiciels principaux (mise à jour du 15 sept. 2026)** : **SOLIDWORKS 2026** pour la CAO et **Ansys Student 2026 R1** (Mechanical + ACP composites + Fluent, licence valable jusqu'au 31/03/2027). Tout le reste est gratuit : XFLR5, Python/PyMAPDL, Capella (l'outil MBSE de Thales), Arduino IDE 2 ou PlatformIO pour l'ESP32, Git, plus les normes libres (CS-23, MIL-STD-810H, MIL-HDBK-17). SU2, OpenFOAM, CalculiX, Nastran et Altair passent en option. **Si tu veux quand même une licence tierce (MSC, Altair), inscris-toi AVANT le 30 septembre** (tu es encore étudiant ESTIA ce mois-ci) et **commande le matériel le Jour 0** (le colis AliExpress met plus longtemps que le projet ne dure). Budget matériel réaliste : **40-100 €**.

3

**La règle de survie du projet, calibrée sur ton profil** : jalon quotidien + livrable visible + plafond d'heures par tâche, et quand le plafond tombe, **tu écris ce que tu as et tu passes à la suite**. Le calcul à la main vérifié par le FEM est ton fil conducteur ; Claude Code accélère le code mais **ne décide jamais** des hypothèses, des charges, ni de la validation.

0

Section 0

## Page de garde, sommaire, mode d'emploi

Titre du dossier livrable

_Justification structurale d'une voilure composite de drone tactique classe 10-15 kg — conformité STANAG 4671 (méthodologie), corrélation essai/calcul._

### Sommaire du polycopié

0Mode d'emploi 1Brief du projet 2Objectifs pédagogiques + auto-test 3Ressources (outils, référentiels, cours, BOM, commandes) 4Méthode d'ingénierie 5Planning 14 jours détaillé

6Les 14 sous-étapes + 11 fiches de cours 7Fabrication & essais 8Livrables & grille d'auto-évaluation 9Valorisation (LinkedIn, CV, pitch, 20 questions) 10Annexes (glossaire, templates, sources datées) +**Jour 0** : la checklist à faire AVANT de commencer.

### Comment utiliser ce document

  * Tu le suis **dans l'ordre**. Chaque matin tu lis le bloc du jour dans le planning (Section 5), puis tu ouvres la ou les sous-étapes correspondantes (Section 6).
  * Chaque sous-étape a la même structure : _objectif · problématique · fiche de cours · méthode pas-à-pas · sans IA / avec Claude Code · livrable · critère de validation chiffré · pièges · temps · lien matrice de conformité._
  * **Discipline de temps** : le plafond d'heures est un contrat avec toi-même. Dépassement = tu figes, tu notes « limite atteinte, état actuel : … », tu avances. Un dossier à 80 % complet vaut infiniment mieux qu'un chapitre parfait et trois chapitres vides.
  * **Traçabilité** : tout finit dans le dépôt GitHub, chaque résultat porte une date et une hypothèse source.

Les quatre encadrés du polycopié

Fiche de cours

La théorie minimale dont tu as besoin, juste avant de t'en servir.

Piège

L'erreur classique qui coûte une demi-journée ou un résultat faux.

Sans IA / avec Claude Code

Ce qu'on délègue, et le chemin manuel équivalent que tu dois savoir refaire.

Critère de validation

Le seuil chiffré qui dit « c'est bon, je passe à la suite ».

1

Section 1

## Brief du projet

### 1.1 Contexte industriel (Toulouse, défense/dual, 2026)

Toulouse est la capitale européenne de l'aéronautique et un pôle drone en croissance : **Delair** (drones tactiques à voilure fixe), **Airbus Defence and Space** , **Thales / Thales Alenia Space** , **Safran** , **Liebherr Aerospace** , **Latécoère** , et l'écosystème drone (Delair, Donecle). Le salon _Des Étoiles et Des Ailes_ (Carcassonne, sept. 2026) affichait pour l'Occitanie **100 000 emplois dans le secteur et un thème « Défense nationale »** — l'orientation défense/dual est donc porteuse pour un premier poste.

Ton objet de référence existe : le **Delair DT26E Surveillance**. D'après sa fiche technique constructeur (delair.aero), il pèse **15 kg (charge utile incluse)** , envergure **3,3 m** , longueur **1,6 m** , matériaux **composite (fibre de verre, carbone, kevlar) + mousse EPP** , **vitesse de croisière 57 km/h** , **endurance jusqu'à 170 min** , lancement **catapulte / atterrissage sur le ventre**. (À noter : Army Recognition mentionne un poids total plutôt de ~16 kg et une portée liaison jusqu'à 50 km ; garde ça comme fourchette.) C'est ta cible d'ordre de grandeur, à consigner comme **hypothèses de projet**.

### 1.2 Objet, périmètre, hors-périmètre

**Objet** : concevoir, justifier par calcul multiphysique et **tester physiquement** un **tronçon représentatif de voilure composite** d'un drone tactique 10-15 kg, ~3 m d'envergure, aile fixe, propulsion électrique, avec un **fil rouge réglementaire** (STANAG 4671, comparé au civil UE 2019/947).

Dans le périmètre

Spécification & exigences, diagramme V-n, charges, aéro (XFLR5 + CFD 2D), dimensionnement composite (CLT à la main + FEM coques), vibratoire/aéroélasticité, thermique du pod moteur, un modèle système léger sous Capella, fabrication + 2 essais, dossier de justification + valorisation.

Hors périmètre — à écrire noir sur blanc

Conception système complète du drone, avionique, liaison de données, charge utile détaillée, train/catapulte, essais en vol, tolérance aux dommages complète (BVID), fatigue full-scale, certification réelle.

### 1.3 Résultat attendu

Un **dossier de justification de 20-30 pages** \+ **matrice de conformité** \+ **note d'essais** \+ **dépôt GitHub** propre + **matériel physique testé**. Le tout démontrable en 3 minutes à un recruteur et défendable 30 minutes face à un ingénieur calcul senior.

### 1.4 Pourquoi ce projet « ouvre les portes » — cartographie compétence → poste

Chapitre du projet| Compétence prouvée| Poste / employeur visé  
---|---|---  
Exigences + matrice de conformité + STANAG/CS-23| Navigabilité, MoC, traçabilité| Ingénieur navigabilité / certification (Airbus, ADS)  
Diagramme V-n + charges| Loads & envelope| Loads engineer (Airbus)  
CLT Python + FEM coques stratifiées + RF| Calcul structures composites| **Ingénieur calcul structures / stress (Airbus, Safran, Latécoère)**  
CFD 2D profil| Aérodynamique numérique| Aéro/CFD (ADS, ONERA-like)  
Modale + random 3σ + flottement 1er ordre| Dynamique / environnement mécanique| Ingénieur dynamique/vibratoire (Thales Alenia Space, Safran)  
Thermique pod (CHT ou réseau 1D)| Thermique embarquée| Ingénieur thermique (TAS, ADS)  
Capella / Arcadia| MBSE, langage Thales| **Ingénieur système (Thales)**  
Essai instrumenté + corrélation| Essais / recalage modèle| Ingénieur essais  
Python (CLT, FFT, PyMAPDL, automatisation)| Automatisation calcul| Transverse, très différenciant  
  
2

Section 2

## Objectifs pédagogiques & prérequis

### 2.1 Objectifs

Savoir

Enveloppe de vol et diagramme V-n ; notion de charge limite vs charge extrême et **coefficient de sécurité 1,5** ; allowables A-basis/B-basis ; théorie classique des stratifiés (matrice ABD, contraintes par pli, critères Tsai-Wu / déformation max) ; règles de drapage ; flambement de peau ; analyse modale et réponse aléatoire (PSD, RMS, 3σ, Miles) ; notion de flottement ; Tg des composites ; cadre de certification (Part 21, EASA/DGAC/DSAÉ, STANAG 4671 vs 2019/947 vs CS-23) ; méthode Arcadia.

Savoir-faire

Produire polaires et distribution de portance sous XFLR5 ; faire tourner une CFD 2D convergée ; écrire un script CLT et le confronter à un FEM coques ; calculer des reserve factors ; mener une analyse modale et une random vibration ; construire une matrice de conformité ; instrumenter et exploiter un essai (raideur + modal), recaler le modèle.

Savoir-être

Tenir un planning en timeboxing ; documenter hypothèses et unités ; **être honnête sur les écarts** (un écart de 30 % expliqué vaut mieux qu'un écart de 3 % non compris) ; utiliser l'IA comme accélérateur, pas comme oracle.

### 2.2 Auto-test de prérequis

10 questions — corrige-toi avec les fiches de cours.

01

Différence entre **charge limite** et **charge extrême** ?

Réponse cible : limite = max en service ; extrême = limite × 1,5, tenue ≥ 3 s sans rupture.

02

Valeur du coefficient de sécurité structural en aéro civil ?

1,5.

03

Définis le **reserve factor** RF et la **marge de sécurité** MS.

RF = allowable/appliqué ; MS = RF − 1.

04

Que contient la matrice **ABD** ?

Couplages membrane [A], membrane-flexion [B], flexion [D].

05

Écris le critère de **Tsai-Wu** en une phrase.

Critère quadratique d'interaction des contraintes dans le repère du pli.

06

Pourquoi surveiller la **séparation flexion/torsion** ?

Convergence des deux → risque de **flottement**.

07

Que sont **RMS** et la **règle 3σ** en random ?

Écart-type de contrainte ; on dimensionne à 3× l'écart-type.

08

Qu'est-ce que la **Tg** d'une résine et pourquoi c'est critique ?

Température de transition vitreuse ; au-delà, chute de propriétés.

09

Cite les **3 catégories** du règlement UE 2019/947.

Open, Specific, Certified.

10

Que fait l'**analyse opérationnelle** dans Arcadia ?

Décrit le besoin/usage avant toute solution technique.

Si tu rates plus de 4 questions, ce n'est pas grave : c'est exactement ce que le projet t'apprend. Note ton score de départ ; tu le repasseras au Jour 14.

### 2.3 Ce que tu maîtrises déjà (et qu'on va réutiliser)

FEA ANSYS Mechanical (statique/dynamique/cyclique) → transférable direct au FEM coques. MATLAB/Simulink, **Python solide** (SciPy/NumPy/PyTorch) → CLT, FFT, PyMAPDL. SolidWorks (2026 installé) → CAO voilure, export Parasolid/STEP vers Ansys. Optimisation (PSO, BFGS) → bonus drapage. **Le seul vrai delta, c'est le domaine aéro (composites, CS-25/CS-23, Nastran, vibratoire aéro, thermique embarquée).** Ce projet est construit pour combler ce delta et rien d'autre.

3

Section 3

## Ressources

### 3.1 Outils

Disponibilité vérifiée le 7 sept. 2026, **mise à jour le 15 sept. 2026** (SOLIDWORKS 2026 + Ansys Student 2026 R1 installés). Le chiffre en marge est le jour d'installation ; « opt. » = facultatif, « — » = plus nécessaire.

Pile minimale retenue

**Déjà là** : SOLIDWORKS 2026 SP04.1 (CAO) · Ansys Student 2026 R1 (Mechanical, ACP, Fluent, Meshing, CFD-Post). **À installer** : XFLR5 6.62 · Python 3 + numpy/scipy/matplotlib/pandas + `ansys-mapdl-core` · Capella 7.1.0 · Arduino IDE 2 (cartes ESP32 3.3.x) ou VS Code + PlatformIO/pioarduino · bibliothèques HX711_ADC + MPU6050/ADXL345 · Git (ou GitHub Desktop) · VS Code · Overleaf (en ligne). **Inutile pour ce projet** : CATIA, Onshape, FreeCAD, Fusion, Altair/Simcenter Student, LS-DYNA Student (pas de crash/impact dans le périmètre), OpenFOAM/WSL.

J1

**Ansys Student 2026 R1** Gratuit · installé · licence jusqu'au 31/03/2027ansys.synopsys.com/academic/students

Outil central : **ACP Pre & Post** (plis composites), Mechanical (statique, flambement linéaire, modal, random vibration, thermique stationnaire), **Fluent** (CFD 2D profil + CHT pod), Meshing, CFD-Post/EnSight, SpaceClaim/Discovery, optiSLang. **Limites :** structural **128 000** nœuds/éléments ; CFD **1 million** de cellules/nœuds ; 4 cœurs CPU ; **pas d'export de géométrie** (la CAO se fait dans SolidWorks et s'importe dans Ansys, jamais l'inverse). Windows 10/11 64 bits, installation sur PC physique (pas de VM), usage éducatif. Licence utilisable même après la fin du statut étudiant. Pas de système « flottement » : il reste en Python à partir des modes Ansys. _À vérifier au J6 : comptage des plis ACP dans la limite de 128 000 (repli : plis dans Mechanical ou CalculiX)._

opt.

**MSC Nastran + Patran Student (Cadence)** Gratuit · étudiant inscrit · bonuscadence.com › msc-software › academics

Contre-vérification modale (SOL 103), « écart Ansys/Nastran ». **Plus nécessaire** avec Ansys Student ; bonus seulement. MSC appartient à **Cadence** depuis le 23/02/2026 (rachat de la branche D&E de Hexagon). Édition étudiante toujours gratuite « avec taille de modèle limitée », sans chiffre publié (5 000 nœuds historiquement, trop peu pour l'aile complète). Réservée aux étudiants inscrits, donc à demander avant fin septembre si tu la veux.

opt.

**Altair Student Edition (Siemens)** Gratuit · e-mail école · non nécessairesiemens.com › altair-student-edition

Alternative FEM/optim (OptiStruct), drapage. **Doublon avec Ansys Student → on ne l'installe pas.** Toujours offerte par Siemens via Altair One, produits renommés Simcenter (HyperMesh, OptiStruct…). Exige un e-mail institutionnel, qui ne sera plus valide après septembre 2026.

J1

**SOLIDWORKS 2026 SP04.1** Installé · licence étudiantesolidworks.com

CAO de la voilure : profil importé par _Insertion › Courbe › Courbe passant par des points XYZ_ (fichier `.sldcrv`/`.txt` généré en Python depuis les coordonnées du profil, en mm), lissage longitudinal, surfaces de peau + longeron, puis **export Parasolid (`.x_t`) ou STEP** → import dans SpaceClaim/Mechanical (et ACP). Pour le FEM coques, exporter des **surfaces** (ou extraire les surfaces moyennes dans SpaceClaim). Remplace CATIA, Onshape, FreeCAD et Fusion, qui ne sont plus nécessaires. SOLIDWORKS Simulation / Flow Simulation, si ta licence les inclut, ne servent pas ici : Ansys fait le calcul.

J1

**XFLR5** (v6.62, mars 2026)Gratuit · Win/Mac/Linuxsourceforge.net/projects/xflr5

Polaires profil, VLM/LLT, distribution de portance, Cp. **Limites :** non visqueux couplé ; pas de décrochage 3D fin.

—

**OpenFOAM** (openfoam.com v2606, juin 2026)Gratuit · non nécessaireopenfoam.com / .org

Remplacé par **Fluent** (Ansys Student) pour la CFD 2D. Sous Windows il faut WSL, Docker ou des exécutables cross-compilés : trop de mise en place pour 14 jours.

opt.

**SU2** (v8.5.0 « Harrier », avril 2026)Gratuit · LGPL · bonusgithub.com/su2code/SU2/releases

CFD 2D profil (RANS, SA/SST) en **contre-vérification open source** de Fluent, seulement si tu as du temps (réserve J4). Le fonctionnement natif des binaires Windows n'a pas été confirmé : teste-le avant d'en dépendre.

opt.

**CalculiX** (v2.23, build Windows natif)Gratuit · repligithub.com/calculix/CalculiX-Windows

Repli FEM coques/composites (format type Abaqus), à installer **seulement si** ACP ou la limite de 128 000 bloquent au J6. Fichier `CalculiX-2.23.0-win-x64.zip` dans le dossier `releases/` du dépôt, sans WSL. Pré-post CGX rustique.

opt.

**Salome-Meca / Code_Aster** (2025, EDF)Gratuit · open-sourcecode-aster.org

Repli FEM avancé. **Limites :** Windows via binaire/Docker.

opt.

**Gmsh / ParaView** (Gmsh 4.15.2 · ParaView 6.0.x stable)Gratuit · avec SU2 seulementgmsh.info · paraview.org

Maillage / post-traitement de la chaîne open source. Dans la chaîne principale, le maillage se fait dans **Ansys Meshing** (ou Fluent Meshing) et le post dans **Fluent / CFD-Post**.

J11

**Capella** (Eclipse, v7.1.0, juillet 2026)Gratuit · open-sourcembse-capella.org

MBSE Arcadia — « langage Thales ». Créé par Thales, ouvert en 2014. **Limites :** Java, Win/Mac/Linux.

J5

**PyMAPDL / PyAnsys** Gratuitmapdl.docs.pyansys.com

Piloter Ansys en Python (cas, post) : `pip install ansys-mapdl-core`. Nécessite une licence Ansys locale ; la doc PyMAPDL **gère explicitement l'installation Student** (lancement en mode SMP). Les limites Student s'appliquent. La compatibilité de PyACP et PyFluent avec la licence Student n'est pas documentée : n'en fais pas dépendre le planning.

J1

**Python 3 · pyNastran · MATLAB / Octave** Gratuit / licence ESTIApython.org · pypi · octave.org

Environnement dédié (`python -m venv` ou Miniconda) : `numpy scipy matplotlib pandas ansys-mapdl-core` pour le V-n, la CLT, le flottement, le réseau thermique 1D et les FFT d'essai. pyNastran seulement si tu fais le bonus Nastran. MATLAB en repli via la licence ESTIA (tant qu'elle est active), sinon **Octave**.

J1

**Arduino IDE 2 ou VS Code + PlatformIO (ESP32)** Gratuitarduino.cc · github.com/pioarduino

Firmware d'acquisition des bancs (J12-13). Le plus simple : **Arduino IDE 2** \+ paquet de cartes Espressif **esp32 3.3.x**. Sous PlatformIO, utiliser la plateforme communautaire **pioarduino** : la plateforme officielle est restée au core 2.x. Bibliothèques : **HX711_ADC** (olkal, lecture non bloquante) + une bibliothèque MPU6050 ou ADXL345 (Adafruit). Installe l'IDE dès J1 pour tester la carte à la réception du colis.

J1

**Git / GitHub Desktop · VS Code · Overleaf** Gratuitgit-scm.com · code.visualstudio.com · overleaf.com

Dépôt `drone-wing-justification`, édition des scripts, rédaction du dossier (Overleaf en ligne, rien à installer). Ajoute un `.gitignore` pour les résultats Ansys lourds (`*_files/`, `*.rst`, `*.dat`) : on ne versionne que les `.wbpz` archivés et les exports CSV.

Piège licences

Tu es étudiant ESTIA **jusqu'à fin septembre 2026**. Ansys Student 2026 R1 ne demande pas de justificatif et reste valable jusqu'au **31/03/2027** : c'est lui qui porte le projet. MSC (Cadence) et Altair (Siemens) exigent un statut étudiant ou un e-mail d'école : ils ne sont **pas nécessaires** , mais si tu veux Nastran en bonus, demande-le **avant le 30 septembre**. CATIA n'est plus utile (SolidWorks installé). Pas d'Ansys Student 2026 R2 prévue : ne réinstalle rien en cours de projet.

### 3.2 Référentiels

Accès vérifié le 7 sept. 2026.

**STANAG 4671 / AEP-4671 (USAR)** Accès public restreint

Navigabilité UAV **à voilure fixe militaire, 150 kg à 20 000 kg** , **structuré sur EASA CS-23** (origine standard DGA français). Édition en vigueur = **Édition 3 (2 avril 2019)** renvoyant à **AEP-4671 Éd. B** ; Éd. 1 = sept. 2009, Éd. 2 = fév. 2017. Sert pour : cas de charge, facteurs, exigences structurales. Un texte de la _draft Edition 1_ circule (dror-aero.com/link/usar_edition_1.pdf) ; EverySpec liste le STANAG ; version à jour payante (Accuris/GlobalSpec).

**Piège :** ton drone de 10-15 kg est SOUS le seuil de 150 kg → tu utilises le STANAG comme **cadre méthodologique** , pas comme applicabilité stricte : à écrire explicitement dans la matrice.

**EASA CS-23** (Normal/Utility/Aerobatic/Commuter)Gratuit · easa.europa.eu

Subpart C : **23.303** (coef. sécurité 1,5), **23.333** (enveloppe), **23.335** (vitesses de calcul V_C, V_D), **23.337** (facteurs de manœuvre), **23.341** (rafales). Base du diagramme V-n. Easy Access Rules / CS-23.

**EASA CS-25** Gratuit

Gros avions ; culture « limit/ultimate », 25.303 coef. 1,5.

**AMC 20-29 / FAA AC 20-107B** Gratuit · easa · faa

Bonnes pratiques **composites** : building-block, knock-down environnement, damage tolerance, B-basis. Harmonisés (AMC 20-29 = AC 20-107B).

**MIL-STD-810H** Gratuit · EverySpec

Environnement : **Méthode 514.8 vibration** (Procédures I-IV, profils avion à hélice/UAV en annexes B-F), **501.7 haute temp.** , **502.7 basse temp.**

**MIL-HDBK-17 (/1F, /2, /3F)** Gratuit · EverySpec / DTIC

Allowables composites, définitions A/B-basis, méthodo d'essais, design/analyse. **CMH-17 databank** (données matériaux) = **payant** (Hexagon).

**UE 2019/947 (opérations) + 2019/945 (produit)** Gratuit · EUR-Lex

Catégories **Open/Specific/Certified** ; comparatif civil pour la matrice.

**SORA 2.5 (JARUS)** Gratuit · easa

Méthode d'évaluation de risque, indice **SAIL I-VI** (GRC + ARC). Intégrée aux AMC/GM 2019/947 (ED Decision 2025/018/R, sept. 2025 ; Easy Access Rules UAS révision juin 2026).

**DO-160G (RTCA)** Payant · from $849.00

Conditions environnementales équipements embarqués (identique EUROCAE ED-14G). À **citer** , pas à acheter. PDF mono-utilisateur listé « Priced From $849.00 » (Accuris), pack complet ~1 019 $.

### 3.3 Cours & lectures (gratuits sauf mention)

Ressource| Chapitres à lire| Durée| Lien / accès  
---|---|---|---  
**FAA Pilot's Handbook of Aeronautical Knowledge** (FAA-H-8083-25)| Aérodynamique, facteurs de charge, enveloppe de vol| 2-3 h ciblées| faa.gov (PDF gratuit)  
**FAA Aviation Maintenance Technician Handbook — Airframe** (FAA-H-8083-31B)| Construction cellule, structures, réparations composites| 1-2 h| faa.gov (PDF gratuit) ; Open Textbook Library  
**TU Delft edX — Introduction to Aeronautical Engineering**|  Portance, polaire, performances| audit gratuit| edX / online-learning.tudelft.nl  
**TU Delft edX — Introduction to Aerospace Structures and Materials**|  Composites, allowables, structures| audit gratuit| edX (DelftX)  
**MIT OCW 16.20 Structural Mechanics**|  Poutres, torsion, panneaux| ciblé| ocw.mit.edu/courses/16-20  
**MIT OCW 16.001 Unified Engineering** (Materials & Structures)| Bases matériaux/structures aéro| ciblé| ocw.mit.edu/courses/16-001  
**BIA (Brevet d'Initiation Aéronautique)** — HorizonBIA| Culture aéro générale FR (aérodynamique, météo, réglementation)| survol| horizonbia.com (gratuit)  
**AMC 20-29**|  Building-block, knock-down| 1 h| easa.europa.eu  
  
### 3.4 BOM matériel ≤ 100 € (deux variantes) + planning des commandes

A**Variante « tout AliExpress » — ~40-60 €, à commander le Jour 0 ou avant**

Article| Prix indicatif| Rôle  
---|---|---  
ESP32 DevKit| ~5 €| Acquisition essais  
MPU6050 (ou ADXL345) accéléromètre| ~2-3 €| Essai modal par impact  
HX711 + cellule de charge 5 kg| ~5-14 € (kit combiné vu à ~13,7 $)| Essai de raideur  
Tube carbone (Ø ~8-12 mm, 1 m)| ~8-15 €| Longeron  
Plaque carbone fine + mousse XPS| ~10 €| Peau / caisson  
Kit fibre de verre + résine époxy| ~10-15 €| Stratifié / collage  
Consommables (comparateur à cadran, câbles Dupont, colle)| ~10 €| Montage  
  
Piège · délai Chine = risque n° 1

La livraison AliExpress dépasse souvent la durée du projet. **Commande le Jour 0** , et **prévois systématiquement un plan B local** pour ne pas bloquer les essais (J12-13).

B**Variante « qualité modélisme » — ~90-100 €, livraison rapide**

  * Plaques/tubes carbone : **PB-Modélisme** , **Guixmodel** , magasins modélisme FR (délai 2-4 j).
  * Capteurs : **Amazon Prime FR** (ex. _DIYmalls cellule 5 kg + HX711_ vendu et expédié par Amazon ; ESP32 ELEGOO ; ADXL345). Livraison 24-48 h.
  * Mousse XPS, masses de test (sacs de sable, bouteilles d'eau 1 L = 1 kg pratique), colle époxy bi-composant : **Leroy Merlin** (plan B immédiat).

Fablab — fabrication du spécimen

**Artilect (Toulouse centre)** : impression 3D **3-4 €/h** , découpe laser **25-36 €/h** , adhésion donnant **−33 % sur les machines** ; ateliers d'initiation ~2-3 h ; machines Ultimaker/Creality, laser Trotec/Epilog.

**FabLab de l'Université de Toulouse** (CampusFab / Le Catalyseur) : adhésion **7 € étudiant** (30 € personnels) — le moins cher. Autres : **Fabric'INSA** , RoseLab.

Planning des commandes

Jour 0 → passer commande A (AliExpress) _et_ réserver le budget B (Amazon Prime) ; si le colis Chine n'est pas arrivé au Jour 10, bascule sur B/Leroy Merlin sans hésiter.

4

Section 4

## Méthode d'ingénierie

### 4.1 Cycle en V allégé

Besoin (mission ISR)→ Exigences (spéc.)→ Architecture (voilure)→ Conception (drapage, longeron)→ Analyse (aéro, FEM, modale, thermique)→ Essai (raideur, modal)→ Vérification (matrice de conformité)

La branche descendante (gauche) définit _ce qu'on veut_ ; la branche montante (droite) _prouve qu'on l'a atteint_. La matrice de conformité fait le lien entre les deux.

### 4.2 Gestion des exigences & matrice de conformité (document central)

Chaque exigence = une ligne : **ID · énoncé · source (STANAG/CS-23/MIL-STD) · Moyen de Conformité (MoC) · chapitre qui la traite · résultat (RF/marge) · statut (ouvert/justifié/non couvert)**. Les 4 **MoC** classiques :

Analyse

Calcul/FEM — l'essentiel de ton projet.

Essai

Tes 2 essais réels.

Similarité

Référence à un produit qualifié, ex. DT26.

Inspection

Vérification visuelle/documentaire.

### 4.3 Bonnes pratiques de note de calcul BE

1

**Hypothèses en tête de note** (masse, vitesses, n, matériaux, conditions limites) — jamais enfouies.

2

**Unités SI cohérentes** ; en FEM, fixe un système (ex. tonne-mm-s-MPa pour Nastran/Ansys) et **vérifie une masse connue**.

3

**Convergence de maillage** : raffiner jusqu'à variation < 5 % sur la grandeur d'intérêt.

4

**Vérification d'ordre de grandeur** systématique (hand-calc avant FEM).

5

**Traçabilité** : version, date, auteur, source de chaque donnée. Un résultat sans hypothèse source = résultat mort.

### 4.4 Gestion du temps (timeboxing)

Plafond d'heures par sous-étape (indiqués en Section 6). **Règle du plafond** : à échéance, tu figes, tu écris « limite atteinte — état : … — reste à faire : … », tu passes. Tu t'ennuies vite sur le répétitif : c'est exactement pour ça qu'on découpe en livrables courts et variés, et qu'on automatise le répétitif avec Claude Code.

### 4.5 Usage raisonné de Claude Code — et le chemin « sans IA »

On délègue

Squelettes de scripts (CLT, FFT, tracé V-n), parsing de fichiers résultats, génération de cas de calcul paramétrés, boucles PyMAPDL, mise en forme LaTeX/Markdown, code d'acquisition ESP32.

On ne délègue jamais

Le choix des hypothèses, la sélection des cas de charge, l'interprétation physique, la validation des ordres de grandeur, la décision « RF acceptable ou non ».

**Chemin sans IA équivalent** documenté à chaque sous-étape : tu dois être capable de refaire le calcul à la main / à la calculette / dans un tableur. En entretien, on te demandera _le raisonnement_ , pas le prompt.

5

Section 5

## Planning 14 jours

Matin 4 h / après-midi 4 h. Chaque jour : un livrable visible, un critère « fait / pas fait », et ce qu'on coupe si on est en retard.

J1

MatinFinir installs (SolidWorks, Ansys 2026 R1) + XFLR5, Python, Capella, Arduino IDE, Git

Après-midiSpécification + hypothèses de projet + **commande BOM**

LivrableFiche de spécification v1 + panier commandé

Fait / pas faitSpéc rédigée & commande partie

On coupeCAO détaillée

J2

MatinFiche V-n + charges ; construire diagramme V-n (Python)

Après-midiXFLR5 : géométrie voilure, polaires profil

LivrableDiagramme V-n + polaires

Fait / pas faitV-n tracé, n_max/V_D fixés

On coupeBalayage multi-profils

J3

MatinXFLR5 : distribution de portance (LLT/VLM), Schrenk à la main

Après-midiExtraction charges à n_max/n_min → torseur par section

LivrableNote de charges + fichier charges

Fait / pas faitCharges exportées

On coupeAnalyse de stabilité

J4

MatinFiche CFD 2D ; maillage profil (Ansys Meshing, inflation, < 1 M cellules)

Après-midiCFD 2D **Fluent** (SA ou k-ω SST), convergence, Cl/Cd vs XFLR5

LivrableRapport CFD 2D (y+, résidus, écart XFLR5)

Fait / pas faitCas convergé

On coupe2ᵉ angle d'incidence · contre-vérif SU2

J5

MatinFiche CLT ; script ABD + Tsai-Wu (Python)

Après-midiDimensionnement drapage à la main (RF pli)

LivrableScript CLT validé + drapage v1

Fait / pas faitRF pli calculés

On coupeOptimisation drapage

J6

MatinFEM coques stratifiées : surfaces SolidWorks → **ACP** (plis) → Mechanical, CL

Après-midiCas n_max/n_min : flèche, contraintes, RF

LivrableModèle FEM + résultats statiques

Fait / pas faitRF FEM obtenus

On coupeSous-modèle local

J7

MatinFlambement linéaire peau supérieure ; convergence maillage

Après-midiComparaison main/FEM, note d'écart

LivrableNote « main vs FEM » + flambement

Fait / pas faitÉcart commenté < 15 % visé

On coupeÉtude paramétrique

J8

MatinFiche modale ; analyse modale FEM (flexion/torsion)

Après-midiSéparation fréq. flexion/torsion ; (bonus) contre-vérif Nastran SOL 103

LivrableModes propres + séparation flexion/torsion

Fait / pas faitf1…f5 obtenues

On coupeNastran (bonus, non installé par défaut)

J9

MatinFiche random ; PSD MIL-STD-810H 514, réponse, RMS, 3σ

Après-midiFlottement 1er ordre en Python (modes Ansys → marge fréquentielle/vitesse)

LivrableNote vibratoire (RMS, RF 3σ)

Fait / pas faitRF 3σ calculé

On coupeFlottement détaillé

J10

MatinFiche thermique ; réseau 1D Python (pod ~30 W)

Après-midiThermique stationnaire Mechanical OU CHT Fluent (plafond)

LivrableNote thermique (T_ESC, marge Tg)

Fait / pas faitMarge Tg calculée

On coupeCHT Fluent → 1D seul

J11

MatinFiche Capella/Arcadia ; analyse opérationnelle + système

Après-midiAllocation exigences → voilure ; ou traçabilité tableur

LivrableModèle Capella léger (4 diagrammes)

Fait / pas faitAllocation faite

On coupeCapella → tableur exigences

J12

MatinFabrication spécimen (fablab / à la maison) + cure

Après-midiMontage bancs d'essai (câblage ESP32, code acquisition)

LivrableSpécimen + bancs prêts

Fait / pas faitSpécimen curé, capteurs OK

On coupeGéométrie simplifiée

J13

MatinEssai raideur (masses + comparateur/HX711) vs FEM

Après-midiEssai modal par impact (FFT) vs f1 calculée

LivrableTableau de corrélation essai/calcul

Fait / pas fait2 essais faits

On coupe1 seul essai si panne

J14

MatinRédaction dossier (assemblage, matrice de conformité)

Après-midiValorisation : GitHub, LinkedIn, CV, pitch, Q/R

LivrableDossier 20-30 p. + dépôt publié

Fait / pas faitDossier livré

On coupeAnnexes secondaires

Tampon

Les demi-journées « optionnel » (Nastran, CFD 2ᵉ point, CHT Fluent) sont tes réserves. Si tu es à l'heure, tu les fais ; sinon, elles sautent sans casser la chaîne.

6

Section 6

## Les sous-étapes & fiches de cours

> Convention : chaque sous-étape suit le gabarit _objectif · problématique · théorie · méthode · sans IA/avec IA · livrable · critère · piège · temps · matrice._

1

### Spécification & hypothèses de projet

J1 · 4 h

**Objectif** : figer les données d'entrée. **Problématique** : sur quels chiffres tout le reste repose-t-il ?

Fiche — hypothèses de projet (ordres de grandeur sourcés, à consigner)

  * Masse max décollage : **~15 kg** (réf. DT26E, à assumer). Envergure **~3 m** , corde moyenne **~0,25-0,30 m** , allongement élevé (planeur tactique).
  * Profil : un profil de planeur/UAV documenté (ex. famille **NACA 4412 / Clark Y / S1223 / MH** — choisis-en un et justifie ; les coordonnées sont publiques).
  * Vitesses : croisière **~16 m/s (57 km/h, réf. DT26E)** ; V_C et V_D à dériver du V-n (voir fiche ci-dessous).
  * Facteurs de charge : **n = +3,8 / −1,52** (catégorie Normal CS-23 ; voir fiche V-n).
  * Matériaux : **UD carbone T300/époxy** (E₁ ≈ 130 GPa, E₂ ≈ 8-9 GPa, G₁₂ ≈ 4,5-5 GPa, ν₁₂ ≈ 0,3, X_t ≈ 1500-2100 MPa, Y_t ≈ 60-75 MPa — valeurs publiques, à citer comme ordres de grandeur, à re-sourcer sur MIL-HDBK-17) ; tissu carbone, verre/époxy, mousse (Rohacell/XPS).
  * Pod moteur/ESC : dissipation **~30 W** (hypothèse). Tg résine époxy modélisme : **~70-120 °C** (à re-sourcer selon résine).

Sans IA / avec Claude Code

_Sans IA_ : tu remplis le tableau à la main depuis les fiches DT26 + CS-23. _Avec Claude Code_ : génère le template Markdown de spéc et un tableau LaTeX. 

Livrable _Spécification v1_ (1-2 pages).

CritèreChaque valeur a une source ou est marquée « hypothèse ».

PiègePartir sur des chiffres « au feeling » non tracés.

MatriceCrée les 15-25 premières lignes d'exigences ici.

A

Fiche de cours

Enveloppe de vol, diagramme V-n, vitesses de calcul, rafales

  * **Diagramme V-n** : facteur de charge n (rapport portance/poids) en ordonnée, vitesse en abscisse. Frontière basse vitesse = **courbe de portance max** (n = ½ρV²·S·C_Lmax / W) ; frontière haute = **facteurs limites** jusqu'à **V_D**.
  * **Facteurs de manœuvre** (CS-23.337 / 14 CFR 23.337) : positif **n need not exceed +3,8** (Normal) ; négatif = **0,4 × positif = −1,52** (Normal). Utility : +4,4/−1,76 ; Aerobatic : +6,0/−3,0.
  * **Vitesses (CS-23.335)** : **V_C** (croisière de calcul) ≥ 33·√(W/S) (Normal, en nœuds, W/S en psf) et ≤ 0,9 V_H ; **V_D** (piqué de calcul) ≥ **1,25 V_C** , et ≥ 1,40 V_C,min (Normal). **V_A** (manœuvre) = V_S·√n.
  * **Enveloppe de rafales (CS-23.341)** : rafales discrètes (~valeurs de l'ordre de 66/50/25 ft/s EAS à V_B/V_C/V_D à basse altitude, réduites avec l'altitude) avec facteur d'atténuation de Pratt. L'enveloppe finale = **combinaison** manœuvre + rafales.
  * **STANAG 4671** : structuré sur CS-23 ; applicabilité **150 kg-20 000 kg** (ton drone est en dessous → cadre méthodologique).

2

### Diagramme V-n & enveloppe de vol

J2 matin · 3-4 h

**Objectif** : produire l'enveloppe qui fixe les cas de charge. **Problématique** : à quelle vitesse et quel n dimensionne-t-on ?

**Méthode** : script Python traçant les branches C_Lmax et les plafonds n = +3,8/−1,52, positionner V_A, V_C, V_D.

Sans IA / avec Claude Code

_Sans IA_ : formules à la main dans un tableur. _Avec Claude Code_ : « génère une fonction Python qui trace un diagramme V-n paramétré par W, S, C_Lmax, n+, n−, V_C, V_D et annote V_A ». **Tu** fournis et vérifies les nombres. 

LivrableFigure V-n + tableau des points de calcul.

CritèreV_D ≥ 1,25 V_C ; V_A cohérent ; cas n_max/n_min identifiés.

PiègeConfondre vitesse vraie / équivalente / calibrée.

Matrice« Tenue à n_max charge extrême », « tenue à n_min ».

B

Fiche de cours

Charges limites/extrêmes, coefficient 1,5, RF, allowables A/B-basis

  * **Charge limite** : charge max attendue en service. **Charge extrême = 1,5 × limite** (CS-23.303 / CS-25.303 : « a factor of safety of 1.5 must be used » ; FAA 14 CFR 23.2230 : _ultimate = limit × 1.5_). La structure tient l'extrême **≥ 3 s sans rupture**.
  * **Reserve Factor** : **RF = contrainte (ou charge) admissible / contrainte appliquée**. **Marge MS = RF − 1**. RF ≥ 1 ⇒ OK. On calcule les RF **à la charge extrême** pour la rupture, **à la limite** pour la déformation/le flambement selon le critère.
  * **Allowables A-basis / B-basis** (MIL-HDBK-17) : valeur au-dessus de laquelle se trouve **99 % (A) ou 90 % (B)** de la population avec **95 % de confiance**. B-basis pour structure redondante, A-basis pour chemin de charge unique.
  * **Knock-down** : abattement des allowables pour environnement (chaud/humide) et dommages (AMC 20-29 / AC 20-107B, approche building-block).

3

### Aérodynamique & extraction des charges

J2 pm + J3 · ~7 h

**Objectif** : distribution de portance et torseur par section. **Problématique** : comment passer d'un C_L global à une charge répartie sur le longeron ?

C

Fiche de cours

Aéro de la voilure

Portance L = ½ρV²S·C_L ; **distribution elliptique idéale** ; **approximation de Schrenk** = moyenne entre distribution réelle de corde et ellipse ; **XFLR5** : LLT (Lifting Line, ailes droites allongées), VLM (Vortex Lattice), méthode panneaux ; limites : non visqueux couplé, décrochage 3D approximatif. 

**Méthode** : XFLR5 → polaires du profil → analyse d'aile à n_max (V correspondant) → exporter la distribution de portance → intégrer en effort tranchant/moment fléchissant par section (poutre encastrée à l'emplanture).

Sans IA / avec Claude Code

_Sans IA_ : Schrenk + intégration manuelle par tranches dans un tableur. _Avec Claude Code_ : script d'intégration effort tranchant/moment à partir du CSV XFLR5. **Tu** valides la portance totale = n·W. 

LivrableNote de charges + fichier `loads.csv`.

Critère∫portance ≈ n·W à ±5 % ; moment à l'emplanture cohérent en ordre de grandeur.

PiègeOublier le poids propre de l'aile / le facteur n dans la portance.

Matrice« Charges de manœuvre STANAG/CS-23 dérivées ».

D

Fiche de cours

CFD 2D : maillage, y⁺, turbulence, convergence, validation

  * **Maillage** : raffinement en bord d'attaque/fuite et dans la couche limite (inflation). **y⁺** : y⁺ ≈ 1 pour résoudre la paroi (SST), ou y⁺ 30-300 avec lois de paroi.
  * **Modèles de turbulence** : **Spalart-Allmaras (SA)** (aéro externe attachée, robuste) ; **k-ω SST** (gradients de pression, décollement).
  * **Convergence** : résidus qui chutent de plusieurs ordres + Cl/Cd stabilisés. **Validation** : comparer Cl/Cd à XFLR5 et à des polaires de référence.

4

### CFD 2D du profil

J4 · ~7 h

**Objectif** : vérifier XFLR5 par une RANS 2D. **Problématique** : XFLR5 est-il fiable à mon incidence de calcul ?

**Méthode** (mise à jour 15/09) : Workbench _Fluid Flow (Fluent)_ → géométrie 2D du profil dans SpaceClaim/DesignModeler (domaine en C, analyse 2D) → **Ansys Meshing** (inflation en couche limite, **< 1 million de cellules**, limite Student) → **Fluent** 2D double précision, RANS Spalart-Allmaras ou k-ω SST, à l'incidence de croisière → Cl, Cd, Cp → post dans Fluent / CFD-Post. _Bonus si réserve de temps_ : même cas en SU2 8.5 (maillage Gmsh, post ParaView) pour une contre-vérification open source.

Sans IA / avec Claude Code

_Sans IA_ : suivre un tuto Ansys « NACA 2D airfoil » (Fluent, Ansys Innovation Courses / Cornell SimCafe). _Avec Claude Code_ : générer le fichier de coordonnées du profil, un journal Fluent (`.jou`) pour balayer l'incidence et un script Python de post-traitement Cp. **Tu** juges la convergence. 

LivrableRapport CFD 2D (maillage, y⁺, résidus, Cp, écart XFLR5).

CritèreCas convergé ; écart Cl vs XFLR5 < ~10-15 % (sinon, explique).

PiègeMaillage trop grossier en couche limite → y⁺ incohérent → Cd faux.

Matrice« Validation du modèle aérodynamique ».

E

Fiche de cours

Théorie classique des stratifiés (CLT), ABD, Tsai-Wu, drapage

  * **Pli UD** : Q (matrice de rigidité réduite) dans le repère du pli, tournée en Q̄ selon l'angle.
  * **Matrice ABD** : [N; M] = [A B; B D]·[ε⁰; κ]. **A** = rigidité membrane, **D** = rigidité flexion, **B** = couplage (nul si stratifié **symétrique**).
  * **Contraintes par pli** : de ε⁰/κ → déformations par pli → contraintes dans le repère du pli.
  * **Critères de rupture** : **déformation max** , **Tsai-Wu** (quadratique, interaction des composantes), **Tsai-Hill**. RF = f(critère).
  * **Règles de drapage** : **symétrie** (annule B), **équilibre** (autant de +θ que de −θ), règle des **10 %** (≥10 % de plis dans chaque direction 0/±45/90), pas plus de 3-4 plis identiques adjacents.

5

### Dimensionnement composite à la main (CLT Python)

J5 · ~7 h

**Objectif** : drapage justifié + RF par pli. **Problématique** : quel empilement tient le moment d'emplanture ?

**Méthode** : script Python `ABD.py` (Q, Q̄, A/B/D, résolution ε⁰/κ, contraintes par pli, Tsai-Wu) ; appliquer le moment de la sous-étape 3 ; itérer le drapage.

Sans IA / avec Claude Code

_Sans IA_ : dérouler la CLT dans un tableur pour 3-4 plis (fais-le au moins une fois, c'est LA compétence). _Avec Claude Code_ : « écris une classe Python CLT calculant ABD et l'indice de Tsai-Wu par pli, avec test unitaire sur un cas de la littérature ». **Tu** compares à une biblio CLT existante (ex. bibliothèques CLT open-source) pour valider. 

Livrable`ABD.py` \+ drapage v1 + RF par pli.

CritèreScript validé sur un cas connu (< 2 % d'écart) ; RF ≥ 1 à la charge extrême.

PiègeOublier la symétrie (B ≠ 0) ; mélanger repère global/pli.

Matrice« Résistance stratifié à charge extrême ».

F

Fiche de cours

Caisson/longeron d'aile : flexion, cisaillement, flambement de peau

  * **Poutre-caisson** : semelles (longeron) reprennent la **flexion** (σ = M·y/I), âmes reprennent le **cisaillement** (flux τ = V·Q/I).
  * **Flux de cisaillement** dans un caisson fermé (Bredt pour la torsion : q = T/2A_m).
  * **Flambement de peau** : panneau comprimé (semelle sup. en manœuvre positive) → contrainte critique σ_cr ∝ k·E·(t/b)². Vérifier avant la rupture matière.
  * **Effets locaux** : introductions d'efforts, découpes, jonctions → concentrations.

6

### FEM coques stratifiées : statique

J6 · ~7 h

**Objectif** : flèche, contraintes, RF sur la vraie géométrie. **Problématique** : le hand-calc tient-il en 3D avec la vraie forme ?

**Méthode** (mise à jour 15/09) : surfaces de peau/longeron modélisées dans **SOLIDWORKS** → export Parasolid/STEP → Workbench : _Geometry_ → **ACP (Pre)** (matériau T300/époxy, fabrics, rosettes, oriented selection sets, plies) → _Static Structural_ (Mechanical) → **ACP (Post)** pour les critères par pli (Tsai-Wu, déformation max) et les RF. Repli si ACP bloque : _Layered Section_ dans Mechanical, puis **CalculiX**. CL : encastrement emplanture. Charges n_max/n_min (pression ou efforts nodaux depuis `loads.csv`). Sortie : flèche en bout, contraintes/déformations par pli, RF.

Sans IA / avec Claude Code

_Avec Claude Code + PyMAPDL_ : script qui balaie les cas de charge et exporte les RF ; **fonctionne avec Ansys Student** (licence locale, limites Student appliquées → **reste sous 128 000 nœuds/éléments**). PyMAPDL pilote MAPDL, pas l'interface ACP : utilise-le pour les variantes (modèle APDL à section stratifiée) ou le post des fichiers résultats, et garde ACP en GUI. _Sans IA_ : mise en données GUI classique. 

LivrableModèle FEM + tableau RF.

CritèreMasse modèle ≈ masse attendue ; flèche plausible ; RF ≥ 1 extrême.

PiègeDépasser la limite Student de 128 000 (le solveur crée des éléments de contact cachés) ; mauvais repère matériau des plis (rosettes ACP) ; exporter des volumes au lieu de surfaces depuis SolidWorks.

Matrice« Justification par analyse FEM ».

7

### Flambement + convergence + écart main/FEM

J7 · ~7 h

**Objectif** : flambement linéaire de la peau supérieure + note d'écart. **Problématique** : quel est le mode critique, et pourquoi main ≠ FEM ?

**Méthode** : _Eigenvalue Buckling_ (facteur de charge critique λ) sur la peau comprimée ; étude de convergence de maillage (3 densités) ; tableau comparatif hand-calc vs FEM.

Sans IA / avec Claude Code

_Avec Claude Code_ : script de convergence (auto-raffinement + tracé). _Sans IA_ : 3 maillages à la main. 

LivrableNote flambement + note « main vs FEM ».

CritèreConvergence < 5 % ; écart main/FEM < 15 % (sinon expliqué) ; λ_flambement > 1 à la charge extrême.

PiègeFlambement linéaire optimiste (pas d'imperfections) → à mentionner.

Matrice« Non-flambement peau », « convergence démontrée ».

G

Fiche de cours

Analyse modale & réponse aléatoire, flottement

  * **Modale** : fréquences propres f_i et déformées (flexion 1, torsion 1, flexion 2…). **Séparation flexion/torsion** : si f_torsion et f_flexion se rapprochent sous charge aéro → risque de **flottement**.
  * **Random (MIL-STD-810H 514)** : excitation décrite par une **PSD** (g²/Hz). Réponse → **contrainte RMS** (1σ). **Règle de Miles** : σ_RMS ≈ √(π/2 · f_n · Q · PSD). On dimensionne à **3σ** (99,7 %). **RF_3σ = allowable / (3·σ_RMS)**.
  * **Flottement (1er ordre)** : vitesse de flottement estimée par la convergence des modes ; on vérifie une **marge** (typiquement V_flottement > 1,15-1,2 V_D).

8

### Analyse modale

J8 · ~7 h

**Objectif** : modes propres + séparation flexion/torsion. **Méthode** : _Modal_ Ansys (5-10 premiers modes) ; identifier flexion/torsion ; _bonus_ : **contre-vérification Nastran SOL 103** si tu as obtenu la licence étudiante Cadence/MSC (« écart Ansys/Nastran »). Sinon, contre-vérifie f1 par un calcul poutre à la main (Euler-Bernoulli encastrée-libre) ; c'est tout aussi défendable en entretien.

Sans IA / avec Claude Code

_Avec Claude Code_ : parsing du `.f06` Nastran via pyNastran, tableau comparatif. _Sans IA_ : lecture directe. 

LivrableTableau f_i + déformées + comparatif.

Critèref1 physique (aile souple → quelques Hz à quelques dizaines de Hz) ; écart Ansys/Nastran < 10 %.

PiègeMasses ponctuelles (moteur/pod) oubliées → f faussées.

Matrice« Comportement dynamique ».

9

### Random vibration & flottement

J9 · ~7 h

**Objectif** : RF à 3σ + marge de flottement. **Méthode** : appliquer une **PSD de la Méthode 514** (profil avion à hélice/UAV, annexes MIL-STD-810H) ; réponse aléatoire FEM → σ_RMS → 3σ → RF ; estimer la marge de flottement au 1er ordre.

Sans IA / avec Claude Code

_Avec Claude Code_ : script Miles + post random. _Sans IA_ : Miles à la calculette sur le mode dominant. 

LivrableNote vibratoire.

CritèreRF_3σ ≥ 1 ; marge flottement documentée.

PiègeConfondre 1σ et 3σ ; PSD mal unitée (g²/Hz).

Matrice« Tenue à l'environnement vibratoire MIL-STD-810H 514 ».

H

Fiche de cours

Thermique embarquée

  * **Modes** : conduction (Fourier q = −k∇T), convection (q = h·A·ΔT), rayonnement (souvent négligé ici). **CHT** = conjugate heat transfer (solide + fluide couplés).
  * **Réseau thermique 1D** : résistances R = L/(kA) et 1/(hA) en série/parallèle, source ~30 W. T_composant = T_ambiant + Q·ΣR.
  * **Critère composite** : garder **T_stratifié < Tg − marge** (la résine perd ses propriétés près de la Tg).

10

### Thermique du pod moteur/ESC

J10 · ~7 h

**Objectif** : T_ESC et marge vs Tg. **Méthode** : réseau 1D Python (rapide, robuste) **et/ou** thermique stationnaire Mechanical ; option CHT Fluent avec **plafond d'heures strict** (air dynamique).

Sans IA / avec Claude Code

_Avec Claude Code_ : solveur réseau 1D + étude de sensibilité à h. _Sans IA_ : résistances à la main. 

LivrableNote thermique.

CritèreMarge Tg > 0 aux conditions chaudes (MIL-STD-810H 501) ; cohérence 1D vs FEM.

Piègeh de convection choisi arbitrairement → donne une fourchette.

Matrice« Tenue thermique / marge Tg ».

I

Fiche de cours

Essais : raideur, modal par impact, FFT, corrélation

  * **Raideur** : charge P connue → flèche δ mesurée → **k = P/δ** ; comparer k_essai vs k_FEM.
  * **Modal par impact** : un choc (marteau/impact) excite tous les modes ; l'accéléromètre capte la réponse ; la **FFT** révèle f1.
  * **Incertitudes** : répétabilité (3-5 essais), résolution du comparateur, bruit capteur, conditions d'encastrement (jamais parfait).
  * **Corrélation** : |f_essai − f_calc|/f_calc ; un écart de 10-20 % est **normal** en première corrélation (conditions limites réelles ≠ idéales).

11

### Modèle système Capella / Arcadia

J11 · ~7 h

**Objectif** : parler « Thales » et montrer l'ouverture système. **Problématique** : comment relier le besoin opérationnel à une exigence de voilure ?

K

Fiche de cours

Capella / Arcadia en bref

Méthode **Arcadia** (créée par Thales, normalisée AFNOR Z67-140), 4 niveaux : **Analyse Opérationnelle** (que veut l'utilisateur), **Analyse du Besoin Système** (ce que le système doit faire), **Architecture Logique** , **Architecture Physique**. Outil **Capella** (Eclipse, open-source). 

**Méthode** : modéliser 4 diagrammes minimaux : entités/activités opérationnelles (mission ISR), fonctions système, allocation d'une exigence structurale (« tenir n = +3,8 ») à la voilure, lien de traçabilité. **Repli** si Capella trop lourd : **matrice d'exigences structurée en tableur** avec allocation.

Sans IA / avec Claude Code

_Avec Claude Code_ : générer la trame de traçabilité (repli tableur). _Sans IA_ : construire les diagrammes à la main dans Capella. 

LivrableModèle Capella léger (ou tableur d'exigences).

CritèreAu moins une exigence tracée du besoin opérationnel jusqu'à la voilure.

PiègeVouloir modéliser tout le drone → timeboxe à 6-8 h.

MatriceLie la matrice de conformité au modèle système.

J

Fiche de cours

Certification : Part 21, EASA/DGAC/DSAÉ, STANAG 4671 vs 2019/947 vs CS-23, MoC

  * **Civil habité** : EASA, **CS-23/CS-25** , **Part 21** (DOA = Design Org Approval, POA = Production Org Approval), AMC 20-29 composites.
  * **Drones civils** : **UE 2019/947** (opérations : Open/Specific/Certified) + **2019/945** (produit) ; **SORA 2.5** → **SAIL**. DGAC/AlphaTango, scénarios STS en France.
  * **Drones militaires** : **DSAÉ** (France), **STANAG 4671 / AEP-4671** (150 kg-20 000 kg, dérivé de CS-23).
  * **MoC** : analyse / essai / similarité / inspection. La **matrice de conformité** est le tableau de bord de la navigabilité.

**Sous-étapes 12-14** — Fabrication, essais, dossier : voir Sections 7 et 8.

7

Section 7

## Fabrication & essais

### 7.1 Plan de fabrication du spécimen

**Option recommandée (simple, robuste)** : un **tronçon de longeron = tube carbone** \+ une **peau carbone/mousse** collée, longueur ~0,5-0,7 m, encastré à une extrémité (bride bois/impression 3D serrée dans un étau). Alternative : **plaque carbone + mousse XPS** (sandwich) représentative de la peau.

Sécurité résine / carbone

Gants nitrile, masque FFP2 au ponçage (poussière de carbone = irritant/conducteur), local ventilé, résine époxy loin de la peau/yeux, respecter le **temps de cure** (souvent 24 h à température ambiante avant essai — planifie la cure la veille des essais).

1

### Banc — essai de raideur

**Montage** : spécimen encastré horizontalement ; charges par **masses connues** (bouteilles d'eau 1 L = 1 kg, ou plaques). Mesure de flèche par **comparateur à cadran** (simple, fiable) ou **cellule HX711** \+ ESP32.

**Protocole** : 5 paliers de charge montée/descente, 3 répétitions ; tracer P vs δ, pente = k.

_Avec Claude Code_ : code Arduino/ESP32 HX711 (calibration avec masse étalon) + script Python de régression. _Sans IA_ : comparateur + tableur.

2

### Banc — essai modal par impact

**Montage** : accéléromètre (**MPU6050** ou ADXL345) collé en bout de spécimen, ESP32 échantillonnant ; impact bref (petit choc).

**Protocole** : 5-10 impacts, FFT de la réponse, relever le **pic = f1**.

_Avec Claude Code_ : firmware d'acquisition rapide + FFT Python (scipy). _Sans IA_ : acquisition + FFT tableur/Octave.

Piège — échantillonnage

Fréquence d'échantillonnage trop basse (respecte Nyquist : Fe ≥ 2× f attendue, vise ≥ 10×) ; MPU6050 limité en cadence → si f1 élevée, privilégie l'ADXL345 en SPI ou réduis la raideur (spécimen plus long).

### 7.4 Corrélation essai/calcul

Grandeur| Calcul (FEM)| Essai| Écart| Explication  
---|---|---|---|---  
Raideur k (N/mm)| …| …| …%| encastrement réel, cure, Vf  
f1 (Hz)| …| …| …%| masse ajoutée capteur, CL  
  
Critères

**k_essai vs k_FEM à ±20 %** et **f1_essai vs f1_calc à ±15 %** sont d'excellents résultats pour une première corrélation maison. Au-delà, ce n'est pas un échec : **analyse les causes** (rigidité d'encastrement, fraction volumique de fibre réelle, masse du capteur) — c'est exactement le raisonnement de recalage qu'on attend d'un ingénieur essais/calcul.

8

Section 8

## Livrables finaux & grille d'auto-évaluation

### 8.1 Structure du dossier de justification (20-30 p.)

01 Résumé + hypothèses de projet

02 Spécification & exigences

03 Enveloppe de vol (V-n)

04 Charges

05 Aéro (XFLR5) + CFD 2D

06 Composites : CLT + FEM + RF + flambement

07 Vibratoire (modale + random 3σ + flottement)

08 Thermique

09 Modèle système (Capella)

10 Fabrication & essais + corrélation

11 **Matrice de conformité**

12 Conclusions, limites, perspectives

Annexes : scripts, notes de calcul.

### 8.2 Matrice de conformité (extrait de gabarit)

ID| Exigence| Source| MoC| Chap.| Résultat| Statut  
---|---|---|---|---|---|---  
**STR-01**|  Tenue à n=+3,8 (extrême ×1,5)| STANAG 4671/CS-23.337+303| Analyse+Essai| 6, 13| RF=…| Justifié  
**STR-02**|  Non-flambement peau| CS-23| Analyse| 7| λ=…| Justifié  
**DYN-01**|  Séparation flexion/torsion| Bonne pratique| Analyse| 8| Δf=…| Justifié  
**ENV-01**|  Random MIL-STD-810H 514 (3σ)| MIL-STD-810H| Analyse| 9| RF_3σ=…| Justifié  
**THM-01**|  Marge Tg| MIL-STD-810H 501| Analyse| 10| ΔT=…| Justifié  
  
### 8.3 Arborescence GitHub
    
    
    drone-wing-justification/
    ├── README.md (résumé, images, résultats clés)
    ├── 00_specification/
    ├── 01_loads_vn/           (script V-n, loads.csv)
    ├── 02_aero_xflr5_cfd/
    ├── 03_composites_clt_fem/ (ABD.py, modèles)
    ├── 04_dynamics/
    ├── 05_thermal/
    ├── 06_mbse_capella/
    ├── 07_test/               (firmware, données, FFT)
    ├── 08_report/             (dossier PDF, matrice)
    └── tools/ (scripts Claude Code + versions "manuelles")

### 8.4 Grille de notation (façon école — pondération)

Critère| Poids| Non acquis| Partiel| Acquis  
---|---|---|---|---  
Exigences & matrice de conformité| **15 %**|  pas de matrice| matrice partielle| matrice complète, MoC tracés  
Charges & V-n| **10 %**|  n non justifié| V-n tracé| cas de charge dérivés proprement  
Aéro + CFD| **10 %**|  pas de CFD| CFD non convergée| CFD convergée + écart XFLR5 commenté  
Composites (CLT+FEM+RF)| **25 %**|  pas de RF| RF FEM seul| main **et** FEM, écart < 15 %  
Vibratoire (modale+random)| **15 %**|  pas de modes| modes seuls| random 3σ + RF  
Thermique| **5 %**|  —| 1D seul| 1D + FEM, marge Tg  
Système (Capella)| **5 %**|  rien| tableur| modèle Capella tracé  
Essais + corrélation| **10 %**|  pas d'essai| 1 essai| 2 essais + corrélation analysée  
Dossier & GitHub| **5 %**|  brouillon| correct| publication-ready  
  
### 8.5 Check-list « prêt pour un recruteur »

☐Dossier PDF relu, hypothèses en tête

☐Matrice de conformité complète

☐GitHub public propre + README avec visuels

☐Au moins un RF < 1,3 discuté (montre que tu sais dimensionner « au juste besoin »)

☐Écarts essai/calcul expliqués

☐Pitch 3 min répété

☐20 questions préparées

9

Section 9

## Valorisation

### 9.1 Trois posts LinkedIn (structure)

« J'ai passé 14 jours à concevoir et casser une aile de drone »

Accroche + photo du spécimen + 1 résultat (RF, corrélation). Objectif : reach.

« Calcul à la main vs FEM : l'écart de 12 % que j'ai dû expliquer »

Pédagogique, montre la rigueur. Screenshot CLT + FEM.

« Du besoin opérationnel à l'exigence de voilure : mon modèle Capella »

Cible les recruteurs Thales/système. Diagramme Arcadia + matrice.

Chaque post : problème → méthode → résultat chiffré → lien GitHub → 3-5 hashtags (#aerospace #stress #composites #MBSE #Toulouse).

### 9.2 Lignes CV

›« Justification structurale complète d'une voilure composite de drone tactique (CLT + FEM coques Ansys, RF à charges extrêmes, flambement) — écart hand-calc/FEM < 15 %. » ›« Chaîne multiphysique (aéro XFLR5/CFD Ansys Fluent, composites Ansys ACP, modale + random MIL-STD-810H 3σ, thermique) tracée STANAG 4671, matrice de conformité. » ›« Essai instrumenté (ESP32/HX711, modal par FFT) et corrélation essai/calcul. » ›« Modèle MBSE Capella/Arcadia (méthode Thales) + automatisation Python/PyMAPDL. »

### 9.3 Pitch d'entretien (3 min)

« J'ai voulu combler mon manque d'expérience aéro par un projet dense : dimensionner et **prouver** une aile de drone tactique 15 kg de bout en bout. J'ai construit le diagramme V-n à partir de CS-23 (+3,8/−1,52, extrême ×1,5), dérivé les charges via XFLR5 vérifié en CFD, dimensionné le stratifié **à la main par CLT** puis en **FEM coques Ansys** , avec un écart de X %. J'ai enchaîné modale, random 3σ selon MIL-STD-810H, thermique du pod, un modèle système Capella, puis j'ai **fabriqué et testé** un tronçon : essai de raideur et modal, corrélés au FEM à ±Y %. Tout est tracé dans une matrice de conformité et publié sur GitHub. Ça m'a appris le vocabulaire et les méthodes de votre BE. »

### 9.4 20 questions d'examinateur calcul

Réponses attendues, 2-3 lignes.

**1 · Charge limite vs extrême ?** Limite = max en service ; extrême = limite × 1,5, tenue ≥ 3 s sans rupture.

**2 · Pourquoi 1,5 ?** Facteur historique couvrant incertitudes matériau/charges/fabrication ; CS-23.303/25.303.

**3 · RF et MS ?** RF = admissible/appliqué ; MS = RF − 1 ; OK si ≥ 0.

**4 · A-basis vs B-basis ?** 99 %/90 % de la population au-dessus, à 95 % de confiance ; B pour redondant.

**5 · Matage (bearing) ?** Rupture en pression de contact d'un trou/fixation ; vérifier bearing + bypass.

**6 · Flambement : qu'est-ce qui pilote ?** Géométrie (t/b), E, conditions aux limites ; σ_cr ∝ E(t/b)².

**7 · Tsai-Wu vs déformation max ?** Tsai-Wu = critère interactif quadratique ; def. max = non interactif, plus physique par mode.

**8 · Rôle de B dans ABD ?** Couplage membrane-flexion ; nul si stratifié symétrique — d'où la règle de symétrie.

**9 · Règle des 10 % / drapage ?** ≥10 % de plis par direction, équilibre ±θ, symétrie, pas trop de plis identiques adjacents.

**10 · Convergence de maillage ?** Raffiner jusqu'à variation < ~5 % sur la grandeur d'intérêt.

**11 · Coques vs solides pour un stratifié ?** Coques stratifiées (efficaces, plis explicites) sauf effets 3D locaux/délaminage.

**12 · Tolérance aux dommages (composites) ?** BVID, no-growth/damage tolerance, knock-down, AMC 20-29/AC 20-107B.

**13 · Fail-safe vs safe-life ?** Fail-safe = chemins redondants après défaillance ; safe-life = durée sans fissure.

**14 · Modale : à quoi ça sert ?** Éviter résonance/couplage ; base de la réponse dynamique et du flottement.

**15 · Random 3σ / Miles ?** σ_RMS via Miles ; on dimensionne à 3σ (99,7 %) ; RF = admissible/3σ.

**16 · Flottement ?** Couplage flexion/torsion instable ; marge V_flottement > V_D.

**17 · SOL Nastran ?** 101 statique linéaire, 103 modes réels, 105 flambement, 111 réponse fréquentielle, 108/112 transitoire.

**18 · Knock-down environnement ?** Abattement des allowables en chaud/humide (proche Tg) ; d'où marge Tg.

**19 · y⁺ en CFD ?** Distance paroi adimensionnée ; ~1 pour résoudre la couche limite (SST), 30-300 avec lois de paroi.

**20 · Pourquoi hand-calc si on a le FEM ?** Vérifier l'ordre de grandeur, détecter les erreurs de modèle, signer une justification défendable.

### 9.5 Réutilisation pour un poste ingénieur système

Le modèle Capella + la matrice de conformité + la traçabilité besoin→exigence→vérification constituent un mini-dossier MBSE : mets-le en avant pour Thales (Arcadia/Capella est leur méthode maison). Reformule le pitch autour de « j'ai tenu la traçabilité des exigences de bout en bout ».

10

Section 10

## Annexes

### 10.1 Glossaire FR / EN

Charge limite = _limit load_

Charge extrême = _ultimate load_

Coefficient de sécurité = _factor of safety_

Facteur de réserve = _reserve factor (RF)_

Marge de sécurité = _margin of safety (MS)_

Admissible = _allowable_

Abattement = _knock-down_

Tolérance aux dommages = _damage tolerance_

Sûreté par redondance = _fail-safe_

Durée de vie sûre = _safe-life_

Moyen de conformité = _means of compliance (MoC)_

Drapage = _lay-up_

Pli = _ply_

Stratifié = _laminate_

Flambement = _buckling_

Flottement = _flutter_

Effort tranchant = _shear force_

Moment fléchissant = _bending moment_

Enveloppe de vol = _flight envelope_

Rafale = _gust_

Transition vitreuse = _glass transition (Tg)_

### 10.2 Templates

Page de garde note de calcul

Titre · Réf · Version · Date · Auteur · Vérificateur · Objet · Hypothèses · Références · Résultats · Conclusion.

Matrice de conformité

Cf. §8.2.

Journal de bord quotidien

Date · Bloc matin (fait/pas fait) · Bloc après-midi · Livrable · Heures réelles vs plafond · Blocages · Décisions · À faire demain.

Fiche d'essai

Objet · Montage (schéma) · Matériel · Protocole · Étalonnage · Données brutes · Traitement · Résultat · Incertitudes · Corrélation calcul.

### 10.3 Check-list convergence de maillage

☐3 densités testées

☐grandeur d'intérêt < 5 % de variation

☐qualité d'éléments (jacobien, aspect ratio)

☐y⁺ vérifié (CFD)

☐masse/volume conformes

☐CL non sur-contraintes

### 10.4 Unités & ordres de grandeur (garde-fous)

Système FEM conseillé

**t-mm-s → N, MPa, tonne** (ρ carbone ≈ 1,6e-9 t/mm³ ; E ≈ 130 000 MPa).

Ordres de grandeur attendus

Moment d'emplanture ~ quelques centaines de N·m ; flèche en bout ~ cm ; f1 aile souple ~ quelques Hz à quelques dizaines de Hz ; σ carbone admissible ~ centaines à > 1000 MPa ; T_ESC < ~60-80 °C visé.

### 10.5 Sources vérifiées

Consultées le 7 septembre 2026.

**[MAJ 15/09/2026]** Ansys Student 2026 R1 — ansys.synopsys.com/academic/students/ansys-student : licence jusqu'au 31/03/2027 ; 128K nœuds/éléments structure, 1M cellules fluide, 4 cœurs, pas d'export géométrie ; bundle incluant ACP Pre & Post, Mechanical, MAPDL, Fluent/CFX, Discovery, SpaceClaim, optiSLang. (Remplace les limites 32 000 / 512 000 de la version 2024 R2.)

**[MAJ 15/09/2026]** MSC Nastran/Patran Student — cadence.com/en_US/home/tools/msc-software/academics.html (rachat Hexagon D&E par Cadence finalisé le 23/02/2026 ; taille de modèle limitée, chiffre non publié).

**[MAJ 15/09/2026]** Altair Student Edition — siemens.com (…/engineering-student-software/altair-student-edition/) ; via Altair One, e-mail institutionnel, produits renommés Simcenter.

SOLIDWORKS 2026 SP04.1 (installé) — remplace CATIA / Onshape / FreeCAD / Fusion pour ce projet.

**[MAJ 15/09/2026]** XFLR5 6.62 (sourceforge.net/projects/xflr5, 24/03/2026) ; OpenFOAM v2606 (openfoam.com) ; SU2 8.5.0 (github.com/su2code/SU2/releases, 27/04/2026) ; CalculiX 2.23 Windows (github.com/calculix/CalculiX-Windows) ; Gmsh 4.15.2 (gmsh.info, 24/03/2026) ; ParaView 6.0.x stable (6.2.0-RC2 le 12/09/2026) ; Salome-Meca 2025 / Code_Aster (code-aster.org).

Capella 7.1.0 (mbse-capella.org ; projects.eclipse.org/projects/polarsys.capella, release 10/07/2026 ; créé par Thales, ouvert 2014, Arcadia normalisée AFNOR Z67-140).

PyMAPDL (mapdl.docs.pyansys.com — `launch_mapdl` détecte l'installation Student et lance en SMP).

**[MAJ 15/09/2026]** ESP32 : Arduino-ESP32 core 3.3.11 ; PlatformIO via github.com/pioarduino/platform-espressif32 ; HX711_ADC (github.com/olkal/HX711_ADC).

STANAG 4671 : Wikipedia (NATO STANAG 4671, Éd. 3 avril 2019, AEP-4671 Éd. B, 150 kg-20 000 kg, dérivé CS-23) ; draft Éd. 1 (dror-aero.com) ; EverySpec (NATO-STANAG) ; NATO STO MP-AVT-273-08.

EASA CS-23 (23.303/335/337/341) ; CS-25 ; AMC 20-29 ; FAA AC 20-107B — easa.europa.eu / faa.gov ; 14 CFR 23.337, 23.335, 23.2230 (eCFR/govinfo).

MIL-STD-810H (méthodes 514.8, 501.7, 502.7) — EverySpec / CVG Strategy.

MIL-HDBK-17/1F, /2E, /3F — EverySpec / DTIC (A-/B-basis).

UE 2019/947 & 2019/945 — EUR-Lex/EASA ; SORA 2.5 / SAIL (ED Decision 2025/018/R ; Easy Access Rules UAS révision juin 2026) — easa.europa.eu.

DO-160G — RTCA ; prix « from $849 » (Accuris store).

Delair DT26E (15 kg, 3,3 m / 1,6 m, composite verre/carbone/kevlar + EPP, croisière 57 km/h, endurance 170 min) — delair.aero / aeroexpo.

Propriétés T300/époxy (E₁ ~116-146 GPa selon Vf ; T700 E₁ ≈ 128,6 GPa, E₂ ≈ 7,5 GPa, G₁₂ ≈ 4,8 GPa, X_t ≈ 2100 MPa, Y_t ≈ 76 MPa) — NTNU TMM4175 ; arXiv 2305.05289 ; MatWeb.

Cours : TU Delft edX (Intro Aeronautical Eng ; Aerospace Structures & Materials, audit gratuit) ; MIT OCW 16.20 & 16.001 ; FAA Pilot's Handbook (FAA-H-8083-25) & Airframe (FAA-H-8083-31B) PDF gratuits ; BIA (Éduscol/HorizonBIA gratuit).

Fablabs Toulouse : Artilect (3D 3-4 €/h, laser 25-36 €/h, −33 % adhérents — artilect.fr) ; FabLab Université (adhésion 7 € étudiant — catalyseur.utoulouse.fr).

BOM : AliExpress (ESP32/HX711/MPU6050) ; Amazon.fr (DIYmalls HX711+cellule 5 kg) ; PB-Modélisme, Guixmodel (carbone).

Entretiens stress : offres Airbus (flexa.careers) ; Glassdoor Airbus Toulouse ; GaugeHow ; stressebook.

_Éléments à reconfirmer par toi au moment de l'usage : (1) ACP est bien listé dans Ansys Student 2026 R1 : vérifie au J6 qu'il s'ouvre et comment un modèle multicouche est compté dans la limite de 128 000 ; (2) limite de nœuds MSC Nastran/Patran Student chez Cadence, seulement si tu fais le bonus Nastran ; (3) prix DO-160G (variable selon revendeur/adhésion RTCA) ; (4) coordonnées et Tg exacte de la résine que tu achètes._

0

Jour 0 · 2-3 h, la veille

## À faire avant de commencer

1

**Logiciels principaux (MAJ 15/09)** : terminer l'installation de **SOLIDWORKS 2026** et d'**Ansys Student 2026 R1** (PC physique, pas de VM). Ouvrir Workbench et vérifier que _ACP (Pre)_ , _Static Structural_ , _Modal_ , _Random Vibration_ , _Steady-State Thermal_ et _Fluid Flow (Fluent)_ apparaissent. CATIA, Onshape, FreeCAD et Altair ne sont plus nécessaires. _Facultatif_ : licence MSC Nastran Student (Cadence) avant le 30/09, seulement si tu vises le bonus Nastran. Le zip LS-DYNA Student peut être supprimé pour libérer ~700 Mo.

2

**Commandes matériel** : passer la commande **AliExpress (Variante A)** aujourd'hui (délai long) **et** préparer le panier **Amazon Prime (Variante B)** en secours ; repérer le rayon mousse/masses/époxy chez **Leroy Merlin**. Réserver un créneau/adhésion **fablab** (Artilect ou FabLab université).

3

**Installations complémentaires** : XFLR5 6.62, Python 3 (env dédié : numpy/scipy/matplotlib/pandas/ansys-mapdl-core), Capella 7.1.0, Arduino IDE 2 (+ cartes esp32 3.3.x, HX711_ADC, lib MPU6050/ADXL345), Git + VS Code. Gmsh/ParaView/SU2 seulement pour le bonus CFD open source ; OpenFOAM abandonné. Vérifier qu'Ansys Student se lance et affiche ses limites (128K / 1M).

4

**Dépôt GitHub** : créer `drone-wing-justification` avec l'arborescence §8.3 et un README squelette.

5

**Lecture ciblée 2 h** : FAA Pilot's Handbook (chapitres facteurs de charge & aérodynamique) + CS-23 Subpart C (23.303, 335, 337, 341) + survol AMC 20-29 (approche building-block).

6

**Préparer le journal de bord** (template §10.2) et **repasser l'auto-test §2.2** pour noter ton score de départ.

Dernier mot

Tu as déjà les vraies compétences dures (FEA, Python, optimisation). Ce projet ne t'apprend pas à calculer — il t'apprend à **penser aéro, à justifier, et à parler le langage des BE de Toulouse**. Tiens les plafonds d'heures, sors un livrable chaque soir, sois impitoyablement honnête sur tes écarts : à J14, tu auras un dossier que peu de candidats juniors peuvent montrer. Bon vol.
