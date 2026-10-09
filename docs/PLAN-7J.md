# Plan 7 jours — voilure composite de drone tactique

## Cadre
- 7 jours × 8 h (56 h), 09:00-13:00 et 14:00-18:00, plus un J0 la veille (3 h au plus).
- Périmètre = exactement la ligne « Projet » du CV, plus le cœur du métier de stress engineer (caisson à la main, RF limite/extrême, allowables). Coupé par rapport au plan 14 jours : CFD 2D (déjà maîtrisée, CFX/Fluent sur le CV), thermique du pod, Nastran, optimisation de drapage.
- Niveaux (voir CLAUDE.md §4) : ACQUIS = aller vite, être rigoureux ; DÉCLARÉ = compétence affichée au CV, à blinder ; NOUVEAU = le vrai apprentissage de la semaine.
- Chaque jour : prédiction scellée avant tout calcul FEM ou essai, livrable commité le soir, une question d'examinateur ajoutée à la banque.
- Lectures de référence (ciblées, 30 min au plus par jour) : Megson, *Aircraft Structures for Engineering Students* (flexion, cisaillement et torsion des sections fermées) ; Bruhn ou Niu (méthodes de bureau d'études) ; Kassapoglou, *Design and Analysis of Composite Structures* (knock-downs, flambement de panneaux) ; Hodges & Pierce, *Introduction to Structural Dynamics and Aeroelasticity* (divergence, flottement de la section typique) ; CS-23 (charges) ; MIL-STD-810H méthode 514.8 ; MIL-HDBK-17-1F (A/B-basis) ; AMC 20-29.

## J0 — La veille (3 h au plus)
Focus : conditions de réussite. Sans matériel commandé aujourd'hui, pas d'essai au J6.
- Commander (variante rapide uniquement, livraison sous 48 h : Amazon Prime, magasin de modélisme, Leroy Merlin) : ESP32 DevKit ; HX711 + cellule de charge 5 kg ; ADXL345 (préféré au MPU6050 pour la cadence d'échantillonnage) ; tube carbone Ø 10-12 mm × 1 m ; tissu ou plaque carbone fine ; résine époxy de stratification + époxy rapide ; mousse XPS ; comparateur à cadran et base (ou réglet et mesure photo) ; câbles Dupont, breadboard ; serre-joints. Masses : bouteilles d'eau. Budget ≤ 100 €.
- Vérifier que tout se lance : Ansys Student (ACP Pre/Post, Static Structural, Eigenvalue Buckling, Modal, Random Vibration visibles), XFLR5, Python (numpy, scipy, matplotlib, pandas), Capella, Arduino IDE 2 + cartes ESP32.
- Dépôt `drone-wing-justification` + kit tuteur installé + tests des garde-fous (README-INSTALL.md).
- Auto-test de 10 questions du polycopié : ligne de base, notée dans TUTOR_NOTES.
- Lecture 45 min : les paragraphes charges de la CS-23 (vérifier la version citée) et le principe d'un diagramme V-n avec rafales.
Critère : commande passée, tous les logiciels lancés une fois, garde-fous testés, score de base noté.

## J1 — Exigences et enveloppe de vol
Niveau : spécification ACQUIS (culture note de calcul Eurocodes) ; V-n et rafales NOUVEAU.
Ligne CV couverte : « V-n CS-23 (+3,8 / −1,52, extrême ×1,5) », début de la matrice.
- 09:00-10:30 Spécification v1 : hypothèses chiffrées et sourcées, système d'unités, hors-périmètre écrit noir sur blanc.
- 10:30-12:00 Matrice d'exigences (15 lignes STR/DYN/ENV/TST) : ID, énoncé, source, moyen de conformité, chapitre, résultat, statut.
- 12:00-13:00 puis 14:00-17:00 Diagramme V-n en Python, écrit par John : vitesse de décrochage, V_A, V_C, V_D, enveloppe de manœuvre, droites de rafale avec facteur d'atténuation, points de calcul.
- 17:00-18:00 /fin-de-jour.
Livrables : `00_specification/spec_v1.md`, `00_specification/matrice.csv`, `01_loads_vn/vn.py`, `vn.png`, `points_calcul.csv`.
Critère : chaque valeur sourcée ou marquée hypothèse ; V-n avec manœuvre ET rafales ; cas dimensionnant identifié et justifié.
Prédiction à sceller : le facteur de charge de rafale à V_C, avant de le calculer.
Pièges : EAS/TAS ; unités impériales dans les formules de rafale (ft/s, psf) ; oublier le facteur d'atténuation.
Si retard, on coupe : variation avec l'altitude.
Question d'examinateur : « Pour un drone léger à faible charge alaire, qui dimensionne : la manœuvre ou la rafale ? Pourquoi ? »

## J2 — Charges sur l'aile et caisson à la main
Niveau : XFLR5 ACQUIS (XFOIL) ; Schrenk, efforts de section, caisson NOUVEAU — cœur du métier de stress engineer.
Ligne CV couverte : « charges XFLR5 ».
- 09:00-10:30 XFLR5 : profil (30 min au plus), aile en LLT ou VLM au cas dimensionnant, distribution de portance exportée.
- 10:30-13:00 Schrenk à la main, puis intégration en Python de l'effort tranchant, du moment fléchissant et du moment de torsion le long de l'envergure ; comparaison avec XFLR5.
- 14:00-17:00 Caisson à la main : section idéalisée, inertie, contraintes dans les semelles, flux de cisaillement dans l'âme, torsion par Bredt ; pré-dimensionnement des semelles UD à charge extrême ; premier RF.
- 17:00-18:00 /fin-de-jour.
Livrables : `01_loads_vn/loads.csv` (unités en en-tête), `note_charges.md`, `02_composites_clt/caisson_main.md` (ou photo du calcul manuscrit + tableur).
Critère : |∫L − n·W| / n·W < 5 % ; moment d'emplanture Schrenk vs XFLR5 < 10 % ou écart expliqué ; RF semelle ≥ 1 à charge extrême.
Prédiction à sceller : le moment d'emplanture à n_max, en ordre de grandeur, avant l'intégration.
Pièges : oublier le relief inertiel (poids de l'aile) ; demi-envergure ; mélanger limite et extrême.
Si retard, on coupe : torsion détaillée (hypothèse de centre de poussée écrite).
Question d'examinateur : « Décris le chemin d'effort de la portance jusqu'à l'emplanture. »

## J3 — Stratifié en CLT, allowables et fabrication
Niveau : CLT, Tsai-Wu, Hashin DÉCLARÉ — à blinder (aucun exemple analogue sur ABD) ; allowables et knock-downs NOUVEAU.
Ligne CV couverte : « stratifié dimensionné en CLT (ABD, Tsai-Wu, Python) ».
- 09:00-12:00 `ABD.py` écrit de zéro : Q, Q̄, A/B/D, résolution ε⁰/κ, contraintes et déformations par pli ; validé sur un cas calculé à la main (2 plis) puis sur un cas publié.
- 12:00-13:00 Critères Tsai-Wu et Hashin : rupture du premier pli, mode de rupture, RF par pli.
- 14:00-16:00 Drapage des semelles et de la peau (symétrie, équilibre, règle des 10 %) ; allowables de calcul sourcés avec knock-downs (chaud-humide, impact) ; RF à charge extrême.
- 16:00-17:30 Fabrication du spécimen (tube carbone + peau carbone/mousse collée), après l'avoir mesuré et pesé ; cure pendant la nuit.
- 17:30-18:00 /fin-de-jour.
Livrables : `02_composites_clt/ABD.py` + tests, `drapage_v1.md`, photos et masse du spécimen.
Critère : ABD validé à < 1 % sur le cas manuel ; premier pli et mode identifiés ; RF ≥ 1 avec knock-downs explicites.
Prédiction à sceller : quel pli casse en premier et dans quel mode.
Pièges : γ12 vs ε12 (facteur 2) ; degrés/radians ; stratifié non symétrique (B ≠ 0) ; choix du terme d'interaction de Tsai-Wu.
Si retard, on coupe : Puck ; si le matériel n'est pas arrivé, fabrication décalée au J4 soir (l'essai du J6 tient).
Question d'examinateur : « Tsai-Wu ou Hashin : lequel te dit quel mode casse, et pourquoi ça compte pour dimensionner ? »

## J4 — FEM coques stratifiées : statique et flambement
Niveau : FEM coques et convergence ACQUIS (aller vite) ; ACP structurel PARTIEL ; flambement de panneau composite NOUVEAU.
Ligne CV couverte : « coques ANSYS (flambement) ».
- 09:00-10:30 Surfaces SolidWorks (ou CATIA) → Ansys ; maillage ; bilan de masse.
- 10:30-13:00 ACP Pre (matériaux, rosettes, OSS, plis) ; statique à n_max (et n_min si le temps le permet), charges issues de `loads.csv`.
- 14:00-15:30 ACP Post : critères par pli, RF ; comparaison au calcul du caisson et à la CLT au même point.
- 15:30-17:00 Flambement linéaire de la peau comprimée ; convergence sur 3 maillages (GCI) ; comparaison avec une formule de plaque orthotrope à la main.
- 17:00-17:30 /fin-de-jour ; 17:30-18:00 `/entretien cv` sur les compétences affichées déjà traitées.
Livrables : `03_fem_ansys/` (projet archivé, exports CSV, captures), `note_ecart_main_fem.md`.
Critère : masse du modèle ± 5 % ; somme des réactions = efforts appliqués ; écart main/FEM < 15 % ou expliqué ; facteur de flambement justifié au bon niveau de charge ; < 128 000 nœuds.
Prédiction à sceller : flèche en bout et RF minimal, avant de lancer le calcul.
Pièges : orientation des rosettes ; offset des coques ; charge ponctuelle au lieu de répartie ; flambement linéaire non conservatif (imperfections).
Si retard, on coupe : n_min.
Question d'examinateur : « Ton flambement est-il vérifié à charge limite ou extrême, et pourquoi ? »

## J5 — Dynamique : modale, random, flottement, prédiction du spécimen
Niveau : modale ACQUIS ; random et MIL-STD-810H DÉCLARÉ — à blinder ; flottement et divergence NOUVEAU.
Ligne CV couverte : « modale, random MIL-STD-810H ».
- 09:00-10:30 Modale de l'aile (masses du pod et des servos incluses) ; séparation flexion/torsion ; f1 vérifiée à la main (poutre encastrée-libre).
- 10:30-13:00 Random : catégorie et PSD de la méthode 514.8 choisies et justifiées ; réponse 1σ puis 3σ ; Miles à la main sur le mode dominant ; RF à 3σ.
- 14:00-16:00 Section typique à 2 degrés de liberté (Python) alimentée par les modes : vitesse de divergence, vitesse de flottement, marge par rapport à V_D, hypothèses du modèle écrites.
- 16:00-17:30 Prédiction du SPÉCIMEN : raideur k et f1 (masse du capteur incluse), par calcul à la main et par FEM ; John la commite dans `05_test/prediction.md`.
- 17:30-18:00 /fin-de-jour.
Livrables : `04_dynamics/` (modes, random, `flutter.py`, note), `05_test/prediction.md` commité.
Critère : f1 main vs FEM < 10 % ; RF_3σ ≥ 1 ; marge de flottement chiffrée avec ses hypothèses et leur sens d'erreur ; prédiction du spécimen commitée avant l'essai.
Prédiction à sceller : f1 de l'aile et la fréquence de torsion, avant la modale.
Pièges : confondre 1σ et 3σ ; PSD mal unitée (g²/Hz) ; masses ponctuelles oubliées ; amortissement choisi arbitrairement (donner une fourchette).
Si retard, on coupe : random dans le FEM (Miles à la main seul).
Question d'examinateur : « Qu'est-ce que ton modèle de flottement néglige, et dans quel sens ça va ? »

## J6 — Essais et corrélation
Niveau : instrumentation et corrélation NOUVEAU (base : procédure de test Python d'un robot autonome).
Ligne CV couverte : « Tronçon fabriqué, testé en raideur et en modal (ESP32, FFT), corrélé au calcul ».
- 09:00-11:00 Firmware ESP32 (HX711 + ADXL345) écrit par John ; calibration avec une masse étalon ; fréquence d'échantillonnage mesurée (Nyquist, viser ≥ 10 × f attendue).
- 11:00-13:00 Essai de raideur : 5 paliers en montée et en descente, 3 répétitions ; k avec incertitude.
- 14:00-15:30 Essai modal par impact : 5 à 10 impacts, FFT, f1 avec sa résolution fréquentielle.
- 15:30-17:00 Corrélation avec la prédiction scellée ; analyse des écarts (encastrement, fraction de fibres, masse du capteur) ; recalage d'UN seul paramètre, justifié.
- 17:00-18:00 /fin-de-jour.
Livrables : `05_test/firmware/`, `05_test/data/*.csv`, `fft.py`, `correlation.md`, photos du banc.
Critère : 2 essais faits ; incertitudes chiffrées ; écart k ± 20 % et f1 ± 15 % = très bon pour une première corrélation ; au-delà, cause identifiée.
Prédiction : déjà scellée au J5, on ne la modifie pas.
Pièges : encastrement souple ; repliement spectral ; recaler plusieurs paramètres pour « coller ».
Si retard, on coupe : un seul essai si panne, l'autre passe en perspective.
Question d'examinateur : « Tu as recalé ton modèle : comment sais-tu que tu n'as pas compensé une erreur par une autre ? »

## J7 — Système, justification, valorisation
Niveau : Capella DÉCLARÉ — à blinder ; matrice et dossier ACQUIS (culture note de calcul) ; pitch et entretien.
Ligne CV couverte : « exigences sous Capella », « Dossier et matrice de conformité ».
- 09:00-10:30 Capella léger : analyse opérationnelle (mission ISR), besoin système (fonction « reprendre les charges de vol »), exigence STR-01 allouée à la voilure, lien vers sa vérification.
- 10:30-13:00 Dossier de justification compact (12-15 p.) : hypothèses, charges, tableau des RF, dynamique, essai et corrélation, limites. Matrice de conformité complétée avec preuves.
- 14:00-15:00 README GitHub avec 3 figures clés et résultats chiffrés.
- 15:00-16:00 Auto-test final (comparé au J0) puis `/entretien 30min`.
- 16:00-17:00 Pitch 3 min (deux passages) ; mise à jour de la ligne CV pour qu'elle corresponde exactement au réalisé, durée comprise.
- 17:00-18:00 Bilan final, limites et perspectives, derniers commits.
Livrables : `06_mbse_capella/`, `07_report/dossier.pdf`, matrice finale, README, CV mis à jour.
Critère : chaque ligne de la matrice a un statut et une preuve ; aucune affirmation du CV sans fichier qui la prouve.
Question d'examinateur : « Qu'est-ce qui n'est PAS démontré dans ton dossier ? »

## Réserve (seulement si un jour se termine en avance)
Dans cet ordre : n_min ; Puck ; random dans le FEM ; thermique du pod en réseau 1D ; optimisation du drapage (PSO) après dimensionnement manuel.
