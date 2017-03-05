function HeightQuery{
Invoke-RestMethod -Uri http://localhost:8088/v2 -Method POST -ContentType "application/json" -Body (ConvertTo-Json $body)
}
$body = @{method="heights"; params=$null; jsonrpc="2.0"; id="1"}
$result = HeightQuery
$leader = $result.result.leaderheight
$height = $result.result.directoryblockheight
if (($leader - $height) -gt 3) {
        Start-Sleep -s 15
        $newresult = HeightQuery
        $newheight = $newresult.result.directoryblockheight
        if (($newheight - $height) -lt 150) {
                Stop-Process -name factomd
                Start-Sleep -s 10
                Start-Process factomd
        }
}
