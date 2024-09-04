import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DbUtil {
  /// Retorna uma instância da conexão com o banco de dados.
  ///
  /// Cria um banco de dados chamado 'places.db' no diretório de bancos de dados
  /// do aplicativo. Se o banco de dados não existir, ele será criado com a
  /// tabela 'places'.
  ///
  /// Retorna: Uma instância de `sql.Database` da conexão.
  static Future<sql.Database> database() async {
    final dbPath = await sql
        .getDatabasesPath(); // Obtem o caminho do diretorio de bancos de dados
    return sql.openDatabase(
      // Abre ou cria o banco de dados
      path.join(dbPath, 'places.db'), // Caminho completo para o banco de dados
      onCreate: (db, version) {
        // Funcao chamada quando o banco de dados e criado
        return db.execute(// Executa a consulta SQL para criar a tabela
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1, // Versao do banco de dados
    );
  }

  /// Insere um novo registro na tabela especificada.
  ///
  /// Parâmetros:
  ///  - table: O nome da tabela.
  ///  - data: Um mapa com os dados a serem inseridos.
  ///
  /// Utiliza `conflictAlgorithm: ConflictAlgorithm.replace` para substituir o registro
  /// caso ele já exista.
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database(); // Obtem a conexao com o banco de dados
    await db.insert(
      // Insere o novo registro
      table, // Nome da tabela
      data, // Dados a serem inseridos
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Define o algoritmo para tratar conflitos
    );
  }

  /// Recupera todos os registros da tabela especificada.
  ///
  /// Parâmetros:
  ///  - table: O nome da tabela.
  ///
  /// Retorna: Uma lista de mapas, onde cada mapa representa um registro.
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database(); // Obtem a conexao com o banco de dados
    return db.query(
        table); // Executa a consulta SQL para obter todos os registros da tabela
  }
}
