
with Devices; use Devices;

package Sintomas is

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
