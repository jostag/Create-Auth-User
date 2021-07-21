function Continue-running{
    $ui2 = Read-Host "Would you like to do anything else? (y) Yes (n) no"
    if ($ui2 -eq 'y'){
        Remove-MetroApp
        }elseif($ui2 -eq 'n')
        {
            return
    }
}

function filePermAuth{

    $NewAcl = New-Object -TypeName System.Security.AccessControl.DirectorySecurity

    # Set properties
    $identity = "Authenticated Users"
    $fileSystemRights = "FullControl"
    $type = "Allow"
    $inheritance = "ContainerInherit,ObjectInherit"
    $inheritaceFlag = "None"

    # Create new rule
    $fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $inheritance, $inheritaceFlag, $type 
    $fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
    
    # Apply new rule
    $NewAcl.SetAccessRule($fileSystemAccessRule)
    Set-Acl -Path @('C:\JHA', 'C:\Program Files\JHA', 'C:\ProgramData\JHA', 'C:\Program Files (x86)\JHA', 'C:\Windows\Temp') -AclObject $NewAcl
    
}

function filePermUser{

    $NewAcl2 = New-Object -TypeName System.Security.AccessControl.DirectorySecurity

    # Set properties
    $identity2 = "Users"
    $fileSystemRights2 = "FullControl"
    $type2 = "Allow"
    $inheritance2 = "ContainerInherit,ObjectInherit"
    $inheritaceFlag2 = "None"

    # Create new rule
    $fileSystemAccessRuleArgumentList2 = $identity2, $fileSystemRights2, $inheritance2, $inheritaceFlag2, $type2 
    $fileSystemAccessRule2 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList2
    
    # Apply new rule
    $NewAcl2.SetAccessRule($fileSystemAccessRule2)
    Set-Acl -Path @('C:\JHA', 'C:\Program Files\JHA', 'C:\ProgramData\JHA', 'C:\Program Files (x86)\JHA', 'C:\Windows\Temp') -AclObject $NewAcl2
    
}

function createAuthUser{
    
    $acl = Get-Acl 'C:\Program Files (x86)\'
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated Users", "FullControl",  "Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl ('C:\Program Files\JHA', 'C:\ProgramData\JHA', 'C:\Program Files (x86)\JHA', 'C:\Windows\Temp')
    }

function createUser{
    
    $acl = Get-Acl 'C:\Program Files (x86)\JHA'
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl ('C:\Program Files\JHA', 'C:\ProgramData\JHA', 'C:\Program Files (x86)\JHA', 'C:\Windows\Temp')
    }


function fileChanger{
    Write-Host "
    ========================Metro App Remover===========================
    (a) All
    (q) Quit
    "
    Write-Host($appOptions)
    $ui = Read-Host "Which app(s) would you like to remove?"
    if ($ui -eq 'a'){
        
        createAuthUser
        filePermAuth
        filePermUser
        }
    elseif($ui -eq 'q'){
        return
    }else{
        Write-Host "
        *********** Invalid input. Choose from the list. ***********" -foregroundcolor red
        fileChanger
    }

}

fileChanger