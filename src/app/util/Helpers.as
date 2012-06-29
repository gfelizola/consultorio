package app.util
{
	import mx.formatters.DateFormatter;

	public class Helpers
	{
		public function Helpers()
		{
		}
		
		static public function dateFormat(v:*,f:String="DD/MM/YYYY"):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = f;
			return df.format(v);
		}
		
		// dd/mm/YYYY
		static public function dateStringToObject(dateString:String):Date
		{
			var arr:Array = dateString.split("/");
			return new Date(arr[2], arr[1] - 1, arr[0]);
		}
		
		static public function idade( bd:*, t:Date = null ):Number
		{
			var today:Date = (t != null) ? t : new Date();
			var birthDate:Date = (typeof(bd) == "string") ? Helpers.dateStringToObject(bd) : bd;
			
			var age:Number = ( today.getFullYear() - birthDate.getFullYear() ) * 12;
			age += today.getMonth() - birthDate.getMonth();
			
//			var m:Number = today.getMonth() - birthDate.getMonth();
//			if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
//				age--;
//			}
			return age;
		}
		
		static public function validateDate( s:String ):Boolean
		{
			if ( s.indexOf("/") == -1 ) return false;
			var dateParts:Array = s.split("/");
			if ( dateParts.length != 3) return false;
			for (var i:int = 0; i < dateParts.length; i++)
			{
				if (isNaN(dateParts[i])) return false;
			}

			if (Number(dateParts[0]) < 1 || Number(dateParts[0]) > 31 ) return false;
			if (Number(dateParts[1]) < 1 || Number(dateParts[1]) > 12 ) return false;
			if (Number(dateParts[2]) < 1000 || Number(dateParts[2]) > 9999 ) return false;
			
			var day:Number 		= Number(dateParts[0]);
			var month:Number 	= Number(dateParts[1]) - 1;
			var year:Number 	= Number(dateParts[2]);
			var date:Date 		= new Date (year, month, day); 
			if ( date.getMonth() != month ) return false;
			return true;
		}
	}
}