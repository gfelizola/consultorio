package com.gustavofelizola.form 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class FormValidator
	{
		public static const EMPTY:String = "validateEmpty" ;
		public static const DIFF:String = "validateDiff" ;
		public static const EQUAL:String = "validateEqual" ;
		public static const NUMBER:String = "validateNumber" ;
		public static const EMAIL:String = "validateEmail" ;
		public static const MAX_CHAR:String = "validateMaxChar" ;
		public static const MIN_CHAR:String = "validateMinChar" ;
		public static const DATE:String = "validateDate" ;
		public static const MAX_DATE:String = "validateMaxDate" ;
		public static const MIN_DATE:String = "validateMinDate" ;
		
		public var wrongColor:uint; ;
		
		private var fields:/*Field*/Array ;
		private var wFields:/*Field*/Array;
		
		public function FormValidator( wrongColor:uint = 0xFF0000 ) 
		{
			fields = new Array();
			this.wrongColor = wrongColor ;
		}
		
		public function add(field:TextField, validation:String, param:String = null ):void 
		{
			var f:Field = new Field( field, validation, wrongColor, param );
			fields.push(f);
		}
		
		public function isValid():Boolean 
		{
			var retorno:Boolean = true ;
			wFields = new Array();
			
			for (var i:int = 0 ; i < fields.length ; i++) 
			{
				if ( ! fields[i].isValid() ) {
					retorno = false ;
					wFields.push( fields[i] );
				}
			}
			return retorno;
		}
		
		private function isBadYet( field:Field ):Boolean 
		{
			for (var i:int = 0 ; i < wFields.length ; i++ ) 
			{
				if ( wFields[i].field == field.field ) return true ;
			}
			return false ;
		}
		
	}

}