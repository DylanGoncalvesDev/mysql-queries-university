"""SQL query validation and result comparison."""
from typing import List
import difflib
import re

from src.scripts.constants import DEFAULT_QUERIES_PATH


class QueryValidator:
    """Validates SQL queries against expected results."""

    @staticmethod
    def read_queries(file_path: str = DEFAULT_QUERIES_PATH) -> List[str]:
        """Read SQL queries from file."""
        with open(file_path, "r") as f:
            queries = f.read()
        return [q.strip() for q in re.split(r';\s*\n', queries) if q.strip()]

    @staticmethod
    def read_expected_result(file_path: str) -> List[str]:
        """Read expected results from file."""
        with open(file_path, "r") as f:
            return [line.strip() for line in f.readlines()]

    @staticmethod
    def compare_results(query_index: int, result_formatted: List[str],
                       expected: List[str]) -> str:
        """Compare actual results with expected results."""
        if result_formatted == expected:
            return f"## ✅ Query {query_index}: Correcto\n"
        
        diff_text = "\n".join(difflib.unified_diff(expected, result_formatted, lineterm=""))
        return f"## ❌ Query {query_index}: Incorrecto\n```diff\n{diff_text}\n```\n" 