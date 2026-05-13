"""Constants used across the SQL query analyzer."""

# Database configuration
DEFAULT_HOST = "127.0.0.1"
DEFAULT_USER = "root"
DEFAULT_PASSWORD = "root"
DEFAULT_DATABASE = "universidad"
DEFAULT_CHARSET = "utf8mb4"
DEFAULT_COLLATION = "utf8mb4_general_ci"

# File paths
DEFAULT_QUERIES_PATH = "./queries/queries.sql"
RESULTS_FILE = "RESULTADOS.md"
EXPECTED_RESULTS_DIR = "src/expected_results"

# Query analysis constants
QUERY_ISSUES = {
    "SELECT_STAR": "⚠️ Evitar `SELECT *`. Usar solo las columnas necesarias.",
    "IN_WITHOUT_EXISTS": "⚠️ Considerar `EXISTS` en lugar de `IN` para eficiencia.",
    "JOIN_WITHOUT_INDEX": "🚨 `JOIN` sin índice. Revisar claves foráneas e índices."
}

# Report formatting
REPORT_HEADER = "# 📊 Análisis de Consultas SQL\n"
REPORT_SEPARATOR = "\n---\n"
TIME_FORMAT = "⏱ Tiempo: {:.2f} ms"
INDEX_USED = "✅ Se usó índice(s) en la consulta: {}"
NO_INDEX = "🔍 No se usó ningún índice en esta consulta."
ISSUES_HEADER = "\n🚨 **Problemas detectados:**"
QUERIES_SUMMARY = "\n## 📈 Resumen\n✅ {correct} correctas de {total} queries\n" 