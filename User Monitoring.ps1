$sql = "select PROFNAME,ADRNAME,PROFSTATUS,ADRMOBILE,ADRPHONE from MMPROFILES where PROFSTATUS=2";
$sqlConnection = new-object System.Data.SqlClient.SqlConnection("Server=<SQL_Server>;User ID=<SQL_User>;Password=<SQL_User_PW>;Database=EnterpriseAlert;Integrated Security=true")
$sqlConnection.open()
$sqlCommand = $sqlConnection.CreateCommand()
$sqlCommand.CommandText = $sql
$DataSet = new-object System.Data.DataTable
$Adapter = new-object System.Data.SqlClient.SqlDataAdapter($sqlCommand)
$DataSet = New-Object System.Data.DataSet;
$Adapter.Fill($DataSet)
$sqlConnection.Close();
$sqlConnection.Dispose();

$MyResults = $DataSet.Tables[0];
$MyResults | foreach-object {
    $PROFNAME = $_.PROFNAME;
    $ADRNAME = $_.ADRNAME;
    $PROFSTATUS = $_.PROFSTATUS;
    $ADRMOBILE = $_.ADRMOBILE;
    $ADRPHONE = $_.ADRPHONE;

	$request = Invoke-RestMethod "http://<EA_Server>/EAWebService/rest/events?apiKey=<REST_Endpoint_Key>" -Method POST -ContentType "application/json" -Body "{'PROFNAME':'$PROFNAME','ADRNAME':'$ADRNAME','PROFSTATUS':'$PROFSTATUS', 'ADRMOBILE':'$ADRMOBILE','ADRPHONE':'$ADRPHONE'}"
}