$scriptRoot = $PSScriptRoot
Import-Module $PSScriptRoot\Centrify.Samples.PowerShell.psm1   3>$null 4>$null

<# 
 .Synopsis
  Upload Escrow key (PGP public key file) and set it into tenant config

 .Description
  For more details about how to generate the key pairs, please refer to https://www.openpgp.org/software/

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Parameter FilePath
  Required - The path of PGP public key file (e.g. C:\Test\test1)
  
 .Example
  Set-EscrowKey -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com -FilePath 'C:\Test\test1'
#>

function Set-EscrowKey
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token,
        [Parameter(Mandatory=$true)]
        [string] $filePath
    )

    try
    {
        # Set Escrow key
        $ret = Centrify-InvokeRESTFile -Endpoint $endpoint -Method "/ServerManage/SetEscrowKeyFromFile" -InFile $filePath -Token $token
        Write-Host "SetEscrowKey Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Set Escrow job email recipients 

 .Description
  The emails string is separated by ,/;/white space

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Parameter Emails
  Required - Escrow job email recipients separated by ,/;/white space
  
 .Example
  Set-EscrowEmail -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com -Emails 'shirley.zhang@centrify.com, shirleybazinga@gmail.com' 
#>

function Set-EscrowEmail
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token,
        [Parameter(Mandatory=$true)]
        [string] $emails
    )

    try
    {
        # Set Escrow email recipients
        $emailArgs = @{ 'emails' = $emails }
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/SetEscrowEmailAddresses" -ObjectContent $emailArgs -Token $token 
        Write-Host "SetEscrowEmail Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Get Escrow job email recipients 

 .Description
  The emails string is separated by ,/;/white space

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Example
  Get-EscrowEmail -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com
#>

function Get-EscrowEmail
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token
    )

    try
    {
        # Get Escrow email recipients
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/GetEscrowEmailAddresses" -Token $token 
        Write-Host "GetEscrowEmail Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
        Write-Host $ret.Result
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Run on-demand Escrow job 

 .Description

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Example
  Run-Escrow -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com
#>

function Run-Escrow
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token
    )

    try
    {
        # Run on-demand Escrow job
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/RunEscrow" -Token $token
        Write-Host "RunEscrow Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Schedule Escrow job

 .Description
  Run Escrow job once a day

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Example
  Schedule-Escrow -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com
#>

function Schedule-Escrow
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token
    )

    try
    {
        # Schedule Escrow job
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/ScheduleEscrow" -Token $token
        Write-Host "ScheduleEscrow Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Unschedule Escrow job

 .Description
  Cancel scheduled Escrow job

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed
 
 .Example
  Unschedule-Escrow -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com
#>

function Unschedule-Escrow
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token
    )

    try
    {
        # Cancel scheduled Escrow job
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/UnscheduleEscrow" -Token $token
        Write-Host "UnscheduleEscrow Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
 .Synopsis
  Get Escrow job schedule status

 .Description
  Check whether the Escrow job is scheduled, etc.

 .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
 .Parameter Token
  Required - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed

 .Example
  Get-EscrowScheduleStatus -Username dev@shirleyz.net -Endpoint https://abc0123-dev.my-dev.centrify.com
#>

function Get-EscrowScheduleStatus
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $token
    )

    try
    {
        # Get Escrow job schedule status
        $ret = Centrify-InvokeREST -Endpoint $endpoint -Method "/ServerManage/GetEscrowJobScheduleStatus" -Token $token 
        Write-Host "GetEscrowScheduleStatus Result: Success? $($ret.success). $($ret.Message) $($ret.InnerExceptions.Message)"
        Write-Host "Escrow job scheduled: $($ret.Result)"
    }
    catch
    {
        Write-Warning "Error : $($_.Exception.Message)"
    }
}

<# 
  .Synopsis
  Performs a REST call against the CIS platform.  

  .Description
  Performs a REST call against the CIS platform (PUT/GET for uploading/downloading file)

  .Parameter Endpoint
  Required - The target host for the call (e.g. https://cloud.centrify.com)
 
  .Parameter Method
  Required - The method to call (e.g. /security/logout)
  
  .Parameter Token
  Optional - The bearer token retrieved after authenticating, necessary for authenticated calls to succeed
  
  .Parameter FilePath
  Optional - The relative file path in the distributed file system
  
  .Parameter InFile
  Optional - Full path name of the file which the web request get the content from

  .Parameter OutFile
  Optional - Saves the response body in the specified output file

  .Example
  Centrify-InvokeRestFile -Endpoint $endpoint -Method "/ServerManage/DownloadSecretFileInChunks" -FilePath $downloadFilePath -OutFile "~\Downloads\test.jpg" -Token $token
  
  .Example
  Centrify-InvokeRestFile -Endpoint $endpoint -Method "/ServerManage/UploadSecretFileInChunks" -FilePath $uploadFilePath -InFile $secretFile -Token $token

  .Example
  Centrify-InvokeRESTFile -Endpoint $endpoint -Method "/ServerManage/SetEscrowKeyFromFilePath" -InFile $keyFilePath -Token $token 
#>

function Centrify-InvokeRestFile
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $endpoint,
        [Parameter(Mandatory=$true)]
        [string] $method,
        [string] $filePath = $null,
        [string] $token = $null,
        [string] $inFile,
        [string] $outFile,
        $websession = $null,
        [bool] $includeSessionInResult = $false,
        [int] $timeoutSecs = 60 
    )

    $methodEndpoint = $endpoint + $method + "?FilePath=" + $filePath
    Write-Verbose "Calling $methodEndpoint"
    
    $addHeaders = @{ 
        "X-CENTRIFY-NATIVE-CLIENT" = "1"
    }
    
    if(![string]::IsNullOrEmpty($token))
    {
        $addHeaders.Authorization = "Bearer " + $token
    }

    if(!$websession)
    {
        Write-Verbose "Creating new session variable"
        if ($inFile)
        {
            $response = Invoke-RestMethod -Uri $methodEndpoint -Method Put -InFile $inFile -SessionVariable websession -Headers $addHeaders -TimeoutSec $timeoutSecs
        }
        elseif ($outFile)
        {
            $response = Invoke-RestMethod -Uri $methodEndpoint -Method Get -OutFile $outFile -SessionVariable websession -Headers $addHeaders -TimeoutSec $timeoutSecs
        }
    }
    else
    {
        Write-Verbose "Using existing session variable $websession"
        if ($infile)
        {
            $response = Invoke-RestMethod -Uri $methodEndpoint -Method Put -InFile $inFile -WebSession $websession -TimeoutSec $timeoutSecs
        }
        elseif ($outFile)
        {
            $response = Invoke-RestMethod -Uri $methodEndpoint -Method Get -OutFile $outFile -WebSession $websession -TimeoutSec $timeoutSecs
        }
    }

    if($includeSessionInResult)
    {
        $resultObject = @{}
        $resultObject.RestResult = $response
        $resultObject.WebSession = $websession
        return $resultObject
    }
    else
    {
        return $response
    }
}

Export-ModuleMember -Function Set-EscrowKey
Export-ModuleMember -Function Set-EscrowEmail
Export-ModuleMember -Function Get-EscrowEmail
Export-ModuleMember -Function Run-Escrow
Export-ModuleMember -Function Schedule-Escrow
Export-ModuleMember -Function Unschedule-Escrow
Export-ModuleMember -Function Get-EscrowScheduleStatus


