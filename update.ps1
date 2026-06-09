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

git add -A
git commit -m $m
if ($?) {
  git push
  if ($?) {
    Write-Host "`n✅ Subido. Vercel redeploya solo en ~30 s → https://mi-coachpro.vercel.app" -ForegroundColor Green
  } else {
    Write-Host "`n⚠️ El commit se hizo pero el push falló (revisa tu conexión o login de GitHub)." -ForegroundColor Red
  }
}
