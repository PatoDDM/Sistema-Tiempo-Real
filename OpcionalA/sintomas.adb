with Ada.Text_IO;use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with System; use System;

with Devices; use Devices;
with Tools; use Tools;

package body Sintomas is

	procedure Control_CabezaX (Cabeza : in HeadPosition_Samples_Type; seguidos : in out Integer) is
		begin
			if cabeza(x) > 30 or cabeza(x) < -30 then
				seguidos := seguidos + 1;
				if seguidos > 1 then
					Starting_Notice("-----CABEZA INCLINADA");
					Riesgo_CabezaX := True;
				else
					Riesgo_CabezaX := False;
				end if;
			else
				seguidos := 0;
				Riesgo_CabezaX := False;
			end if;
	end Control_CabezaX;
		
	procedure Control_CabezaY (Cabeza : in HeadPosition_Samples_Type; seguidos : in out Integer; Dir_Volante: Steering_Samples_Type) is
		begin
			if Cabeza(y) > 30 or Cabeza(y) < -30 then
				Seguidos := seguidos + 1;
				if Seguidos > 1 then
					if (Cabeza(y) > 30 and Dir_volante > 0) or (Cabeza(y) < -30 and Dir_Volante < 0) then
						Riesgo_CabezaY := False;
					else
						Starting_Notice("-----CABEZA INCLINADA");
						Riesgo_CabezaY:=True;
					end if;
			end if;
			else
				seguidos := 0;
				Riesgo_CabezaY:=False;
			end if;
	end Control_CabezaY;
	
	procedure Control_Distancia (distancia : in Distance_Samples_Type; velocidad : in Speed_Samples_type) is
		dist_recomendada : Distance_Samples_Type;
		begin
			dist_recomendada := Distance_Samples_Type ((velocidad/10) ** 2);
			if distancia < dist_recomendada / Distance_Samples_Type(3) then
				Starting_Notice("-----PELIGRO COLISION");
				Riesgo_Distancia:=3;
			elsif distancia < dist_recomendada / Distance_Samples_Type(2) then
				Starting_Notice("-----DISTANCIA IMPRUDENTE");
				Riesgo_Distancia:=2;
			elsif distancia < dist_recomendada then
				Starting_Notice("-----DISTANCIA INSEGURA");
				Riesgo_Distancia:=1;
			else
			Riesgo_Distancia := 0;
			end if;
	end Control_Distancia;
	
	procedure Control_Volante (Current_Volante : in Steering_Samples_type; velocidad : in Speed_Samples_type ; seguidos : in out Integer) is
		
		begin
			if seguidos < 2 then
				seguidos := seguidos + 1;
				Last_Volante := Current_Volante;
			else
				if abs(Current_Volante) - abs(Last_Volante) <= -20 or abs(Current_Volante) - abs(Last_Volante) >= 20 then
					Starting_Notice("-----VOLANTAZO");
					Riesgo_Volante:=True; 
				else
					Riesgo_Volante:=False;
				end if;
				Last_Volante := Current_Volante;
			end if;
	end Control_Volante;

	function Get_Riesgo_CabezaY return Boolean is
		begin
			return Riesgo_CabezaY;
	end Get_Riesgo_CabezaY;
	
	function Get_Riesgo_CabezaX return Boolean is
		begin
			return Riesgo_CabezaX;
	end Get_Riesgo_CabezaX;
	
	function Get_Riesgo_Distancia return Integer is
		begin
			return Riesgo_Distancia;
	end Get_Riesgo_Distancia;
	
	function Get_Riesgo_Volante return Boolean is
		begin
			return Riesgo_Volante;
	end Get_Riesgo_Volante;

begin
	null;
end Sintomas;
