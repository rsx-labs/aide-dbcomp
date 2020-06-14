##########################################################
# this is the script to install/update the aide db
##########################################################

# accepts either full/delta sa parameter
param(
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$type
)

Function Show-Welcome {
    Param($ver)
    Log("*************** install start ***************")
    Clear-Host
    Write-Host "---------------------------------------------------------------"
    Write-Host "aide dbcomp installer " $ver -ForegroundColor Green;
    Write-Host "---------------------------------------------------------------"
    Write-Host ""
    Log("starting installer ...")
}

Function Exit-Install {
    Write-Host "---------------------------------------------------------------"
    Write-Host "summary:" -ForegroundColor Yellow;
    Write-Host "executed : $($script:executed)  ;  success : $($script:success)  ;" `
                "  warning : $($script:warning)"
    Write-Host "---------------------------------------------------------------"
    Write-Host "end aide dbcomp installer " -ForegroundColor Green;
    Write-Host "---------------------------------------------------------------"
    Log("*************** install end ***************")
}

Function  Install-DBFull {
    Log("starting full install ...")
    Write-Host "***** starting F U L L install *****" -BackgroundColor DarkYellow;
    Write-Host ""
    Write-Host "W A R N I N G : Full install not yet supported."
    Log("WARNING : full install not yet supported!")
    Write-Host ""
    Write-Host "***** ending F U L L install *****" -BackgroundColor DarkYellow;
    # Write-Host ""
    # Log("performing full install ...")
    # Write-Host "fresh install starting ..."

    # # create the array of dir
    # $dirArray = "database", "users", "tables", "views", "stored_procedures", "functions" , "data"
    
    # Set-Location "..\src\full"

    # foreach ($dir in $dirArray) {
    #     Write-Host "processing " $dir
    #     Set-Location $dir
    #     $cd = Get-Location
    #     Write-Host "----" $cd
        
    #     Get-ChildItem $cd -Filter *.sql | Foreach-Object {
    #         Log("installing $($_.Name)")

    #         Invoke-Sqlcmd -InputFile $_.Name `
    #                 -ServerInstance $server  `
    #                 -Database $dbase | `
           
    #                 Out-File -FilePath "c:\Temp\log_$($_.Name).log" 
             
    #     }

    #     Set-Location ".."
    # }
} 

function Install-DBDelta {
    Write-Host "***** starting D E L T A install *****" -BackgroundColor Red;
    Write-Host ""
    Log("starting delta install ...")
    $current_loc = Get-Location
    Log("starting delta/all install ...")
    # install the delta for all
    Install-AllDelta
    
    Set-Location $current_loc

    Log("starting delta/account install ...")
    Install-AllAccounts
    Write-Host ""
    Write-Host "***** ending D E L T A install *****" -BackgroundColor Red;
} 

function Install-AllDelta {
    Write-Host "running delta scripts for all accounts" -ForegroundColor Magenta;
    Write-Host ""
    $dirArray = $settings.setting.installs.delta.all.folders
    
    Set-Location "..\src\delta\all"
    
    foreach ($dir in $dirArray) {
        Write-Host "> processing [" $dir "]" -ForegroundColor Blue;
        Log("> processing [$($dir)]")
        Set-Location $dir
        
        Get-ChildItem $cd -Filter *.sql | Foreach-Object {
            Log("- installing $($_.Name)")
            $script:executed ++
            Write-Host "- executing $($_.Name)" -NoNewline
            Invoke-Sqlcmd -InputFile $_.Name `
                    -ServerInstance $server  `
                    -Database $dbase | `
                    Out-File -FilePath "c:\Temp\log_$($_.Name).log" 
            
            If ((Get-Item "c:\Temp\log_$($_.Name).log").length -gt 0 ){
                Write-Host " WARNING" -ForegroundColor Red
                Write-Warning("possible error. review : ""c:\Temp\log_$($_.Name).log")
                Log("possible error. review : ""c:\Temp\log_$($_.Name).log")
                $script:warning ++
            } else {
                Write-Host " OK " -ForegroundColor DarkGreen;
                $script:success ++
            }
            
        }

        Set-Location ".."
    }
}

function Install-AllAccounts {
    $dirArray = $settings.setting.installs.delta.account.names

    Set-Location "..\src\delta\account"
    Write-Host ""
    foreach ($dept in $dirArray) {
        Write-Host "installing specific deltas for $($dept)" -ForegroundColor Magenta;
        Write-Host ""
        Install-Account($dept)
    }
}

function Install-Account {
    Param($acct)

    Set-Location $acct
    $dirArray = $settings.setting.installs.delta.account.folders

    foreach ($dir in $dirArray) {
        Write-Host "> processing  [" $dir "]" -ForegroundColor Blue;
        Log("> processing [$($dir)]")
        Set-Location $dir
        
        Get-ChildItem $cd -Filter *.sql | Foreach-Object {
            Log("- installing $($_.Name)")
            $script:executed ++
            Invoke-Sqlcmd -InputFile $_.Name `
                    -ServerInstance $server  `
                    -Database $dbase | `
           
                    Out-File -FilePath "c:\Temp\log_$($_.Name).log" 

            If ((Get-Item "c:\Temp\log_$($_.Name).log").length -gt 0 ){
                Write-Host " WARNING" -ForegroundColor Red
                Write-Warning("possible error. review : ""c:\Temp\log_$($_.Name).log")
                Log("possible error. review : ""c:\Temp\log_$($_.Name).log")
                $script:warning ++
            } else {
                Write-Host " OK " -ForegroundColor DarkGreen;
                $script:success ++
            }
             
        }

        Set-Location ".."
    }
}

Function Log {
    param(
        [Parameter(Mandatory=$true)][String]$msg
    )
    
    Add-Content $log_loc $msg
}


# ****************** start of main **************************

# load settings
$settings = Get-Content -Raw -Path ".\install.setting.json" | ConvertFrom-Json
$inst_version = $settings.setting.version
$log_loc = $settings.setting.log_loc
$server = $settings.setting.database.server
$dbase = $settings.setting.database.dbase
$executed =0 
$success = 0
$warning = 0

Show-Welcome($inst_version)
Write-Host "install type : " -NoNewline
Write-Host " " $type " " -ForegroundColor White -BackgroundColor DarkMagenta;
Write-Host 

Write-Host "Install Settings" -ForegroundColor Yellow;
Write-Host "installer version  : $($inst_version)"
Write-Host "log location  : $($log_loc)"
Write-Host "database server  : $($server)"
Write-Host "database  : $($dbase)"

Write-Host ""

$confirmation = Read-Host "Are you Sure You Want To Proceed (y/n)"
if ($confirmation -eq 'y') {
    $current_loc = Get-Location
    if ($type.ToLower() -eq 'full'){   
        Write-Host ""
        Install-DBFull
    }
    else {
        Write-Host ""
        Install-DBDelta
    }
    Set-Location $current_loc
    Exit-Install
}
else {
    Write-Host "Aborting ..."
    Log("installer aborted ...")
    Exit-Install
}
