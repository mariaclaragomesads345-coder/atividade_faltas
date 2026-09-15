<#
Configura o Git deste projeto para uso pelo VS Code e pelo GitHub.

Uso (no terminal PowerShell, dentro desta pasta):
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  .\configurar-git-vscode.ps1 -OpenVSCode
#>

[CmdletBinding()]
param(
    [switch]$OpenVSCode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$GitUserName = 'Maria Clara Gomes'
$GitUserEmail = 'mariaclaragomesads345@gmail.com'
$RepositoryUrl = 'https://github.com/mariaclaragomesads345-coder/conversor-python.git'
$ProjectPath = Split-Path -Parent $PSCommandPath

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git não foi encontrado. Instale-o em https://git-scm.com/download/win e execute este script novamente.'
}

Write-Host 'Configurando sua identidade global do Git...'
git config --global user.name $GitUserName
git config --global user.email $GitUserEmail
git config --global init.defaultBranch main
git config --global credential.helper manager

Set-Location -LiteralPath $ProjectPath

if (-not (Test-Path -LiteralPath (Join-Path $ProjectPath '.git'))) {
    Write-Host 'Inicializando o repositório local...'
    git init
}

$CurrentOrigin = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host 'Atualizando o remoto origin...'
    git remote set-url origin $RepositoryUrl
}
else {
    Write-Host 'Adicionando o remoto origin...'
    git remote add origin $RepositoryUrl
}

git branch -M main

Write-Host ''
Write-Host 'Configuração concluída.' -ForegroundColor Green
Write-Host "Projeto: $ProjectPath"
Write-Host "Remoto:  $RepositoryUrl"
Write-Host ''
Write-Host 'No VS Code, entre na sua conta GitHub pelo ícone Accounts antes de executar o primeiro git push.'
Write-Host 'Depois, use: git add . ; git commit -m "Primeiro commit" ; git push -u origin main'

if ($OpenVSCode) {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        code $ProjectPath
    }
    else {
        Write-Warning 'O comando "code" não está disponível. Abra esta pasta manualmente no VS Code.'
    }
}
