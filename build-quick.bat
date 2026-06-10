@echo off
chcp 65001 >nul
echo ===============================================
echo   БЫСТРАЯ ПЕРЕСБОРКА ДИССЕРТАЦИИ
echo ===============================================
echo.

echo [1/4] Первый прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo [2/4] Запуск Biber...
biber dissertation

echo.
echo [3/4] Второй прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo [4/4] Третий прогон XeLaTeX...
xelatex -synctex=1 -interaction=nonstopmode dissertation.tex

echo.
echo ===============================================
echo   Быстрая сборка завершена!
echo ===============================================
pause