@echo off
chcp 65001 >nul
echo ===============================================
echo   ПОЛНАЯ ПЕРЕСБОРКА ДИССЕРТАЦИИ (с очисткой)
echo ===============================================
echo.

echo [1/5] Удаление вспомогательных файлов...
del /q *.aux *.bbl *.bcf *.blg *.log *.out *.toc *.lof *.lot *.run.xml *.synctex.gz 2>nul
del /q Dissertation\*.aux Dissertation\*.log 2>nul
echo Готово.

echo.
echo [2/5] Первый прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo [3/5] Запуск Biber...
biber dissertation

echo.
echo [4/5] Второй прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo [5/5] Третий прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo ===============================================
echo   Сборка завершена!
echo ===============================================
pause