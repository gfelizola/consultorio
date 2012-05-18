package com.gustavofelizola.utils 
{
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class Share
	{
		public static var trackShare:Boolean = true ;
		
		public function Share() { }
		
		/*
		 * @param titulo: titulo que irá aparecer antes do texto
		 * @param shortUrl: url encurtada com link pro site
		 * */
		public static function twitter(titulo:String, shortUrl:String):void 
		{
			var tituloFinal:String = titulo.split(" ").join("+");
			getURL("http://www.twitter.com/home/?status=" + tituloFinal + "+-+" + shortUrl) ;
			
			if ( trackShare ) ExternalInterface.call("pageTracker._trackPageview", "share_twitter");
		}
		
		/*
		 * @param url: url com link pro site
		 * */
		public static function facebook(url:String):void 
		{
			getURL("http://www.facebook.com/share.php?t=&u=" + url);
			if ( trackShare ) ExternalInterface.call("pageTracker._trackPageview", "share_facebook");
		}
		
		/*
		 * @param titulo: titulo que irá aparecer antes do texto
		 * @param descricao: um texto breve com descrição ou slogan do site
		 * @param shortUrl: url encurtada com link pro site
		 * */
		
		public static function orkut(titulo:String, descricao:String, url:String):void 
		{
			var tituloFinal:String = titulo.split(" ").join("%20");
			var descricaoFinal:String = descricao.split(" ").join("%20");
			
			getURL("http://promote.orkut.com/preview?nt=orkut.com&tt=" + titulo + "&du=" + url + "&cn=" + descricaoFinal);
			if ( trackShare ) ExternalInterface.call("pageTracker._trackPageview", "share_facebook");
		}
		
		private static function getURL(url:String):void 
		{
			navigateToURL(new URLRequest(url) , "_blank");
		}
		
	}

}