# Actualiza MiCoach: sube los cambios a GitHub → Vercel redeploya solo (~30 s).
# Uso:  .\update.ps1 "descripción del cambio"
param([string]$m = "actualización")

Set-Location $PSScriptRoot

# ¿Hay algo que subir?
$changes = git status --porcelain
if (-not $changes) {
  Write-Host "Nada que actualizar: el repositorio ya está al día." -ForegroundColor Yellow
  exit 0
}

# Sube APP_VERSION en index.html: la app en el teléfono la compara y muestra "Hay una versión nueva".
$f = Join-Path $PSScriptRoot "index.html"
$html = [IO.File]::ReadAllText($f, [Text.Encoding]::UTF8)
$ver = Get-Date -Format "yyyy-MM-dd.HHmm"
$html = [regex]::Replace($html, 'const APP_VERSION = "[^"]*"', "const APP_VERSION = `"$ver`"")
[IO.File]::WriteAllText($f, $html, (New-Object Text.UTF8Encoding($false)))

git add -A
# El mensaje va por archivo: PowerShell 5.1 rompe los argumentos con comillas dobles.
$msgFile = Join-Path $env:TEMP "micoach-commit-msg.txt"
[IO.File]::WriteAllText($msgFile, $m, (New-Object Text.UTF8Encoding($false)))
git commit -F $msgFile
Remove-Item $msgFile -ErrorAction SilentlyContinue
if ($?) {
  git push
  if ($?) {
    Write-Host "`n✅ Subido. Vercel redeploya solo en ~30 s → https://mi-coachpro.vercel.app" -ForegroundColor Green
  } else {
    Write-Host "`n⚠️ El commit se hizo pero el push falló (revisa tu conexión o login de GitHub)." -ForegroundColor Red
  }
}
