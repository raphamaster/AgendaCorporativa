package br.com.chiaperini
{
	//--------------------------------------------------------------------------
	//
	//  Importando Classes nescessárias
	//
	//--------------------------------------------------------------------------
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
		
	//--------------------------------------------------------------------------
	//
	//  Declaracao da Classe DB
	//
	//--------------------------------------------------------------------------
	public class DB
	{
	
	//--------------------------------------------------------------------------
	//
	//  Declrando Variaveis Nescessárias
	//
	//--------------------------------------------------------------------------
		private static var conectado:Boolean = false;
		private static var dbFile:File
		private static var conn:SQLConnection
		private static var _sqlStatement:SQLStatement;		
		private static var resultado:SQLResult;
		private static var retornoString:String;
		private static var retornoObjeto:Object;
		public static var sqlStatementParameters:SQLStatement;
			
	//--------------------------------------------------------------------------
	//
	//  Método Inicia() utilizado para conectar com o banco de dados
	//
	//--------------------------------------------------------------------------
		public static function Inicia():String
		{
			conn = new SQLConnection();
			dbFile = File.applicationDirectory.resolvePath(String("data/ListaContato.db"));
			
			//Alert.show(dbFile.url);
			
			try
			{
				conn.open(dbFile);
				conectado = true;
				trace("Conectado com "+dbFile.name);
				retornoString = "Conectado com "+dbFile.name;
			}
			catch (error:SQLError) 
			{
				conectado = false;
				retornoString = "Falha ao conectar: "+error.message+"\nDetalhes: "+error.details;
			}
				return retornoString;
			}
			
	//--------------------------------------------------------------------------
	//
	//  Método para resgatar os dados do db sem o uso de parametros
	//
	//--------------------------------------------------------------------------		
		public static function executeQuery(_sql:String):Object
		{
			if(conectado == true)
			{
				_sqlStatement = new SQLStatement();
				_sqlStatement.sqlConnection = conn;
				_sqlStatement.text = _sql;
				try
				{
					_sqlStatement.execute();
					resultado = _sqlStatement.getResult();
					retornoObjeto = resultado;
				}
				catch (error:SQLError)
				{
					retornoString = "Falha ao executar("+_sql+"): "+error.message+"\nDetalhes: "+error.details;
				}
				
				return retornoObjeto ? retornoObjeto:retornoString;
				
			} else {
					return "Não conectado!";
			}
		}
	
			
			public static function executeQueryLogin(_sql:String, _login:String):Object
			{
				if(conectado == true)
				{
					_sqlStatement = new SQLStatement();
					_sqlStatement.sqlConnection = conn;
					_sqlStatement.text = _sql;
					_sqlStatement.parameters["@Login"] = _login;
					try
					{
						_sqlStatement.execute();
						resultado = _sqlStatement.getResult();
						retornoObjeto = resultado;
					}
					catch (error:SQLError)
					{
						retornoString = "Falha ao executar("+_sql+"): "+error.message+"\nDetalhes: "+error.details;
					}
					return retornoObjeto?retornoObjeto:retornoString;
				}
				else
				{
					return "Não conectado!";
				}
			}
			
		}
		
}
