package app.model
{
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	import nz.co.codec.flexorm.EntityManager;

	public class DB
	{
		private static var _con:SQLConnection;
		private static var _first:Boolean = true ;
		private static var _em:EntityManager;
		
		public static function get first():Boolean
		{
			if( _con == null ) openConn();
			return _first ;
		}
		
		public static function get em():EntityManager
		{
			if( _con == null ) openConn();
			return _em;
		}
		
		public static function get con():SQLConnection
		{
			if( _con == null ) openConn();
			return _con ;
		}
		
		private static function openConn():void
		{
		
			var db:File = File.applicationStorageDirectory.resolvePath("nutrisaude_co.db");
			trace(db.nativePath, db.exists); // Imprime o caminho do DB
			
			_con = new SQLConnection();
			
			if( db.exists ){
				_first = false ;
			} 
			
//			var generator:EncryptionKeyGenerator = new EncryptionKeyGenerator();
//			var key:ByteArray = generator.getEncryptionKey("NutriSaudePass@2012");
			
			_con.open(db);//, SQLMode.CREATE, false, 1024, key);
			
			_em = EntityManager.instance ;
			_em.debugLevel = 1 ;
			_em.sqlConnection = _con ;
		}
	}
}