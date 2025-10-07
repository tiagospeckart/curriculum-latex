# Build-CV.ps1

param(
    [Parameter()]
    [ValidateSet('en', 'pt', 'all')]
    [string]$Language = 'all'
)

function Get-EnvVariables {
    $envVars = @{}
    if (Test-Path .env) {
        Get-Content .env | ForEach-Object {
            if ($_ -match '^([^=]+)=(.+)$') {
                $envVars[$matches[1]] = $matches[2].Trim('"')
            }
        }
    }
    return $envVars
}

function Process-LaTeXFile {
    param(
        [string]$InputFile,
        [string]$OutputFile,
        [hashtable]$Variables
    )
    
    $content = Get-Content $InputFile -Raw -Encoding UTF8
    
    # CORREÇÃO: Remover as aspas duplas ao redor dos valores
    $content = $content.Replace('\newcommand{\fullname}{}', "\newcommand{\fullname}{$($Variables.FULLNAME)}")
    $content = $content.Replace('\newcommand{\email}{}', "\newcommand{\email}{$($Variables.EMAIL)}")
    $content = $content.Replace('\newcommand{\phone}{}', "\newcommand{\phone}{$($Variables.PHONE)}")
    $content = $content.Replace('\newcommand{\location}{}', "\newcommand{\location}{$($Variables.LOCATION)}")
    $content = $content.Replace('\newcommand{\linkedinurl}{}', "\newcommand{\linkedinurl}{$($Variables.LINKEDINURL)}")
    
    # Salvar arquivo
    $content | Out-File -FilePath $OutputFile -Encoding UTF8 -NoNewline
    
    return (Test-Path $OutputFile)
}

function Build-CV {
    param(
        [string]$Lang,
        [hashtable]$EnvVars
    )
    
    $mainFile = "main_$Lang.tex"
    $tempFile = "main_${Lang}_temp.tex"
    $outputPdf = "cv_$Lang.pdf"
    
    Write-Host "`n=== Compilando CV em $($Lang.ToUpper()) ===" -ForegroundColor Cyan
    
    if (-not (Test-Path $mainFile)) {
        Write-Host "❌ Arquivo $mainFile não encontrado!" -ForegroundColor Red
        return
    }
    
    $vars = @{
        FULLNAME = if ($Lang -eq 'pt') { $EnvVars.FULLNAME_PT } else { $EnvVars.FULLNAME }
        EMAIL = if ($Lang -eq 'pt') { $EnvVars.EMAIL_PT } else { $EnvVars.EMAIL }
        PHONE = if ($Lang -eq 'pt') { $EnvVars.PHONE_PT } else { $EnvVars.PHONE }
        LOCATION = if ($Lang -eq 'pt') { $EnvVars.LOCATION_PT } else { $EnvVars.LOCATION }
        LINKEDINURL = if ($Lang -eq 'pt') { $EnvVars.LINKEDINURL_PT } else { $EnvVars.LINKEDINURL }
    }
    
    # Processar arquivo
    Write-Host "Processando arquivo..." -ForegroundColor Gray
    $success = Process-LaTeXFile -InputFile $mainFile -OutputFile $tempFile -Variables $vars
    
    if (-not $success) {
        Write-Host "❌ Falha ao criar arquivo temporário" -ForegroundColor Red
        return
    }
    
    # Primeira compilação (silenciosa)
    Write-Host "Compilando (1/2)..." -ForegroundColor Gray
    pdflatex -interaction=nonstopmode -file-line-error $tempFile | Out-Null
    
    # Segunda compilação (para resolver referências)
    Write-Host "Compilando (2/2)..." -ForegroundColor Gray
    pdflatex -interaction=nonstopmode -file-line-error $tempFile | Out-Null
    
    # Verificar se PDF foi criado (INDEPENDENTE do exit code)
    $pdfTemp = $tempFile -replace '\.tex$', '.pdf'
    if (Test-Path $pdfTemp) {
        Move-Item -Force $pdfTemp $outputPdf
        $sizeKB = [math]::Round((Get-Item $outputPdf).Length / 1KB, 2)
        Write-Host "✅ $outputPdf criado com sucesso! ($sizeKB KB)" -ForegroundColor Green
    } else {
        Write-Host "❌ PDF não foi gerado" -ForegroundColor Red
        
        # Mostrar últimas linhas do log para debug
        $logFile = $tempFile -replace '\.tex$', '.log'
        if (Test-Path $logFile) {
            Write-Host "`nÚltimas linhas do log:" -ForegroundColor Yellow
            Get-Content $logFile -Tail 10 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
        }
    }
    
    # Limpar arquivos temporários
    Remove-Item -ErrorAction SilentlyContinue "$tempFile*"
}

# MAIN
Write-Host "╔════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║      CV Compiler - v1.0            ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════╝" -ForegroundColor Yellow

$envVars = Get-EnvVariables

if ($Language -eq 'all' -or $Language -eq 'en') { 
    Build-CV -Lang 'en' -EnvVars $envVars 
}

if ($Language -eq 'all' -or $Language -eq 'pt') { 
    Build-CV -Lang 'pt' -EnvVars $envVars 
}

# Limpar arquivos auxiliares
Write-Host "`nLimpando arquivos auxiliares..." -ForegroundColor Cyan
Remove-Item -ErrorAction SilentlyContinue *.aux, *.log, *.out

Write-Host "`n🎉 Compilação concluída!" -ForegroundColor Green
Write-Host "Para visualizar: " -NoNewline
Write-Host "Invoke-Item cv_$Language.pdf" -ForegroundColor Yellow