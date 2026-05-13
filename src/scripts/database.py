"""Database connection and management."""
from dataclasses import dataclass
from typing import List, Tuple, Optional
from decimal import Decimal
import mysql.connector
from mysql.connector import MySQLConnection
from mysql.connector.cursor import MySQLCursor

from src.scripts.constants import (
    DEFAULT_HOST, DEFAULT_USER, DEFAULT_PASSWORD,
    DEFAULT_DATABASE, DEFAULT_CHARSET, DEFAULT_COLLATION
)


@dataclass
class DatabaseConfig:
    """Database connection configuration."""
    host: str = DEFAULT_HOST
    user: str = DEFAULT_USER
    password: str = DEFAULT_PASSWORD
    database: str = DEFAULT_DATABASE
    charset: str = DEFAULT_CHARSET
    collation: str = DEFAULT_COLLATION


class DatabaseManager:
    """Handles database connections and operations."""
    
    def __init__(self, config: DatabaseConfig):
        self.config = config
        self.connection: Optional[MySQLConnection] = None
        self.cursor: Optional[MySQLCursor] = None

    def connect(self) -> None:
        """Establish database connection."""
        self.connection = mysql.connector.connect(
            host=self.config.host,
            user=self.config.user,
            password=self.config.password,
            database=self.config.database,
            charset=self.config.charset,
            use_unicode=True,
            collation=self.config.collation
        )
        self.cursor = self.connection.cursor()
        self.cursor.execute("SET NAMES utf8mb4;")

    def disconnect(self) -> None:
        """Close database connection."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()

    def execute_query(self, query: str) -> Tuple[List[str], List[List[str]]]:
        """Execute a query and return formatted results."""
        if not self.cursor:
            raise RuntimeError("Database not connected")
        
        self.cursor.execute(query)
        columns = [desc[0] for desc in self.cursor.description]
        result = self.cursor.fetchall()
        formatted_result = [[self._format_value(value) for value in row] for row in result]
        return columns, formatted_result

    @staticmethod
    def _format_value(value: any) -> str:
        """Format a value for output."""
        if value is None:
            return "NULL"
        if isinstance(value, (int, float, Decimal)):
            return f"{Decimal(value):.2f}"
        return str(value) 