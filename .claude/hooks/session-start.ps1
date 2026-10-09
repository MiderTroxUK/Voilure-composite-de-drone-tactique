# .claude/hooks/session-start.ps1
# Le texte ecrit sur stdout par un hook SessionStart est ajoute au contexte de Claude.
# Se declenche au demarrage, a la reprise, apres /clear et apres compaction.
# Fichier volontairement en ASCII.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$racine  = $env:CLAUDE_PROJECT_DIR
if (-not $racine) { $racine = (Get-Location).Path }
$config  = Join-Path $racine '.tutor/config.json'
$plan    = Join-Path $racine 'docs/PLAN-7J.md'
$notes   = Join-Path $racine '.tutor/TUTOR_NOTES.md'
$journal = Join-Path $racine 'JOURNAL.md'

$jour = $null
try {
    $cfg   = Get-Content $config -Raw -Encoding UTF8 | ConvertFrom-Json
    $debut = [datetime]::ParseExact($cfg.j1, 'yyyy-MM-dd', $null)
    $n     = ((Get-Date).Date - $debut.Date).Days + 1
    if ($n -lt 1) { $jour = 0 } elseif ($n -gt [int]$cfg.nb_jours) { $jour = -1 } else { $jour = $n }
} catch { $jour = $null }

Write-Output "=== CONTEXTE TUTEUR (hook SessionStart) ==="
Write-Output ("Maintenant : " + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
if ($jour -eq $null)  { Write-Output "Jour projet : inconnu (.tutor/config.json absent ou invalide). Demande a John de le corriger." }
elseif ($jour -eq -1) { Write-Output "Jour projet : apres J7 (projet termine ou decale). Demande a John ou il en est." }
else                  { Write-Output ("Jour projet calcule : J" + $jour) }
Write-Output "Rappel : CLAUDE.md sections 1 a 5 (contrat, regles d'or, fais/ne fais jamais, calibrage, echelle d'indices) en vigueur."

if (($jour -ne $null) -and ($jour -ge 0) -and (Test-Path $plan)) {
    Write-Output ("--- docs/PLAN-7J.md : section J" + $jour + " ---")
    $dedans = $false
    foreach ($l in (Get-Content $plan -Encoding UTF8)) {
        if ($l -match '^## ') { $dedans = ($l -match ('^## J' + $jour + '(\D|$)')) }
        if ($dedans) { Write-Output $l }
    }
}
if (Test-Path $notes)   { Write-Output "--- .tutor/TUTOR_NOTES.md (80 dernieres lignes) ---"; Get-Content $notes -Tail 80 -Encoding UTF8 }
if (Test-Path $journal) { Write-Output "--- JOURNAL.md (30 dernieres lignes) ---"; Get-Content $journal -Tail 30 -Encoding UTF8 }
exit 0
