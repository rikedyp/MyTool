$out = "\g\MyTool\mytool-test.log"

$dver = '["rikedyp/MyTool",18.0]'

$head = @{}
$head.Add("Content-Type", "application/json")

Invoke-RestMethod -Method POST -uri http://localhost:8080/GetURL -Headers $head -body $dver > $out

echo $dver
echo $r