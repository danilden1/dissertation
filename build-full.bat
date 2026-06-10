@echo off
chcp 65001 >nul

echo ===============================================
echo   ПОЛНАЯ ПЕРЕСБОРКА ДИССЕРТАЦИИ (с очисткой)
echo ===============================================
echo.

:: Создаём папку для логов, если её нет
if not exist "log" mkdir "log" 2>nul

:: === Получаем дату и время чисто через batch (без PowerShell) ===
:: Работает на большинстве русских Windows (формат даты ДД.ММ.ГГГГ)
for /f "tokens=1-3 delims=." %%a in ("%date%") do (
    set "dd=%%a"
    set "mm=%%b"
    set "yyyy=%%c"
)
for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set "hh=%%a"
    set "min=%%b"
)
:: Убираем возможные пробелы в часах
set "hh=%hh: =%"
if "%hh:~0,1%"==" " set "hh=0%hh:~1,1%"
if "%hh:~1,1%"=="" set "hh=0%hh%"
set "timestamp=%yyyy%-%mm%-%dd%_%hh%-%min%"
set "logfile=log\%timestamp%_full.log"

echo Лог вывода будет сохранён в:
echo %logfile%
echo.

echo [1/5] Удаление вспомогательных файлов...
del /q *.aux *.bbl *.bcf *.blg *.log *.out *.toc *.lof *.lot *.run.xml *.synctex.gz 2>nul
del /q Dissertation\*.aux Dissertation\*.log 2>nul
echo Готово.

:: Записываем заголовок в лог-файл
echo =============================================== > "%logfile%"
echo   ПОЛНАЯ ПЕРЕСБОРКА ДИССЕРТАЦИИ (с очисткой) >> "%logfile%"
echo   Дата/время сборки: %date% %time% >> "%logfile%"
echo   Лог-файл: %logfile% >> "%logfile%"
echo =============================================== >> "%logfile%"
echo. >> "%logfile%"

:: Логируем шаги и полный вывод XeLaTeX / Biber в файл
echo [1/5] Удаление вспомогательных файлов... >> "%logfile%"
echo Готово. >> "%logfile%"
echo. >> "%logfile%"

echo [2/5] Первый прогон XeLaTeX... >> "%logfile%"
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex >> "%logfile%" 2>&1
echo. >> "%logfile%"

echo [3/5] Запуск Biber... >> "%logfile%"
biber dissertation >> "%logfile%" 2>&1
echo. >> "%logfile%"

echo [4/5] Второй прогон XeLaTeX... >> "%logfile%"
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex >> "%logfile%" 2>&1
echo. >> "%logfile%"

echo [5/5] Третий прогон XeLaTeX... >> "%logfile%"
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex >> "%logfile%" 2>&1
echo. >> "%logfile%"

echo =============================================== >> "%logfile%"
echo   Сборка завершена! >> "%logfile%"
echo =============================================== >> "%logfile%"

echo.
echo ===============================================
echo   Сборка завершена!
echo   Полный лог сохранён в файле:
echo   %logfile%
echo ===============================================
pause