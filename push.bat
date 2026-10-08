@echo off
chcp 65001 > nul
echo ==========================================
echo        GitHub로 프로젝트 푸시 (업로드)
echo ==========================================
echo.
cd /d "%~dp0"

echo [1/2] 원격 저장소 연결 확인...
git remote set-url origin https://github.com/ekgus0001-pixel/ainambuon.git
git branch -M main

echo.
echo [2/2] GitHub로 푸시를 진행합니다...
echo (※ 혹시 로그인 창이 뜨면 브라우저 로그인을 완료해 주세요)
echo.
git push -u origin main

echo.
echo ==========================================
if %ERRORLEVEL% EQU 0 (
    echo         푸시가 성공적으로 완료되었습니다!
) else (
    echo         푸시 중 문제가 발생했습니다.
)
echo ==========================================
echo.
pause
