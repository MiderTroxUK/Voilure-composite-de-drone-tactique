# .claude/hooks/heure.ps1
# Hook UserPromptSubmit : ajoute au contexte l'heure locale, le jour du projet et le bloc en cours.
# Fichier volontairement en ASCII.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$racine = $env:CLAUDE_PROJECT_DIR
if (-not $racine) { $racine = (Get-Location).Path }
$now = Get-Date
$jour = '?'
try {
    $cfg   = Get-Content (Join-Path $racine '.tutor/config.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    $debut = [datetime]::ParseExact($cfg.j1, 'yyyy-MM-dd', $null)
    $n     = ($now.Date - $debut.Date).Days + 1
    if ($n -lt 1) { $jour = 'J0 (avant projet)' } elseif ($n -gt [int]$cfg.nb_jours) { $jour = 'apres J7' } else { $jour = 'J' + $n }
} catch { }
$h = $now.Hour + $now.Minute / 60.0
if     ($h -lt 9)  { $bloc = 'avant 09:00' }
elseif ($h -lt 13) { $bloc = 'bloc matin 09:00-13:00' }
elseif ($h -lt 14) { $bloc = 'pause' }
elseif ($h -lt 18) { $bloc = 'bloc apres-midi 14:00-18:00' }
else               { $bloc = 'apres 18:00 (hors plafond)' }
Write-Output ('[Heure locale] ' + $now.ToString('yyyy-MM-dd HH:mm') + ' | ' + $jour + ' | ' + $bloc)
exit 0
