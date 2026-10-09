# .claude/hooks/garde-ecriture.ps1
# Garde-fou PreToolUse (Edit|Write|NotebookEdit) : liste blanche stricte.
# Seul fichier modifiable par Claude : .tutor/TUTOR_NOTES.md
# Toute erreur = refus (fail-closed). Sortie JSON + exit 0.
# Fichier volontairement en ASCII (PowerShell 5.1 lit les .ps1 sans BOM en ANSI).
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$autorises = @('.tutor/TUTOR_NOTES.md')   # chemins relatifs a la racine du depot
$raison = $null
try {
    $entree = [Console]::In.ReadToEnd() | ConvertFrom-Json
    $chemin = $entree.tool_input.file_path
    if (-not $chemin) { $chemin = $entree.tool_input.notebook_path }
    if (-not $chemin) { throw "chemin cible introuvable dans tool_input" }
    $racine = $env:CLAUDE_PROJECT_DIR
    if (-not $racine) { $racine = $entree.cwd }
    if (-not $racine) { throw "racine du projet inconnue" }
    if (-not [System.IO.Path]::IsPathRooted($chemin)) { $chemin = Join-Path $racine $chemin }
    $norm = { param($p) ([System.IO.Path]::GetFullPath($p) -replace '\\','/').ToLowerInvariant() }
    $cible = & $norm $chemin
    foreach ($a in $autorises) {
        if ($cible -eq (& $norm (Join-Path $racine $a))) { exit 0 }
    }
    $raison = "GARDE-FOU TUTEUR : ecriture refusee sur '$chemin'. Seul .tutor/TUTOR_NOTES.md est modifiable par Claude. John ecrit lui-meme code, scripts, rapports et journal. Ne cherche aucun contournement : propose une question, un indice ou une relecture."
} catch {
    $raison = "GARDE-FOU TUTEUR : verification impossible ($($_.Exception.Message)). Ecriture refusee par defaut."
}
@{ hookSpecificOutput = @{ hookEventName = 'PreToolUse'; permissionDecision = 'deny'; permissionDecisionReason = $raison } } | ConvertTo-Json -Depth 4 -Compress
exit 0
