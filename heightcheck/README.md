# HeightCheck

Confirms factomd is at current block height, best run as a scheduled task, silently fails if no response from daemon, only catches stalled blocks.

Powershell 3 or higher for windows, may require a change in execution policy

```powershell
powershell.exe set-executionpolicy -scope currentuser -executionpolicy remotesigned
```
