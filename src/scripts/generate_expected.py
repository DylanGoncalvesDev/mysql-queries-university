import sys, os, re, pymysql
from decimal import Decimal

sys.stdout.reconfigure(encoding='utf-8')

db = pymysql.connect(
    host="127.0.0.1", user="root", password="root",
    database="universidad", charset="utf8mb4",
    use_unicode=True, autocommit=True
)
cursor = db.cursor()



cursor.execute("SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;")


def read_queries(path="./queries/queries.sql"):
    with open(path, "r", encoding="utf-8") as f:
        return [q.strip() for q in re.split(r';\s*(?:\n|$)', f.read()) if q.strip()]

def fmt(v):
    if v is None: return "NULL"
    if isinstance(v, (int, float, Decimal)): return f"{Decimal(v):.2f}"
    return str(v)

os.makedirs("src/expected_results", exist_ok=True)
for i, q in enumerate(read_queries(), 1):
    try:
        cursor.execute(q)
        if cursor.description is None:
            continue
        cols = [d[0] for d in cursor.description]
        lines = [" | ".join(cols)]
        lines += [" | ".join(fmt(v) for v in row) for row in cursor.fetchall()]

        print(f"🔹 Query {i} mostra:", *lines[:4], sep="\n")
        with open(f"src/expected_results/query_{i}.out", "w", encoding="utf-8") as f:
            f.write("\n".join(lines))
    except Exception as e:
        print(f"⚠️ Error Query {i}: {e}")

cursor.close(); db.close()
print("🎉 Fitxers generats correctament.")
