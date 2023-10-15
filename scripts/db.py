import os
import sqlite3

home = os.getenv('HOME')
sqlite_path = os.path.join(home, '.local', 'ml_server.db')


def prepare_tables():
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute("""CREATE TABLE IF NOT EXISTS code_completion(
    language TEXT,
    code TEXT,
    completion TEXT,
    time DATETIME DEFAULT CURRENT_TIMESTAMP
  )
  """)

  cursor.execute("""CREATE TABLE IF NOT EXISTS comment(
    language TEXT,
    code TEXT,
    comments TEXT,
    time DATETIME DEFAULT CURRENT_TIMESTAMP
  )
  """)

  cursor.execute("""CREATE TABLE IF NOT EXISTS implementation(
    language TEXT,
    instruction TEXT,
    implementation TEXT,
    time DATETIME DEFAULT CURRENT_TIMESTAMP
  )
  """)

  cursor.execute("""CREATE TABLE IF NOT EXISTS test_case(
    language TEXT,
    code TEXT,
    implementation TEXT,
    time DATETIME DEFAULT CURRENT_TIMESTAMP
  )
  """)

  cursor.execute("""CREATE TABLE IF NOT EXISTS example(
    language TEXT,
    code TEXT,
    example TEXT,
    time DATETIME DEFAULT CURRENT_TIMESTAMP
  )
  """)


prepare_tables()


def insert_code_completion(language, code, completion):
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute(
    """INSERT INTO code_completion(language, code, completion) VALUES(?, ?, ?)""",
    (
      language,
      code,
      completion,
    ))
  connection.commit()


def insert_comment(language, code, comments):
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute(
    """INSERT INTO comment(language, code, comments) VALUES(?, ?, ?)""", (
      language,
      code,
      comments,
    ))
  connection.commit()


def insert_implementation(language, instruction, implementation):
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute(
    """INSERT INTO implementation(language, instruction, implementation) VALUES(?, ?, ?)""",
    (
      language,
      instruction,
      implementation,
    ))
  connection.commit()


def insert_test_case(language, code, implementation):
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute(
    """INSERT INTO test_case(language, code, implementation) VALUES(?, ?, ?)""",
    (
      language,
      code,
      implementation,
    ))
  connection.commit()


def insert_example(language, code, example):
  connection = sqlite3.connect(sqlite_path)
  cursor = connection.cursor()
  cursor.execute(
    """INSERT INTO example(language, code, example) VALUES(?, ?, ?)""",
    (
      language,
      code,
      example,
    ))
  connection.commit()
