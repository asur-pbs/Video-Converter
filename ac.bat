@echo off
for /f "tokens=6 delims=[]. " %%i in ('ver') do set build=%%i
color 02
:Asur_MENU
cls
mkdir "%UserProfile%/videos/converted"
cls
set "choice="
echo [7m                                            Asur Video Converter                                                [0m
echo [32m 0 - Video Convertor [0m
echo [32m 1 - Video Compressor[0m
echo [32m 2 - Extract audio from a video file[0m
echo [32m 3 - Remove audio from a video file[0m
echo [32m 4 - Replace audio in a Video [0m
echo [32m 5 - Remove video subtitles [0m
echo [32m 6 - Add video subtitles [0m
echo [32m 7 - Trim video [0m
echo [32m 8 - Quit [0m
set /p choice="Choice: "
echo.
if /I "[%choice%]"=="[0]" goto :Vid_Con
if /I "[%choice%]"=="[1]" goto :Vid_Com
if /I "[%choice%]"=="[2]" goto :Extract_Audio
if /I "[%choice%]"=="[3]" goto :Remove_audio
if /I "[%choice%]"=="[4]" goto :Replace_Audio
if /I "[%choice%]"=="[7]" goto :Trim
if /I "[%choice%]"=="[5]" goto :Remove_Sub
if /I "[%choice%]"=="[6]" goto :Add_Sub
echo.
if /I "[%choice%]"=="[8]" goto :EOF
goto :Asur_MENU

:Vid_Con
cls
echo    [36m                                   Video Converter                                                    [0m
echo 1 - Convert to any video type (Lossless Convert)
echo 2 - Convert to any video type (Loss Convert)
echo 2 - Convert to dvd file type
set /p ch="Choice: "
if /I "[%ch%]"=="[1]" goto :Vid_Connotdvd
if /I "[%ch%]"=="[2]" goto :Vid_ConDVD
pause.
goto :Asur_MENU

:Vid_Connotdvd
cls
echo [36m                          Convert to any video type (Lossless Convert)[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -c:v libx264 -crf 19 -strict experimental "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the video is successfully converted, it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Loss
echo [36m                          Convert to any video type (Loss Convert)[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -c copy "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the video is successfully converted, it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
:Vid_ConDVD
cls
echo [36m                                         DVD Playable[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -y -target pal-dvd -sameq -aspect 16:9 "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the video is successfully converted, it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Vid_Com
cls
echo [36m                                     Video Compressor[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -n -loglevel error -i %ret% -vcodec libx264 -crf 28 -preset faster -tune film "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the video is successfully compressed, it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Extract_Audio
cls
echo [36m                                      Extract Audio[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
echo *****************************************************************************************************
echo * You can use low bit rate to speed up (kbs)                                                        *
echo *                  8   16  32   64   128     256    320                                             *
echo *                  low quality  normal     high quality                                             *
echo *                  High speed   normal      low speed                                               *
echo *****************************************************************************************************
set /p eb=Enter bitrate of Audio :
set /p ec=Output Audio name      :
set /p ed=Output Audio file type :
ffmpeg -hide_banner -t duration -i %ret% -ab %eb%k "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the audio is successfully extracted from video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Remove_Audio
cls
echo [36m                                   Remove Audio[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%          
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -c:v copy -an "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the audio is successfully removed from video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Replace_Audio
cls
echo [36m                                      Replace Audio[0m
echo Select Input Audio    :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ren]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ren=%FileName% 
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%               
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -i %ren% -c:v copy -map 0:v:0 -map 1:a:0 "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the audio is successfully replaced in video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
pause.
goto :Asur_MENU

:Remove_Sub
cls
echo [36m                                             Remove Sub[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%   
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -i %ret% -vcodec copy -acodec copy -sn "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the sub is successfully removed from video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
goto :Asur_MENU

:Add_Sub
cls
echo [36m                                            Add sub[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
echo Select Input subt.     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [rex]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set rex=%FileName%
set /p ec=Output video name      :
set /p ed=Output video file type : 
ffmpeg -hide_banner -t duration -i %ret% -i %rex% -codec copy -map 0 -map 1 "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the sub is successfully added to video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
goto :Asur_MENU

:Trim
cls
echo [36m                                        Video Trimmer[0m
echo Select Input video     :
    set cmd=Add-Type -AssemblyName System.Windows.Forms;$f=new-object                 Windows.Forms.OpenFileDialog;$f.InitialDirectory=        [environment]::GetFolderPath('Desktop');$f.Filter='All Files(*.*)^|*.*';$f.Multiselect=$true;[void]$f.ShowDialog();if($f.Multiselect)        {$f.FileNames}else{$f.FileName}
    set pwshcmd=powershell -noprofile -command "&{%cmd%}"
    for /f "tokens=* delims=" %%I in ('%pwshcmd%') do call :sum "%%I" ret
    :sum [mud] [ret]
    echo "%~1"
    set FileName=%FileName% "%~1"
    set ret=%FileName%
echo Enter duration like that 00:01:00
set /p ts=Trim start :
set /p tp=Trim stop  :
set /p ec=Output video name      :
set /p ed=Output video file type :
ffmpeg -hide_banner -t duration -ss %ts% -i %ret% -to %tp% -async 1 -c copy "%UserProfile%/videos/converted/%ec%.%ed%"
echo If the video is successfully trimmed from input video , it will be included in your videos.
echo If not, check out what happened by above
msg * Your process done.
goto :Asur_MENU

