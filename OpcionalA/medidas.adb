


package body Medidas is
	procedure Set_Distancia (Distance : in Distance_Samples_Type) is
		begin
			Distancia := Distance;
	end Set_Distancia;

	function Get_Distancia return Distance_Samples_Type is
		begin
			return Distancia;
	end Get_Distancia;

	procedure Set_Speed (Speed : in Speed_Samples_Type) is
		begin
			Velocidad := Speed;
	end Set_Speed;

	function Get_Speed return Speed_Samples_Type is
		begin
			return Velocidad;
	end Get_Speed;

	procedure Set_HeadPosition(Head : in HeadPosition_Samples_Type) is
		begin
			Cabeza := Head;
	end Set_HeadPosition;

	function Get_HeadPosition return HeadPosition_Samples_Type is
		begin
			return Cabeza;
	end Get_HeadPosition;

	procedure Set_Volante (Wheel: in Steering_Samples_Type)is
		begin
			Volante:= Wheel;
	end Set_Volante;
      
	function Get_Volante return Steering_Samples_Type is
		begin
			return Volante;
	end Get_Volante;

begin
	null;
end Medidas;
