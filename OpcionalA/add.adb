with Ada.Text_IO;use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with System; use System;

with Tools; use Tools;
with Devices; use Devices;
with Sintomas; use Sintomas;
with Medidas; use Medidas;

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
				Set_Volante(volante);
				Set_HeadPosition(cabeza);
				Control_CabezaX(Medidas.Get_HeadPosition, seguidoX);
				Control_CabezaY(Medidas.Get_HeadPosition, seguidoY, Medidas.Get_Volante);
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
				Set_Speed(velocidad);
				Set_Distancia(distancia);
				Control_Distancia(Medidas.Get_Distancia, Medidas.Get_Speed);
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
				Set_Speed(velocidad);
				Set_Volante(volante);
				Control_Volante(volante,velocidad, seguidos);
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
				if Get_Riesgo_volante then
					Beep(1);
					Light(Off);
				elsif (Get_Riesgo_CabezaX or Get_Riesgo_CabezaY) and Get_Speed > 70 then
					Beep(3);
					Light(Off);
				elsif (Get_Riesgo_CabezaX or Get_Riesgo_CabezaY) and Get_Riesgo_Distancia = 3 then
					Beep(5);
					Light(Off);
					Activate_Brake;
				elsif (Get_Riesgo_CabezaX or Get_Riesgo_CabezaY) then
					Beep(2);
					Light(Off);
				elsif Get_Riesgo_Distancia = 1 then
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
