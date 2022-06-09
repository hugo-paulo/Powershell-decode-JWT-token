$token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6ImpTMVhvMU9XRGpfNTJ2YndHTmd2UU8yVnpNYyJ9.eyJhdWQiOiJmNzg2MmE1ZS1iZTU4LTQ0YjAtYThkMi1jZDk0MDU5N2ZiNzEiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vYWQ4YTg0ZWYtZjFmMy00YjE0LWFkMDgtYjk5Y2E2NmY3ZTMwL3YyLjAiLCJpYXQiOjE2NTA2NDY3ODgsIm5iZiI6MTY1MDY0Njc4OCwiZXhwIjoxNjUwNjUwNjg4LCJhaW8iOiJBVFFBeS84VEFBQUFGdVBHS1ZYM3hjNmFmc0c2Mm56b0tWOGJmWlEyT1M2WnFKMEdIcWpjTTRtalZ1N2xLcitJVFRNRnFnOTlXOTNoIiwiZW1haWwiOiIyNjg4MTQ4QGNvbGxlZ2VsYWNpdGUuY2EiLCJuYW1lIjoiTWlnIMOvIFRlc3Q1IMOvIiwib2lkIjoiY2IzOWRhMzctYzVhOC00YzM5LWExOGYtNDAzYmFjZjUzOGRjIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiMjY4ODE0OEBjb2xsZWdlbGFjaXRlLmNhIiwicmgiOiIwLkFWY0E3NFNLcmZQeEZFdXRDTG1jcG05LU1GNHFodmRZdnJCRXFOTE5sQVdYLTNGWEFFQS4iLCJzdWIiOiJmb2QtcjhJdVFnQTllWFowMFZTNlNoYk1QLWlFQ0N4aUktS0JPN3d1OXdBIiwidGlkIjoiYWQ4YTg0ZWYtZjFmMy00YjE0LWFkMDgtYjk5Y2E2NmY3ZTMwIiwidXRpIjoiOURQOHpPWk9vVWFGZ2hHV29tTXNBQSIsInZlciI6IjIuMCJ9.n-AvJraAnskE1OPYfLc5lBWbWBSzZxXU7AETSc_wP-aBiGWy2JLjOEjXOMvrfnJTU9_C1WeEY6oxNXQI0n-6Wfs1xld0pb0fQd3_QQftszAuiLqS1xYp7-klVGTAVywZWxtS_uXgov7-9mmYtV_99hMOrtMIk4fX2V3xzCtWr87APrqESfUf_COzvylTmTj5CoqxMvgVgXTli3DPMlfEJzJTaAvk5ZBq8i-qUZp-8aDKtUveRfuBDo3bpJS-C2LzXNBVNQOhTl7XRkveeO0ZYDDyBtIJ-XEi0xVoClDTqgufq7OHOLTOXIe6c47qOmUYHqg1Yk6a9X6pPshoXaSQ8A"

if(!$token.Contains(".") -or !$token.StartsWith("eyJ"))
{ 
    Write-Error "Invalid token" -ErrorAction Stop 
}

$tokenHeader = $token.Split(".")[1].Replace('-', '+').Replace('_', '/')
$tokenHeader
$tokenByteArray = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($tokenHeader)) #this is good and does all at once
$tokenByteArray
$tokenPayloadArray = [System.Text.Encoding]::ASCII.GetString($tokenByteArray) #failing here because its out of ASCII
$tokenPayloadObj = $tokenPayloadArray | ConvertFrom-Json
$tokenPayloadObj


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


#different string deconding
PS > [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("YmxhaGJsYWg="))
blahblah

PS > [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("YmxhaGJsYWg="))
汢桡汢桡

PS > [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("YmxhaGJsYWg="))
blahblah