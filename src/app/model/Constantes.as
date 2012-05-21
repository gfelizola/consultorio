package app.model
{
	import app.util.General;
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateBase;
	
	import nz.co.codec.flexorm.EntityErrorEvent;
	import nz.co.codec.flexorm.EntityEvent;
	import nz.co.codec.flexorm.EntityIntrospector;
	import nz.co.codec.flexorm.EntityManager;
	import nz.co.codec.flexorm.EntityManagerBase;
	import nz.co.codec.flexorm.criteria.Criteria;
	import nz.co.codec.flexorm.criteria.Sort;
	import nz.co.codec.flexorm.metamodel.Entity;
	
	import org.casalib.util.ArrayUtil;

	public class Constantes
	{
		//PUBLICS
		[Bindable]
		public static var estadosCivis:ArrayCollection;
		
		[Bindable]
		public static var tiposAtendimentos:ArrayCollection;
		
		[Bindable]
		public static var patologias:ArrayCollection;
		
		[Bindable]
		public static var historicos:ArrayCollection;
		
		[Bindable]
		public static var redesSociais:ArrayCollection;
		
		[Bindable]
		public static var exames:ArrayCollection;
		
		public static var estados:ArrayCollection = new ArrayCollection( new Array(
			'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'DF', 
			'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 
			'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SE', 
			'SP', 'TO'
		));
		
		//PRIVATES
		private static var _estadosCivis:Array = new Array('Solteiro', 'Casado', 'Divorciado', 'Viúvo', 'União estável' );
		
		private static var _tiposAtendimentos:Array = new Array('Particular', 'Convênio');
		
		private static var _patologias:Array = new Array('Alergia alimentar', 'Anemia falciforme', 'Anemia ferropriva', 'Anorexia nervosa', 'Ansiedade', 'Apneia do sono', 'Artrite reumatóide', 'Artrose', 'Ascite', 'Asma', 'Bronquite', 'Bulimia', 'Câncer', 'Depressão', 'Desnutrição', 'Diabetes gestacional', 'Diabetes mellitus tipo I', 'Diabetes mellitus tipo II', 'Diarréia', 'Diverticulite', 'Doença arterial coronariana', 'Doença celíaca', 'Doença de Chron', 'Doença hemorroidária (hemorróida)', 'Doença inflamatória intestinal', 'Doença pulmonar obstrutiva crônica', 'Doença renal', 'Enxaqueca (Cefaléia)', 'Epilepsia', 'Erro inato do metabolismo', 'Esclerose múltipla', 'Escorbuto', 'Esofagite', 'Esteatose hepática alcoólica', 'Esteatose hepática não alcóolica', 'Fenilcetonúria', 'Fibrose cística', 'Gastrite', 'Hipercolesterolemia', 'Hipertensão arterial', 'Hipertiroidismo', 'Hipertrigliceridemia', 'Hiperuricemia (Gota)', 'Hipotiroidismo', 'Lúpus eritematoso sistêmico', 'Obesidade', 'Obstipação intestinal', 'Osteoartrite', 'Osteopenia', 'Osteoporose', 'Pancreatite', 'Pica', 'Raquitismo', 'Refluxo gastroesofagico', 'Resistência a insulina', 'Rinite alérgica', 'Síndrome da Imunodeficiência adquirida (AIDS/ SIDA)', 'Síndrome do intestino irritável', 'Síndrome metabólica', 'Transtornos alimentares', 'Ulcera');
		
		private static var _historicos:Array = _patologias.concat([]) ;
		
		private static var _redesSociais:Array = new Array(
			{ nome: 'Twitter', icone: 'Twitter.png' },
			{ nome: 'Facebook', icone: 'Facebook.png' },
			{ nome: 'LinkedIn', icone: 'LinkedIn.png' },
			{ nome: 'MySpace', icone: 'MySpace.png' },
			{ nome: 'Orkut', icone: 'Orkut.png' },
			{ nome: 'Windows Live - MSN', icone: 'WindowsLive.png' }
		);
		
		private static var _exames:Array = new Array(
			{ nome:'Glicemia de jejum', referencia:'Valor de referência: 75 - 99 mg/Dl', ativo:true },
			{ nome:'Hemoglobina glicosilada', referencia:'Valor de referência: 4.0 a 6.0%', ativo:true },
			{ nome:'Insulina (livre, no soro)', referencia:'Valor de referência:  5 a 35 µU/mL.', ativo:true },
			{ nome:'Colesterol total', referencia:'De 2 a 19 ANOS:\nDesejável: Menor que 170 mg/dl\nAceitável: 170 a 199 mg/dl \nElevado: Maior ou igual a 200 mg/dl\n\nAdultos\nÓtimo: Menor que 200 mg/dL\nLimítrofe: 200 a 239 mg/dl\nElevado: Maior ou igual a 240 mg/dl', ativo:true },
			{ nome:'Colesterol HDL', referencia:'De 2 a 9 anos:\nMaior ou igual a 40 mg/dL\n\nDe 10 a 19 anos:\nMaior ou igual a 35 mg/dL\n\nAcima de 19 anos:\nHomens:  Maior ou igual a 40 mg/dL\nMulheres: Maior ou igual a 50 mg/dL', ativo:true },
			{ nome:'Colesterol LDL', referencia:'De 2 a 19 anos:\nDesejável: inferior a 110 mg/dL\nLimítrofe: de 110 a 129 mg/dL\nElevado : superior a 129 mg/dL\n\nAcima de 19 anos:\nÓtimo: inferior a 100 mg/dL \nSub-ótimo: de 100 a 129 mg/dL\nLimítrofe: de 130 a 159 mg/dL\nElevado : de 160 a 189 mg/dL\nMuito elevado: superior a 189 mg/dL', ativo:true },
			{ nome:'Colesterol VLDL', referencia:'De 2 a 9 anos:\nDesejável: até 20 mg/dL\n\nDe 10 a 19 anos:\nDesejável: até 26 mg/dL\n\nAcima de 19 anos:\nNormal: inferior a 30 mg/dL', ativo:true },
			{ nome:'Triglicerídeos', referencia:'De 2 a 9 anos:\nDesejável: até 100 mg/dL\n\nDe 10 a 19 anos:\nDesejável: até 130 mg/dL\n\nAcima de 19 anos:\nNormal: inferior a 150 mg/dL\nLimítrofe: de 150 a 199 mg/dL\nElevado : de 200 a 499 mg/dL\nMuito elevado: superior a 499 mg/dL', ativo:true },
			{ nome:'Uréia', referencia:'De 26 a 43 g/24 horas, dieta dependente', ativo:true },
			{ nome:'Creatinina (soro)', referencia:'Recém-nascido: 0,3 a 1,0 mg/dL.\nAté 6 anos : 0,3 a 0,7 mg/dL.\nDe 7 a 12 anos : 0,5 a 1,0 mg/dL;\n> 12 anos:\nsexo masculino: 0,7 a 1,3 mg/dL;\nsexo feminino : 0,6 a 1,1 mg/dL.', ativo:true },
			{ nome:'Acido úrico (soro)', referencia:'Sexo feminino: 2,4 a 5,7 mg/dL;\nSexo masculino: 3,4 a 7,0 mg/dL.', ativo:true }
		);
		
		private static var tipos:Array 					= [ EstadoCivil, TipoAtendimento, Patologia, RedeSocial, Exame, Historico ];
		private static var full:Array 					= [ _estadosCivis, _tiposAtendimentos, _patologias, _redesSociais, _exames, _historicos ] ;
		
		private static var novosNessaVersao:Array 		= [ null, null, null, null, null, null ];
		private static var atualizadosNessaVersao:Array = [ null, null, null, null, null, null ];
		
		
		/* --------------- SE PRECISAR ATUALIZAR CONSTANTES - ADICINAR ITENS MODIFICADOS/NOVOS NOS VETORES COMO MOSTRADO ABAIXO.
		private static var novosNessaVersao:Array = [
			null, null, null, [ redesSociais[5] ], null
		];
		
		private static var atualizadosNessaVersao:Array = [
			null, [ tiposAtendimentos[0] ], [ patologias[0] ], null, [ exames[8], exames[10] ]
		];
		*/
		private static var objetosCarregados:Boolean = false ;
		
		public static function verificarValoresPadrao():void
		{
			var i:int = 0
			var versaoAtual:String = General.getAppVersion();
			
			var c:Criteria = DB.em.createCriteria(Versao);
			c.addSort("dataAtualizacao", Sort.DESC);
			
			var ultimaVersao:Versao = DB.em.fetchCriteriaFirstResult(c) as Versao;
			
			if( ultimaVersao == null ) //primeira instalação - adiciona todas as contastantes
			{
				trace("primeira instalação");
				for (i = 0; i < tipos.length; i++) 
				{
					adicionaItens( full[i], tipos[i] );
				}
				
				atualizaVersao(versaoAtual);
			} else {
				if( versaoAtual != ultimaVersao.nome ) //atualização de versão
				{
					//adiciona novos
					for (i = 0; i < tipos.length; i++) 
					{
						//adiciona novos
						if( novosNessaVersao[i] ) adicionaItens( novosNessaVersao[i], tipos[i] );
						
						//atualiza antigos
						if( atualizadosNessaVersao[i] )
						{
							for (var j:int = 0; j < atualizadosNessaVersao[i].length; j++) 
							{
								c = DB.em.createCriteria( tipos[i] );
								var comp:String = atualizadosNessaVersao[i][j] is String ? atualizadosNessaVersao[i][j] : atualizadosNessaVersao[i][j].nome ;
								c.addLikeCondition("nome", comp );
								
								var encontrado:Object = DB.em.fetchCriteriaFirstResult(c);
								
								var item:Object = montaObjeto( atualizadosNessaVersao[i][j], tipos[i] );
								if( encontrado ) item.id = encontrado.id ;
								
								DB.em.save(item);
							}
						}
					}
					
					getObjectFromDatabase();
					/*
					var usuario:Usuario = new Usuario();
					usuario.nome = "Tribo" ;
					usuario.sobrenome = "Interactive" ;
					usuario.login = "tribo" ;
					usuario.senha = "tribo" ;
					usuario.CRN = "11111" ;
					usuario.regional = "3" ;
					usuario.endereco = "Rua Luigi Galvani, 72" ;
					usuario.complemento = "andar 13" ;
					usuario.bairro = "Brooklin" ;
					usuario.cidade = "São Paulo" ;
					usuario.estado = "SP" ;
					usuario.telefone = "(11) 5501-1351" ;
					usuario.site = "http://www.tribointeractive.com.br" ;
					usuario.email = "contato@tribointeractive.com.br" ;
					
					var twitter:RedeSocial = getByNome( _redesSociais[0].nome, redesSociais ) as RedeSocial;
					
					var urs1:UsuarioRedeSocial = new UsuarioRedeSocial();
					urs1.endereco = "@tribo";
					urs1.rede = twitter ;
					urs1.usuario = usuario ;
					
					usuario.redesSociais.addItem(urs1);
					
					DB.em.save(usuario);
					*/
					atualizaVersao(versaoAtual);
					
					trace("aplicação atualizada para a versao:", versaoAtual);
				}
				else
				{
					trace("aplicação atualizada");
				}
				
			}
			
			getObjectFromDatabase();
		}
		
		private static function getObjectFromDatabase():void
		{
			//REMOVER QUANDO A APLICAÇÃO ESTIVER COMPLETA USANDO TODAS AS MODELS
			adicionarReferencias(); 
			
			if( ! objetosCarregados )
			{
				var c:Criteria = DB.em.createCriteria(RedeSocial);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				redesSociais = DB.em.fetchCriteria(c);
				
				c = DB.em.createCriteria(EstadoCivil);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				estadosCivis = DB.em.fetchCriteria(c);
				
				c = DB.em.createCriteria(TipoAtendimento);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				tiposAtendimentos = DB.em.fetchCriteria(c);
				
				c = DB.em.createCriteria(Patologia);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				patologias = DB.em.fetchCriteria(c);
				
				c = DB.em.createCriteria(Exame);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				exames = DB.em.fetchCriteria(c);
				
				c = DB.em.createCriteria(Historico);
				c.addSort("nome", Sort.ASC);
				c.addEqualsCondition("ativo", true);
				historicos = DB.em.fetchCriteria(c);
				
				var estadosSort:Array = estados.source ;
				estadosSort.sort();
				estados = new ArrayCollection( estadosSort );
				
				objetosCarregados = true ;
			}
		}
		
		private static function adicionarReferencias():void
		{
			var ts:Array = new Array( Antropometria, Atividade, AtividadeFisica, Consulta, DadosAlimentares, EstadoCivil, Exame, ExameBioquimico, Historico, MAN, Paciente, Patologia, Refeicao, RedeSocial, TipoAtendimento, Usuario, UsuarioRedeSocial, Versao );
		}
		
		private static function atualizaVersao(v:String):void
		{
			var novaVersao:Versao = new Versao();
			novaVersao.dataAtualizacao = new Date();
			novaVersao.nome = v ;
			
			DB.em.save(novaVersao);
		}
		
		private static function adicionaItens( a:Array, c:Class ):void
		{
			if(a == null) return ;
			if(a.length == 0) return;
			
			for (var i:int = 0; i < a.length; i++) 
			{
				var item:Object = montaObjeto(a[i], c);
				DB.em.save(item);
			}
		}
		
		private static function montaObjeto( ref:Object, c:Class ):*
		{
			var item:Object = new c();
			if( ref is String )
			{
				item.nome = ref ;
				item.ativo = true ;
			}
			else
			{
				for (var s:String in ref) 
				{
					item[s] = ref[s];
				}
				
				if( item.ativo == undefined ) item.ativo = true ;
			}
			
			return item;
		}
		
		private static function getByNome( nome:String, where:ArrayCollection ):Object
		{
			for (var i:int = 0; i < where.length; i++) 
			{
				if( where[i].nome == nome ) return where[i] ;
			}
			
			return null ;
		}
		
	}
}