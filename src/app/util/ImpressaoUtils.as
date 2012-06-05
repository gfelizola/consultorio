package app.util
{
	import app.model.Antropometria;
	import app.model.Atividade;
	import app.model.AtividadeFisica;
	import app.model.Consulta;
	import app.model.DadosAlimentares;
	import app.model.ExameAdicional;
	import app.model.ExameBioquimico;
	import app.model.MAN;
	import app.model.Refeicao;
	import app.model.ResumoConsulta;
	
	import mx.controls.HRule;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;

	public class ImpressaoUtils
	{
		public static function criaAntropometria( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766, legendaAdd:Boolean = true, legendaCor:uint = 0xbbbbbb, legendaSize:uint = 9 ):void
		{
			if( c.antropometria ){
				var a:Antropometria = c.antropometria ;
				var campos:Array = [
					{ nome:'PESO', 									valor: a.peso, 							medida:'kg' },
					{ nome:'PESO PRÉ-GESTACIONAL', 					valor: a.pesoPreGestacional, 			medida:'kg' },
					{ nome:'ESTATURA', 								valor: a.estatura, 						medida:'cm' },
					{ nome:'CIRCUNFERÊNCIA DA CINTURA***', 			valor: a.circunferenciaCintura, 		medida:'cm ' + a.getCircunferenciaCinturaDescription(c.paciente.sexo) },
					{ nome:'CIRCUNFERÊNCIA DO QUADRIL', 			valor: a.circunferenciaQuadril, 		medida:'cm' },
					{ nome:'CIRCUNFERÊNCIA DO TRÍCEPS', 			valor: a.circunferenciaTriceps, 		medida:'cm' },
					{ nome:'CIRCUNFERÊNCIA DA COXA', 				valor: a.circunferenciaCoxa, 			medida:'cm' },
					{ nome:'CIRCUNFERÊNCIA DA PANTURRILHA', 		valor: a.circunferenciaPanturrilha, 	medida:'cm' },
					{ nome:'DOBRA CUTÂNEA TRICIPTAL', 				valor: a.dobraCutaneaTriciptal, 		medida:'mm' },
					{ nome:'DOBRA CUTÂNEA BICIPTAL', 				valor: a.dobraCutaneaBiciptal, 			medida:'mm' },
					{ nome:'DOBRA CUTÂNEA SUBESCAPULAR', 			valor: a.dobraCutaneaSubescapular, 		medida:'mm' },
					{ nome:'DOBRA CUTÂNEA AXILAR MÉDIA', 			valor: a.dobraCutaneaAxilarMedia, 		medida:'mm' },
					{ nome:'DOBRA CUTÂNEA SUPRA-ILÍACA', 			valor: a.dobraCutaneaSupraIliaca, 		medida:'mm' },
					{ nome:'DOBRA CUTÂNEA TORÁCICA', 				valor: a.dobraCutaneaToracica, 			medida:'mm' },
					{ nome:'DOBRA CUTÂNEA ABDOMINAL', 				valor: a.dobraCutaneaAbdominal, 		medida:'mm' },
					{ nome:'DOBRA CUTÂNEA DA COXA', 				valor: a.dobraCutaneaCoxa, 				medida:'mm' },
					{ nome:'DOBRA CUTÂNEA DA PANTURRILHA MEDIAL', 	valor: a.dobraCutaneaPanturrilhaMedial, medida:'mm' },
					{ nome:'IMC*', 									valor: a.imc.toFixed(2) , 				medida:a.getIMCDescription() }
				];
				
				if( ! isNaN(a.circunferenciaCintura) && ! isNaN(a.circunferenciaQuadril) ){
					if( a.circunferenciaCintura > 0 && a.circunferenciaQuadril ){
						campos.push({ nome:'RELAÇÃO CINTURA X QUADRIL**', valor: (a.circunferenciaCintura / a.circunferenciaQuadril).toFixed(2), medida: a.getRCQDescription(c.paciente.sexo) })
					}
				}
				
				if( removeAll ) container.removeAllElements();
				
				for (var i:int = 0; i < campos.length; i++) 
				{
					var o:Object = campos[i] ;
					if( ! isNaN( o.valor ) ){
						if( o.valor > 0 ) container.addElement( ImpressaoUtils.getDuasColunas(o.nome, o.valor + ' ' + o.medida, textoSize, cor) ) ;
					}
				}
				
				if( legendaAdd ){
					
					var textos:Array = [
						'* OMS. Organização Mundial da Saúde. Diet, nutrition and the prevention of chronic diseases. Geneva, WHO; 2003.',
						'** WORLD HEALTH ORGANIZATION . Obesity: Preventing and managing the global epidemic – Report of a WHO consultation on obesity. Geneva, 1998.',
						'*** BRASIL. Ministério da Saúde. Vigilância Alimentar e Nutricional – SISVAN. Orientações básicas para a coleta, o processamento, a analise de dados e a informação em serviços de saúde. Diário Oficial da União Brasília, 2004.'
					];
					
					for (var j:int = 0; j < textos.length; j++) 
					{
						container.addElement( ImpressaoUtils.getLabel( textos[j], 100, true, false, 'left', legendaSize, legendaCor ) ) ;
					}
				}
			}
		}
		
		public static function criaAtividadesFisicas( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766 ):void
		{
			var af:AtividadeFisica = c.atividadeFisica ;
			if( af ){
				if( removeAll ) container.removeAllElements();
				
				var txtNivel:String = '' ;
				switch(af.nivel)
				{
					case AtividadeFisica.MUITO_ATIVO: 	txtNivel += "muito ativo"; 	break;
					case AtividadeFisica.ATIVO: 		txtNivel += "ativo"; 		break;
					case AtividadeFisica.POUCO_ATIVO: 	txtNivel += "pouco ativo"; 	break;
					case AtividadeFisica.SEDENTARIO: 	txtNivel += "sedentário"; 	break;
				}
				
				container.addElement( ImpressaoUtils.getUmaColuna( "Nível de atividade física: ", txtNivel, textoSize, cor) );
				container.addElement( ImpressaoUtils.getTresColunas("ATIVIDADE FÍSICA", "DIAS DA SEMANA", "HORÁRIO", textoSize, cor) );
				
				for (var i:int = 0; i < af.atividades.length; i++) 
				{
					var at:Atividade = af.atividades[i] ;
					container.addElement( ImpressaoUtils.getTresColunas(at.nome, at.dias, at.horario, textoSize, cor) );
				}
				
				container.addElement( ImpressaoUtils.getUmaColuna( "Observações: ", af.observacao, textoSize, cor) );
			}
		}
		
		public static function criaDadosAlimentares( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766  ):void
		{
			var da:DadosAlimentares = c.dadosAlimentares ;
			if( da ){
				if( removeAll ) container.removeAllElements();
				container.addElement( ImpressaoUtils.getTresColunas( 'REFEIÇÃO/HORARIO', 'ALIMENTO', 'QUANTIDADE', textoSize, cor ) ) ;
				
				for (var i:int = 0; i < da.refeicoes.length; i++) 
				{
					var r:Refeicao = da.refeicoes[i] ;
					container.addElement( ImpressaoUtils.getTresColunas( r.nome, r.alimentos, r.quantidades, textoSize, cor ) ) ;
				}
				
				container.addElement( ImpressaoUtils.getUmaColuna( 'QUANTIDADE DE ÁGUA POR DIA', da.qtdeAgua, textoSize, cor ) ) ;
				container.addElement( ImpressaoUtils.getUmaColuna( 'FUNCIONALIDADE INTESTINAL', da.funcionamentoIntestinal, textoSize, cor ) ) ;
				container.addElement( ImpressaoUtils.getUmaColuna( 'PREFERÊNCIAS ALIMENTARES', da.preferenciasAlimentares, textoSize, cor ) ) ;
				container.addElement( ImpressaoUtils.getUmaColuna( 'AVERSÕES ALIMENTARES', da.aversoesAlimentares, textoSize, cor ) ) ;
				container.addElement( ImpressaoUtils.getUmaColuna( 'OUTRAS INFORMAÇÕES / OBSERVAÇÕES', da.observacoes, textoSize, cor ) ) ;
			}
		}
		
		public static function criaExamesBioquimicos( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766  ):void
		{
			var eb:ExameBioquimico = c.exameBioquimico ;
			if( eb ){
				if( removeAll ) container.removeAllElements();
				container.addElement( ImpressaoUtils.getTresColunas( 'EXAME', 'REFERÊNCIA', General.getFormattedDate( eb.dataDoExame ), textoSize, cor ) ) ;
				
				for (var i:int = 0; i < eb.exames.length; i++) 
				{
					var e:ExameAdicional = eb.exames[i] ;
					container.addElement( ImpressaoUtils.getTresColunas( e.nome, e.referencia, e.valor, textoSize, cor ) ) ;
				}
			}
		}
		
		public static function criaMAN( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766 ):void
		{
			var man:MAN = c.man ;
			if( man ){
				if( removeAll ) container.removeAllElements();
				
				var p:Number = man.pontuacaoTriagem ;
				var resultado:String = '' ;
				
				if( p < 8 ){
					resultado += 'DESNUTRIDO' ;
				} else if( p >= 8 && p < 12 ){
					resultado += 'SOB RISCO DE DESNUTRIÇÃO' ;
				} else {
					resultado += 'NORMAL' ;
				}
				
				container.addElement( ImpressaoUtils.getTresColunas("Pontos da triagem:", "(subtotal máximo de 14 pontos)", sPontos(man.pontuacaoTriagem), textoSize, cor, false ) );
				container.addElement( ImpressaoUtils.getDuasColunas("Estado nutricional:", man.estadoNutricionalTriagem, textoSize, cor ) );
				
				p = man.pontuacaoGlobal ;
				var resultadoGlobal:String = '' ;
				
				if( p < 8 ){
					resultadoGlobal += 'DESNUTRIDO' ;
				} else if( p >= 8 && p < 12 ){
					resultadoGlobal += 'SOB RISCO DE DESNUTRIÇÃO' ;
				} else {
					resultadoGlobal += 'NORMAL' ;
				}
				
				container.addElement( ImpressaoUtils.getTresColunas("Avaliação global:", "(subtotal máximo de 16 pontos)", sPontos(man.pontuacaoTriagem), textoSize, cor, false ) );
				container.addElement( ImpressaoUtils.getDuasColunas("Pontos da triagem:", sPontos(man.pontuacaoTriagem), textoSize, cor, false ) );
				container.addElement( ImpressaoUtils.getTresColunas("Pontos total:", "(máximo 30 pontos)", sPontos( man.pontuacaoGlobal + man.pontuacaoTriagem), textoSize, cor ) );
				container.addElement( ImpressaoUtils.getDuasColunas("Estado nutricional:", man.estadoNutricionalGlobal, textoSize, cor, false ) );
			}
		}
		
		public static function criaTMB( c:Consulta, container:VGroup, removeAll:Boolean = true, textoSize:uint = 10, cor:uint = 0x475766  ):void
		{
			var r:ResumoConsulta = c.resumo ;
			if( r ){
				container.addElement( ImpressaoUtils.getDuasColunas( 'Metabolismo Basal:', r.metabolismoBasal.toFixed(2) + " kcal/dia", textoSize, cor));
				if( r.necessidadeEnergetica ){
					container.addElement( ImpressaoUtils.getDuasColunas( 'Necessidade energética:', r.necessidadeEnergetica.toFixed(2) + " kcal/dia", textoSize, cor));
					
					if( c.semanaGestacional > 12 ){
						container.addElement( ImpressaoUtils.getDuasColunas( 'Necessidade energética gestacional:', r.necessidadeEnergeticaGestacional.toFixed(2) + " kcal/dia", textoSize, cor));
					} else {
						if( c.semanaGestacional > 0 ){
							container.addElement( ImpressaoUtils.getDuasColunas( 'Necessidade energética gestacional:', r.necessidadeEnergeticaGestacional.toFixed(2) + " kcal/dia  (menos de 12 semanas de gestação)", textoSize, cor));
						}
					}
				}
			}
		}
		
		public static function getUmaColuna( v1:String, v2:String, tamanho:uint = 10, cor:uint = 0x475766, addRule:Boolean = true ):Group
		{
			var vg:VGroup = new VGroup();
			vg.percentWidth = 100 ;
			vg.addElement( ImpressaoUtils.getLabel( v1, 50, true, true, 'left', tamanho, cor ) );
			vg.addElement( ImpressaoUtils.getLabel( v2, 50, true, false, 'left', tamanho, cor ) );
			if( addRule ) vg.addElement( ImpressaoUtils.getRule() );
			
			return vg;
		}
		
		public static function getDuasColunas( v1:String, v2:String, tamanho:uint = 10, cor:uint = 0x475766, addRule:Boolean = true ):Group
		{
			var hg:HGroup = new HGroup();
			hg.gap = 0;
			hg.percentWidth = 100 ;
			hg.addElement( ImpressaoUtils.getLabel( v1, 50, true, true, 'left', tamanho, cor ) );
			hg.addElement( ImpressaoUtils.getLabel( v2, 50, true, false, 'right', tamanho, cor ) );
			
			var vg:VGroup = new VGroup();
			vg.percentWidth = 100 ;
			vg.addElement(hg);
			if( addRule )vg.addElement( ImpressaoUtils.getRule() );
			
			return vg;
		}
		
		public static function getTresColunas( v1:String, v2:String, v3:String, tamanho:uint = 10, cor:uint = 0x475766, addRule:Boolean = true ):VGroup
		{
			var hg:HGroup = new HGroup();
			hg.gap = 0;
			hg.percentWidth = 100 ;
			hg.addElement( ImpressaoUtils.getLabel( v1, 34, true, true, 'left', tamanho, cor ) );
			hg.addElement( ImpressaoUtils.getLabel( v2, 33, true, false, 'center', tamanho, cor ) );
			hg.addElement( ImpressaoUtils.getLabel( v3, 33, true, false, 'right', tamanho, cor ) );
			
			var vg:VGroup = new VGroup();
			vg.percentWidth = 100 ;
			vg.addElement(hg);
			if( addRule ) vg.addElement( ImpressaoUtils.getRule() );
			
			return vg;
		}
		
		public static function getLabel(texto:String, w:Number, isPercent:Boolean = true, isBold:Boolean = false, align:String = 'left', tamanhoText:uint = 10, cor:uint = 0x475766):Label
		{
			var lab:Label = new Label();
			lab.setStyle('textAlign', align);
			lab.setStyle('fontSize', tamanhoText);
			lab.setStyle('color', cor);
			
			if( isBold ){ 
				lab.styleName = 'bold' ;
			} else {
				lab.setStyle('paddingTop', 3);
			}
			
			if( isPercent ){
				lab.percentWidth = w ;
			} else {
				lab.width = w ;
			}
			
			lab.text = texto ;
			
			return lab
		}
		
		public static function getRule():HRule
		{
			var rule:HRule = new HRule();
			rule.height = 1 ;
			rule.percentWidth = 100 ; 
			return rule ;
		}
		
		public static function sPontos(p:int):String
		{
			return p + ( p > 1 ? ' pontos' : ' ponto') ;
		}
		
		public function ImpressaoUtils()
		{
			
		}
	}
}