$file = Get-ChildItem *.log
$file.FullName
# Get-Content .\IECG_B.02_CI_CD_280.log | Select-String -pattern '\[(\d{1,2}:(\d{1,2}):(\d{1,2}))\]W+(.*\bwarning\b)\sCS' -Encoding ASCII|
#      Out-File ".\log.txt" -Encoding ASCII
$fileCountCurrent = Get-Content $file | Select-String -pattern '\[(\d{1,2}:(\d{1,2}):(\d{1,2}))\]W+(.*\bwarning\b)\sCS' -Encoding ASCII|
     Measure-Object -Line
#$fileCountCurrent = Get-Content ".\log.txt" | Measure-Object -Line
Write-Output "Current build file count"
Write-Output "------------------------"
$fileCountCurrent.Lines
$fileCountPrevious = Get-Content .\log.txt | Select-String -pattern '\[(\d{1,2}:(\d{1,2}):(\d{1,2}))\]W+(.*\bwarning\b)\sCS' -Encoding ASCII|
     Measure-Object -Line
Write-Output ""
Write-Output "Previous build file count"
Write-Output "------------------------"
$fileCountPrevious.Lines

if ($fileCountCurrent.Lines -gt $fileCountPrevious.Lines) {
  Write-Output "Fail the build"
}
else {
  Write-Output "No action needed"
  #throw "Outputs not equal- Failing build"
}
