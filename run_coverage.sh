#!/bin/bash
# Script to run tests with coverage report for Colordary project
# Usage: bash run_coverage.sh

echo "🧪 Running Flutter tests with coverage..."
flutter test --coverage

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Tests completed successfully!"
    echo ""
    echo "📊 Coverage report generated at: coverage/lcov.info"
    echo ""
    echo "📝 To generate an HTML report, install lcov:"
    echo "   - On macOS: brew install lcov"
    echo "   - On Linux: sudo apt-get install lcov"
    echo "   - On Windows: choco install lcov"
    echo ""
    echo "Then run:"
    echo "   genhtml coverage/lcov.info -o coverage/html"
    echo ""
    echo "Open the HTML report:"
    echo "   - macOS/Linux: open coverage/html/index.html"
    echo "   - Windows: start coverage/html/index.html"
else
    echo "❌ Tests failed. Please check the output above."
    exit 1
fi
