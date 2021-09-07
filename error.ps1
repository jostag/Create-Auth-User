 start-process -WindowStyle Hidden powershell.exe C:\error.ps1
    
 function error{   
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    sleep 30
    $button = [System.Windows.MessageBoxButton]::OK
    $icon = [System.Windows.MessageBoxImage]::Error
    $message = "PC Load Letter"
    $title = "Error"
    [System.Windows.MessageBox]::Show($message,$title,$button,$icon)
    }