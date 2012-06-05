package app.util
{
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.components.VGroup;
	import spark.components.supportClasses.Skin;

	public class Tabela
	{
		private var _colunas:int = 1 ;
		private var _primeiroHeader:Boolean = false ;
		
		private var container:VGroup;
		
		public function Tabela( colunas:int = 1, primeiroHeader:Boolean = false )
		{
			_colunas = colunas ;
			_primeiroHeader = primeiroHeader ;
			
			container = new VGroup();
			container.gap = 0 ;
			container.percentWidth = 100 ;
		}
		
		public function config(dados:Array, propCols:Array = null, cores:Array = null):VGroup
		{
			var c:int = 0 ;
			var linha:SkinnableContainer;
			var hg:HGroup;
			var dado:Object;
			
			if( dados ){
				container.removeAllElements();
				
				for (var i:int = 0; i < dados.length; i++) 
				{
					linha = new SkinnableContainer();
					linha.percentWidth = 100 ;
					
					if( cores != null ){
						linha.setStyle('backgroundColor', cores[c % cores.length]);
					}
					
					hg = new HGroup();
					hg.percentWidth = 100 ;
					hg.gap = 0;
					
					dado = dados[i];
					if( dado.conteudo ){
						var conteudo:Label = new Label();
						
						if( dado.conteudo is String ){
							if( propCols ){
								var pc:Number = 0;
								var contados:int = _colunas ;
								if( dado.cols ){
									contados = dado.cols >= _colunas ? _colunas : dado.cols ;
									
									for (var k:int = 0; k < (propCols.length > contados ? contados : propCols.length ); k++) 
									{
										pc += propCols[k] ;
									}
								} else {
									pc = 1 ;
								}
								conteudo.percentWidth = 100 / pc ;
							} else {
								if( dado.cols ){
									conteudo.percentWidth = 100 / ( dado.cols >= _colunas ? _colunas : dado.cols ) ;
								} else {
									conteudo.percentWidth = 100 ;
								}
							}
							
							if( _primeiroHeader && i == 0 ){
								conteudo.styleName = "bold" ;
							} else {
								if( dado.estilo ) conteudo.styleName = dado.estilo ;
							}
							
							hg.addElement(conteudo);
						} else if( dado.conteudo is Array ){
							var fim:int = _colunas ;
							if( dado.cols ) fim = dado.cols >= _colunas ? _colunas : dado.cols ;
							
							var traceStr:String = '' ;
							var largura:Number = 0 ;
							
							for (var j:int = 0; j < fim; j++) 
							{
								if( propCols ){
									var pc:Number = 0;
									var contados:int = _colunas ;
									if( dado.cols ){
										contados = dado.cols >= _colunas ? _colunas : dado.cols ;
										
										for (var l:int = 0; l < (propCols.length > contados ? contados : propCols.length ); l++) 
										{
											pc += propCols[l] ;
										}
									} else {
										if( j >= propCols.length ){
											pc = 100 / ( _colunas - propCols.length )
										} else {
											pc = propCols[ j ] ;
										}
									}
									largura = pc ;
								} else {
									largura = 100 / fim ;
								}
								
								conteudo = new Label();
								conteudo.percentWidth = largura ;
								conteudo.text = dado.conteudo[j] ;
								
								traceStr += '\t\t' + dado.conteudo[j] + '(' + largura + ')';
								
								if( _primeiroHeader && i == 0 ){
									conteudo.styleName = "bold" ;
								} else {
									if( dado.estilo ){
										if( dado.estilo[j] ) conteudo.styleName = dado.estilo[j] ;
									}
								}
							}
							
							trace( traceStr );
							hg.addElement(conteudo);
						}
						
						c++ ;
						
						linha.addElement(hg);
						container.addElement(linha);
					}
				}
			}
			
			return container;
		}
	}
}