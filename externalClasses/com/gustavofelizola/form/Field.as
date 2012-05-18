package com.gustavofelizola.form 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class Field
	{
		public var field:TextField;
		public var validation:String;
		public var param:String;
		
		private var goodColor:uint;
		private var badColor:uint;
		
		
		public function Field( fieldToValidate:TextField, validationType:String, wrongColor:uint, param:String = null )
		{
			this.field = fieldToValidate;
			this.validation = validationType ;
			this.param = param ;
			this.badColor = wrongColor;
			this.goodColor = field.textColor ;
		}
		
		public function isValid():Boolean 
		{
			var retorno:Boolean = true ;
			switch( validation ) {
				case FormValidator.EMPTY: 		retorno = validateEmpty(); 		break;
				case FormValidator.DIFF: 		retorno = validateDiff(); 		break;
				case FormValidator.EQUAL: 		retorno = validateEqual(); 		break;
				case FormValidator.NUMBER: 		retorno = validateNumber(); 	break;
				case FormValidator.EMAIL: 		retorno = validateEmail(); 		break;
				case FormValidator.MAX_CHAR: 	retorno = validateMaxChar(); 	break;
				case FormValidator.MIN_CHAR: 	retorno = validateMinChar(); 	break;
				case FormValidator.DATE: 		retorno = validateDate(); 		break;
				case FormValidator.MAX_DATE: 	retorno = validateMaxDate(); 	break;
				case FormValidator.MIN_DATE: 	retorno = validateMinDate(); 	break;
			}
			
			field.textColor = retorno ? goodColor : badColor ;
			return retorno;
		}
		
		// ------------- VALIDAÇÕES ---------------------
		
		private function validateEmpty():Boolean 
		{
			if ( field.text.length <= 0 ) return false ;
			return true ;
		}
		
		private function validateDiff():Boolean 
		{
			if ( field.text == param ) return false ;
			return true ;
		}
		
		private function validateEqual():Boolean 
		{
			if ( field.text != param ) return false ;
			return true ;
		}
		
		private function validateNumber():Boolean 
		{
			if ( isNaN( Number( field.text ) ) ) return false ;
			return true ;
		}
		
		private function validateEmail():Boolean 
		{
			var reg:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return reg.test( field.text ) ;
		}
		
		private function validateMaxChar():Boolean 
		{
			if ( field.text.length > int(param) ) return false ;
			return true ;
		}
		
		private function validateMinChar():Boolean 
		{
			if ( field.text.length < int(param) ) return false ;
			return true ;
		}
		
		private function validateDate():Boolean 
		{
			// TODO - fazer validação de data
			return true ;
		}
		
		private function validateMaxDate():Boolean 
		{
			// TODO - fazer validação de data máxima
			return true ;
		}
		
		private function validateMinDate():Boolean 
		{
			// TODO - fazer validação de data mínima
			return true ;
		}
		
	}

}