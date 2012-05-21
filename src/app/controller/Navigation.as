package app.controller
{
	import app.enums.EAreas;
	import app.model.Usuario;
	import app.util.General;
	import app.view.Estrutura;
	import app.vo.VoInfoArea;
	
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import spark.components.SkinnableContainer;

	public class Navigation
	{
		private static var areaAtual:VoInfoArea;
		private static var areaAnterior:VoInfoArea;
		
		private static var estrutura:Estrutura;

		private static var areas:Array = new Array();
		
		public static function init(est:Estrutura):void
		{
			estrutura = est ;
		}
		
		public static function reinitEstrutura():void
		{
			if( estrutura )
			{
				if( General.usuario != null )
				{
					estrutura.init();
				}
				else
				{
					estrutura.initWithoutUser();
				}
			}
		}
		
		public static function navega(area:VoInfoArea):void
		{
			if( area == null ) throw new Error("area não pode ser nulo.");
			
			if( areaAtual != null ){
				if( area.nome == areaAtual.nome ) return ;
				
				areaAnterior = areaAtual ;
				areaAtual = area ;
				
				if( area.nome != EAreas.CONSULTA.nome ){
					if( General.consultaAtual != null ){
						Alert.yesLabel = "Sim" ;
						Alert.noLabel = "Não" ;
						Alert.show("Você está cadastrando uma nova consulta. Caso saia dessa tela, a consulta será gravada somente até o ultimo momento que foi salva. Deseja continuar e sair?", "Cuidado", Alert.YES|Alert.NO, null, onAlertSair );
						return ;
					}
				}
			} else {
				areaAnterior = areaAtual ;
				areaAtual = area ;
			}
			
			addArea();
		}
		
		private static function addArea():void
		{
			var container:SkinnableContainer = estrutura.getContainer() ;
			container.removeAllElements();
			
			var type:Class = areaAtual.className as Class;
			var area:UIComponent = new type();
			
			container.addElement(area);
			
			estrutura.bgAreas.visible = areaAtual.usaBg ;
		}
		
		private static function onAlertSair( e:CloseEvent ):void
		{
			if( e.detail == Alert.YES ){
				addArea();
			} else {
				areaAtual = areaAnterior ;
			}
		}
	}
}