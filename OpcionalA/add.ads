with Tools; use Tools;
with Devices; use Devices;

package add is

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
	
	
  procedure Background;
  
end add;

