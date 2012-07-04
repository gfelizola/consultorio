package app.enums
{
	import app.view.*;
	import app.vo.VoInfoArea;

	public class EAreas
	{
		public static const LOGIN:VoInfoArea 					= new VoInfoArea("LOGIN", 				app.view.Login );
		public static const CADASTRO:VoInfoArea 				= new VoInfoArea("CADASTRO", 			app.view.Cadastro );
		public static const HOME:VoInfoArea 					= new VoInfoArea("HOME", 				app.view.Home );
		public static const MEUS_PACIENTES:VoInfoArea 			= new VoInfoArea("MEUS_PACIENTES", 		app.view.Pacientes );
		public static const CADASTRO_PACIENTE:VoInfoArea 		= new VoInfoArea("CADASTRO_PACIENTE", 	app.view.CadastroPaciente );
		public static const CONSULTA:VoInfoArea 				= new VoInfoArea("CONSULTA", 			app.view.Consulta, 			false );
		public static const REQUISITOS_SISTEMA:VoInfoArea 		= new VoInfoArea("REQUISITOS_SISTEMA", 	app.view.Requisitos );
		public static const MANUAL_DE_USO:VoInfoArea 			= new VoInfoArea("MANUAL_DE_USO", 		app.view.ManualDeUso );
		
	}
}