$computers = Get-ADComputer -Filter {enabled -eq $true -and OperatingSystem -Like '*Windows Server*'} -Properties Name | select @{Name="ComputerName";Expression={$_.Name}}

foreach($computer in $computers){

  $connection = Test-Connection -ComputerName $computer.ComputerName -Quiet

  if($connection -eq $true){

   $service_running = Get-Service -ComputerName $computer -ServiceName "W3SVC" -ErrorAction SilentlyContinue

   if(![string]::IsNullOrEmpty($service_running))

   {

    Export-Csv -Path "./webservers.csv" -Delimiter ',' -InputObject $service_running -NoTypeInformation -Append

   }

   

  }

}