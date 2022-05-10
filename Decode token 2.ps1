$token = ""

if(!$token.Contains(".") -or !$token.StartsWith("eyJ"))
{ 
    Write-Error "Invalid token" -ErrorAction Stop 
}

$tokenHeader = $token.Split(".")[0].Replace('-', '+').Replace('_', '/')

while($tokenHeader.Length % 4)
{
    Write-Verbose "Invalid length for Base-64 string, adding =";
    $tokenHeader += "="
}

Write-Verbose "Base 64 padded header: $tokenHeader"

#Decode Header
Write-Verbose "Decoded Header: "
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($tokenHeader))| ConvertFrom-Json | fl | Out-Default

#Decode Payload
$tokenPayload = $token.Split(".")[1].Replace('-', '+').Replace('_', '/')

while($tokenPayload.Length % 4)
{
    Write-Verbose "Invalid length for Base-64 string, adding =";
    $tokenPayload += "="
}

Write-Verbose "Base 64 padded header: $tokenPayload"

#Decode Header
$tokenByteArray = [System.Convert]::FromBase64String($tokenPayload)
$tokenPayloadArray = [System.Text.Encoding]::ASCII.GetString($tokenByteArray)

$tokenPayloadObj = $tokenPayloadArray | ConvertFrom-Json

Write-Output $tokenPayloadObj


#Creating a function
#
#function <Name of Function>
#{
#[cmdletbinding()]
#param([Parameter(Mandatory=$true)][string] $<parameter>)
#
#
#code goes here
#
#return $<variable>
#}


