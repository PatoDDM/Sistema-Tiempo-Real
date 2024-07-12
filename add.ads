with Tools; use Tools;
with Devices; use Devices;

package add is

	protected Medidas is
		procedure Set_Distancia (Distance : in Distance_Samples_Type);
		function Get_Distancia return Distance_Samples_Type;
    
		procedure Set_Speed (Speed : in Speed_Samples_Type);
		function Get_Speed return Speed_Samples_Type;
    
		procedure Set_HeadPosition (Head : in HeadPosition_Samples_Type);
		function Get_HeadPosition return HeadPosition_Samples_Type;
    
		procedure Set_Volante (Wheel: in Steering_Samples_Type);
		function Get_Volante return Steering_Samples_Type;
	private
		Volante: Steering_Samples_Type;
		Cabeza : HeadPosition_Samples_Type;
		Distancia: Distance_Samples_Type;
		Velocidad: Speed_Samples_Type;
	end Medidas;
	
	
	protected Sintomas is
		procedure Control_CabezaX (Cabeza : in HeadPosition_Samples_Type; seguidos : in out Integer);
		procedure Control_CabezaY (Cabeza : in HeadPosition_Samples_Type; seguidos : in out Integer ; Dir_Volante: in Steering_Samples_Type);
		procedure Control_Distancia (distancia : in Distance_Samples_Type; velocidad : in Speed_Samples_type);
		procedure Control_Volante (Current_Volante : in Steering_Samples_type; velocidad : in Speed_Samples_type ; seguidos : in out Integer);
		
		function Get_Riesgo_CabezaX return Boolean;
		function Get_Riesgo_CabezaY return Boolean;
		function Get_Riesgo_Distancia return Integer;
		function Get_Riesgo_Volante return Boolean;
	private
		Riesgo_CabezaX : Boolean;
		Riesgo_CabezaY : Boolean;
		Riesgo_Distancia : Integer;
		Riesgo_Volante : Boolean;
		Last_Volante : Steering_Samples_type; 
	end Sintomas;
	
  procedure Background;
  
end add;

