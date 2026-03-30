@echo off
REM Script to run tests with coverage report for Colordary project (Windows)
REM Usage: run_coverage.bat

echo 🧪 Running Flutter tests with coverage...
flutter test --coverage

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Tests completed successfully!
    echo.
    echo 📊 Coverage report generated at: coverage/lcov.info
    echo.
    echo 📝 To generate an HTML report, install lcov:
    echo    On Windows: choco install lcov
    echo.
    echo Then run:
    echo    genhtml coverage/lcov.info -o coverage/html
    echo.
    echo Open the HTML report:
    echo    start coverage/html/index.html
) else (
    echo ❌ Tests failed. Please check the output above.
    exit /b 1
)
