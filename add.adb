
with Ada.Text_IO;use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with System; use System;

with Tools; use Tools;
with Devices; use Devices;

-- Packages needed to generate pulse interrupts       
-- with Ada.Interrupts.Names;
-- with Pulse_Interrupt; use Pulse_Interrupt;

package body add is

    ----------------------------------------------------------------------
    ------------- procedure exported 
    ----------------------------------------------------------------------
   procedure Background is
   begin
     loop
       null;
     end loop;
   end Background;
    ----------------------------------------------------------------------

    -----------------------------------------------------------------------
    ------------- protected body
    -----------------------------------------------------------------------
	protected body Medidas is
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
	end Medidas;



	protected body Sintomas is
		procedure Control_CabezaX (Cabeza : in HeadPosition_Samples_Type; seguidos : in out Integer) is
			begin
				if cabeza(x) > 30 or cabeza(x) < -30 then
					seguidos := seguidos + 1;
					if seguidos > 1 then
						New_Line;
						Put_Line("-----CABEZA INCLINADA");
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
							New_Line;
							Put_Line("-----CABEZA INCLINADA");
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
					New_Line;
					Put_Line("-----PELIGRO COLISION");
					Riesgo_Distancia:=3;
				elsif distancia < dist_recomendada / Distance_Samples_Type(2) then
					New_Line;
					Put_Line("-----DISTANCIA IMPRUDENTE");
					Riesgo_Distancia:=2;
				elsif distancia < dist_recomendada then
					New_Line;
					Put_Line("-----DISTANCIA INSEGURA");
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
						New_Line;
						Put_Line("-----VOLANTAZO");
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
		
	end Sintomas;

    -----------------------------------------------------------------------
    ------------- declaration of tasks 
    -----------------------------------------------------------------------

	
	task Cabeza_Inclinada is
		pragma priority (12);
	end Cabeza_Inclinada;
    
	task Distancia_Segura is
		pragma priority (14);
	end Distancia_Segura;
    
	task Giro_Volante is
		pragma priority (13);
	end Giro_volante;
	
	task Riesgos is 
		pragma priority (15);
	end Riesgos;
	
	task Display is
		pragma priority (11);
	end Display;




    -----------------------------------------------------------------------
    ------------- body of tasks 
    -----------------------------------------------------------------------
	
	task body Cabeza_Inclinada is
		cabeza : HeadPosition_Samples_Type;
		volante : Steering_Samples_Type;
		espera : Time:=Big_Bang+Milliseconds(400);
		seguidoX : Integer := 0;
		seguidoY : Integer := 0;
		begin
			loop
				Starting_Notice("Control_Cabeza");
				Reading_Steering(volante);
				Reading_HeadPosition(cabeza);
				Medidas.Set_Volante(volante);
				Medidas.Set_HeadPosition(cabeza);
				Sintomas.Control_CabezaX(Medidas.Get_HeadPosition, seguidoX);
				Sintomas.Control_CabezaY(Medidas.Get_HeadPosition, seguidoY, Medidas.Get_Volante);
				Finishing_Notice("Control_Cabeza");
				delay until espera;
				espera := Clock + Milliseconds(400);
			end loop;
	end Cabeza_Inclinada;


	task body Distancia_Segura is
		velocidad : Speed_Samples_Type;
		distancia : Distance_Samples_Type;
		espera : Time:=Big_Bang+Milliseconds(300);
		begin
			loop
				Starting_Notice("Distancia_Segura");
				Reading_Speed(velocidad);
				Reading_Distance(distancia);
				Medidas.Set_Speed(velocidad);
				Medidas.Set_Distancia(distancia);
				Sintomas.Control_Distancia(Medidas.Get_Distancia, Medidas.Get_Speed);
				Finishing_Notice("Distancia_Segura");
				delay until espera;
				espera := espera + Milliseconds(300);
			end loop;
	end Distancia_Segura;
	
	
	task body Giro_Volante is
		volante : Steering_Samples_Type;
		velocidad : Speed_Samples_Type;
		espera : Time:=Big_Bang+Milliseconds(350);
		seguidos : Integer := 1;
		begin
			loop
				Starting_Notice("Giro_Volante");
				Reading_Steering(volante);
				Reading_Speed(velocidad);
				Medidas.Set_Speed(velocidad);
				Medidas.Set_Volante(volante);
				Sintomas.Control_Volante(volante,velocidad, seguidos);
				Finishing_Notice("Giro_Volante");
				delay until espera;
				espera := espera + Milliseconds(350);
			end loop;
	end Giro_Volante;
	
	
	task body Riesgos is
		espera : Time:=Big_Bang+Milliseconds(150);
		begin
			loop
				Starting_Notice("Riesgos");
				New_Line;
				if Sintomas.Get_Riesgo_volante then
					Beep(1);
					Light(Off);
				elsif (Sintomas.Get_Riesgo_CabezaX or Sintomas.Get_Riesgo_CabezaY) and Medidas.Get_Speed > 70 then
					Beep(3);
					Light(Off);
				elsif (Sintomas.Get_Riesgo_CabezaX or Sintomas.Get_Riesgo_CabezaY) and Sintomas.Get_Riesgo_Distancia = 3 then
					Beep(5);
					Light(Off);
					Activate_Brake;
				elsif (Sintomas.Get_Riesgo_CabezaX or Sintomas.Get_Riesgo_CabezaY) then
					Beep(2);
					Light(Off);
				elsif Sintomas.Get_Riesgo_Distancia = 1 then
					Light(On);
				elsif Sintomas.Get_Riesgo_Distancia = 2 then
					Beep(4);
					Light(On);
				else
					Light(Off);
				end if;
				Finishing_Notice("Riesgos");
				delay until espera;
				espera := Clock + Milliseconds(150);
			end loop;
	end Riesgos;
	
	task body Display is
		espera : Time := Big_Bang + Milliseconds(1000);
		begin
			loop
				Starting_Notice("Display");
				Display_Distance(Medidas.Get_Distancia);
				Display_Speed(Medidas.Get_Speed);
				Finishing_Notice("Display");
				delay until espera;
				espera := Clock + Milliseconds(1000);
			end loop;
	end Display;

	begin
		Starting_Notice ("Programa Principal");
		Finishing_Notice ("Programa Principal");
end add;
