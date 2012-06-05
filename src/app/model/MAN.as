package app.model
{
	[Bindable]
	[Table(name="MANS")]
	public class MAN
	{
		public var id:int;
		
		public var pontuacaoTriagem:Number;
		
		public var pontuacaoGlobal:Number;
		
		public var estadoNutricionalTriagem:String;
		
		public var estadoNutricionalGlobal:String;
		
		//respostas do paciente
		public var opcaoA:String;
		public var pontosA:int;
		
		public var opcaoB:String;
		public var pontosB:int;
		
		public var opcaoC:String;
		public var pontosC:int;
		
		public var opcaoD:String;
		public var pontosD:int;
		
		public var opcaoE:String;
		public var pontosE:int;
		
		public var opcaoIMC:String;
		public var pontosIMC:int;
		
		public var opcaoF:String;
		public var pontosF:int;
		
		public var opcaoG:String;
		public var pontosG:int;
		
		public var opcaoH:String;
		public var pontosH:int;
		
		public var opcaoI:String;
		public var pontosI:int;
		
		public var opcaoJ:String;
		public var pontosJ:int;
		
		public var opcaoK1:String;
		public var pontosK1:int;
		
		public var opcaoK2:String;
		public var pontosK2:int;
		
		public var opcaoK3:String;
		public var pontosK3:int;
		
		public var opcaoL:String;
		public var pontosL:int;
		
		public var opcaoM:String;
		public var pontosM:int;
		
		public var opcaoN:String;
		public var pontosN:int;
		
		public var opcaoO:String;
		public var pontosO:int;
		
		public var opcaoP:String;
		public var pontosP:int;
		
		public var opcaoQ:String;
		public var pontosQ:int;
		
		public var opcaoR:String;
		public var pontosR:int;
		
		[Transient]
		public function getDescricaoTriagem():String
		{
			var resultado:String = '' ;
			if( pontuacaoTriagem < 8 ){
				resultado += 'DESNUTRIDO' ;
			} else if( pontuacaoTriagem >= 8 && pontuacaoTriagem < 12 ){
				resultado += 'SOB RISCO DE DESNUTRIÇÃO' ;
			} else {
				resultado += 'NORMAL' ;
			}
			
			return resultado;
		}
		
		[Transient]
		public function getDescricaoGlobal():String
		{
			var resultado:String = '' ;
			var pf:Number = pontuacaoTriagem + pontuacaoGlobal ;
			
			if( pf < 17 ){
				resultado += 'DESNUTRIDO' ;
			} else if( pf >= 17 && pf < 23.5 ){
				resultado += 'SOB RISCO DE DESNUTRIÇÃO' ;
			} else {
				resultado += 'NORMAL' ;
			}
			
			return resultado;
		}
		
		public function MAN(){}
	}
}