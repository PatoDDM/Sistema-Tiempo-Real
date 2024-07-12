
with Tools; use Tools;
with Devices; use Devices;

package Medidas is
	
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
