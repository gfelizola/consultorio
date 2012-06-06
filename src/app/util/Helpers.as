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
	}
}