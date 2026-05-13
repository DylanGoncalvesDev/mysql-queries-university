"""SQL query analysis and performance checking."""
from typing import List, Tuple, Set
import time
from mysql.connector.cursor import MySQLCursor

from src.scripts.constants import (
    QUERY_ISSUES, TIME_FORMAT, INDEX_USED,
    NO_INDEX, ISSUES_HEADER
)


class QueryAnalyzer:
    """Analyzes SQL query performance and provides recommendations."""

    def __init__(self, cursor: MySQLCursor):
        self.cursor = cursor

    def analyze(self, query: str) -> str:
        """Analyze query performance and return a report."""
        start_time = time.time()
        self.cursor.execute(f"EXPLAIN {query}")
        explain_result = self.cursor.fetchall()
        execution_time = round((time.time() - start_time) * 1000, 2)

        issues = self._detect_issues(query, explain_result)
        indices_usados = self._get_used_indices(explain_result)
        possible_keys = self._get_possible_keys(explain_result)

        return self._generate_report(execution_time, indices_usados, possible_keys, issues)

    def _detect_issues(self, query: str, explain_result: List[Tuple]) -> Set[str]:
        """Detect potential issues in the query."""
        issues = set()
        
        if "JOIN" in query.upper() and not any(row[5] for row in explain_result if row[5] and row[5] != "NULL"):
            issues.add(QUERY_ISSUES["JOIN_WITHOUT_INDEX"])
        
        if "SELECT *" in query.upper():
            issues.add(QUERY_ISSUES["SELECT_STAR"])
        
        if " IN (" in query.upper() and "EXISTS" not in query.upper():
            issues.add(QUERY_ISSUES["IN_WITHOUT_EXISTS"])
        
        return issues

    @staticmethod
    def _get_used_indices(explain_result: List[Tuple]) -> Set[str]:
        """Get indices used in the query."""
        return {row[5] for row in explain_result if row[5] and row[5] != "NULL"}

    @staticmethod
    def _get_possible_keys(explain_result: List[Tuple]) -> Set[str]:
        """Get possible keys for the query."""
        return {row[4] for row in explain_result if row[4]}

    def _generate_report(self, execution_time: float, indices_usados: Set[str],
                        possible_keys: Set[str], issues: Set[str]) -> str:
        """Generate a performance analysis report."""
        report = [TIME_FORMAT.format(execution_time)]

        if indices_usados:
            report.append(INDEX_USED.format(", ".join(indices_usados)))
        else:
            report.append(NO_INDEX)

        if issues:
            report.append(ISSUES_HEADER)
            report.extend(issues)

        return "\n".join(report)
    