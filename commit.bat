@echo off
chcp 65001 > nul
echo ==========================================
echo       인바디 280 프로젝트 Git 자동 커밋
echo ==========================================
echo.

cd /d "%~dp0"

:: 1. Git 저장소 초기화
if not exist ".git" (
    echo [1/4] Git 저장소를 초기화합니다...
    git init
) else (
    echo [1/4] 기존 Git 저장소를 확인했습니다.
)

:: 2. 사용자 이름 및 이메일 기본값 설정 (미설정 시)
for /f "tokens=*" %%i in ('git config user.name') do set GIT_USER=%%i
if "%GIT_USER%"=="" (
    echo [2/4] 기본 사용자 정보를 등록합니다...
    git config user.name "AI남부ON"
    git config user.email "user@local.dev"
) else (
    echo [2/4] 사용자 확인: %GIT_USER%
)

:: 3. 파일 스테이징
echo [3/4] 작업 파일들을 추가합니다...
git add .

:: 4. 커밋 실행
echo [4/4] 커밋을 생성합니다...
git commit -m "feat: 인바디280 체성분 분석기 및 MD 리포트 시스템 구축"

echo.
echo ==========================================
echo              최근 커밋 기록
echo ==========================================
git log -1 --stat

echo.
echo ==========================================
echo         커밋이 성공적으로 완료되었습니다!
echo ==========================================
echo.
pause
