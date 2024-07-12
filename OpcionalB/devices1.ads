

with Ada.Real_Time; use Ada.Real_Time;

package devices is

    ---------------------------------------------------------------------
    ------ Access time for devices
    ---------------------------------------------------------------------
    WCET_Distance: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(12);
    WCET_Speed: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);
    WCET_HeadPosition: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(4);
    WCET_Steering: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(7);

    WCET_Eyes_Image: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
    WCET_EEG: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(18);

    WCET_Display: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(15);
    WCET_Alarm: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Light: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Automatic_Driving: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
    WCET_Brake: constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);


    ---------------------------------------------------------------------
    ------ INPUT devices interface
    ---------------------------------------------------------------------

    ---------------------------------------------------------------------
    ------ ELECTRODES --------------------------------------------------- 

    type Value_Electrode is new natural range 0..10;
    Number_Electrodes: constant integer := 10;

    type EEG_Samples_Index is new natural range 1..Number_Electrodes;
    type EEG_Samples_Type is array (EEG_Samples_Index) of Value_Electrode;


    procedure Reading_Sensors (L: out EEG_Samples_Type);
    -- It reads a sample of Electrode Sensors and returns a array of 10 values 

    ---------------------------------------------------------------------
    ------ EYES ---------------------------------------------------------

    type Eyes_Samples_Index is (left,right);
    type Eyes_Samples_Values is new natural range 0..100;
    type Eyes_Samples_Type is array (Eyes_Samples_Index) of Eyes_Samples_Values;

    procedure Reading_EyesImage (L: out Eyes_Samples_Type);
    -- It reads an image of the eyes, analyses the image and returns 
    --- the percentage of aperture (0..100) of every eye (left, right)

    ---------------------------------------------------------------------
    ------ HeadPosition -------------------------------------------------

    type HeadPosition_Samples_Index is (x,y);
    type HeadPosition_Samples_Values is new integer range -90..+90;
    type HeadPosition_Samples_Type is array (HeadPosition_Samples_Index) 
                                         of HeadPosition_Samples_Values;

    procedure Reading_HeadPosition (H: out HeadPosition_Samples_Type);
    -- It reads the head position in axis x,y and returns 
    -- the angle -90..+90 degrees 

    ---------------------------------------------------------------------
    ------ DISTANCE -----------------------------------------------------

    type Distance_Samples_Type is new natural range 0..150;

    procedure Reading_Distance (L: out Distance_Samples_Type);
    -- It reads the distance with the previous vehicle: from 0m. to 150m. 

    ---------------------------------------------------------------------
    ------ SPEED --------------------------------------------------------

    type Speed_Samples_Type is new natural range 0..200;

    procedure Reading_Speed (V: out Speed_Samples_Type);
    -- It reads the current vehicle speed: from 0m. to 200m. 

    ---------------------------------------------------------------------
    ------ STEERING WHEEL -----------------------------------------------

    type Steering_Samples_Type is new integer range -180..180;

    procedure Reading_Steering (S: out Steering_Samples_Type);
    -- It reads the current position of the steering wheel: from -180 to 180 

    ---------------------------------------------------------------------
    ------ OUTPUT devices interface  
    ---------------------------------------------------------------------

    type Values_Pulse_Rate is new float range 20.0..300.0;

    procedure Display_Pulse_Rate (P: Values_Pulse_Rate);
    -- It displays the pulse rate P

    ---------------------------------------------------------------------
    procedure Display_Electrodes_Sample (R: EEG_Samples_Type);
    -- It displays the 10 values of the electrodes sample 

    --------------------------------------------------------------------
    procedure Display_Eyes_Sample (R: Eyes_Samples_Type);
    -- It displays the values of eyes aperture (left and right) 

    ---------------------------------------------------------------------
    procedure Display_Distance (D: Distance_Samples_Type);
    -- It displays the distance D

    ---------------------------------------------------------------------
    procedure Display_Speed (V: Speed_Samples_Type);
    -- It displays the speed V

    ---------------------------------------------------------------------
    procedure Display_Steering (S: Steering_Samples_Type);
    -- It displays the steering wheel position S

    --------------------------------------------------------------------
    procedure Display_HeadPosition_Sample (H: HeadPosition_Samples_Type);
    -- It displays the angle of the head position in both axis (x and y) 

    ---------------------------------------------------------------------
    procedure Display_Cronometro (Origen: Ada.Real_Time.Time; Hora: Ada.Real_Time.Time);
    -- It displays a chronometer 

    ---------------------------------------------------------------------
    Type Volume is new integer range 1..5; 
    procedure Beep (v: Volume); 
    -- It beeps with a volume "v" 

    ---------------------------------------------------------------------
    type Light_States is (On, Off);
    procedure Light (E: Light_States);
    -- It turns ON/OFF the light 

    ---------------------------------------------------------------------
    procedure Activate_Automatic_Driving;
    -- It activates the automatic driving system 
	
	---------------------------------------------------------------------
	procedure Activate_Brake;
	-- It activates the brake 


    ---------------------------------------------------------------------
    ------ SCENARIO  
    ---------------------------------------------------------------------

    ---------------------------------------------------------------------
    ------ SPEED --------------------------------------------------------

    cantidad_datos_Velocidad: constant := 100;
    type Indice_Secuencia_Velocidad is mod cantidad_datos_Velocidad;
    type tipo_Secuencia_Velocidad is array (Indice_Secuencia_Velocidad) of Speed_Samples_Type;

    Speed_Simulation: tipo_Secuencia_Velocidad :=
                 ( 62,60,60,65,70,   -- 1 muestra cada 100ms.
                   70,75,75,80,80,   -- 1s.
 
                   85,85,90,90,90, 
                   95,95,100,100,105,   -- 2s.

                   105,110,112,113,115, 
                   120,123,125,130,133,   -- 3s.

                   135,135,135,130,130, 
                   131,135,140,139,140,   -- 4s.

                   141,142,143,145,150, 
                   152,152,152,155,155,   -- 5s.

                   152,152,152,155,155, 
                   157,160,162,162,165,   -- 6s.
 
                   167,170,170,170,170, 
                   172,172,173,173,175,   -- 7s.

                   175,175,170,170,165, 
                   160,160,160,120,90,   -- 8s.

                   50,30,10,0,0, 
                   0,0,0,0,0,   -- 9s.

                   0,0,0,0,0, 
                   0,0,0,0,0 ); -- 10s.

    ---------------------------------------------------------------------
    ------ DISTANCE -----------------------------------------------------
    cantidad_datos_Distancia: constant := 100;
    type Indice_Secuencia_Distancia is mod cantidad_datos_Distancia;
    type tipo_Secuencia_Distancia is array (Indice_Secuencia_Distancia) of Distance_Samples_Type;

    Distance_Simulation: tipo_Secuencia_Distancia :=
                 ( 95,90,90,85,80,   -- 1 muestra cada 100ms.
                   90,90,80,85,80,   -- 1s.
 
                   80,80,80,75,70, 
                   70,70,70,65,65,   -- 2s.

                   60,60,60,55,50, 
                   55,50,50,45,40,   -- 3s.

                   30,30,30,25,25, 
                   25,25,20,20,20,   -- 4s.

                   30,30,30,30,30, 
                   25,25,25,20,20,   -- 5s.

                   25,25,25,25,30, 
                   35,40,40,35,20,   -- 6s.
 
                   15,15,15,15,10, 
                   15,15,15,15,20,   -- 7s.

                   20,20,20,15,15, 
                   10,10,5,1,0,   -- 8s.

                   0,0,0,0,0, 
                   0,0,0,0,0,   -- 9s.

                   0,0,0,0,0, 
                   0,0,0,0,0 ); -- 10s.


    ---------------------------------------------------------------------
    ------ HEAD POSITION ------------------------------------------------

    cantidad_datos_HeadPosition: constant := 100;
    type Indice_Secuencia_HeadPosition is mod cantidad_datos_HeadPosition;
    type tipo_Secuencia_HeadPosition is array (Indice_Secuencia_HeadPosition) 
                                             of HeadPosition_Samples_Type;

    HeadPosition_Simulation: tipo_Secuencia_HeadPosition :=
                ((+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  -- 1 muestra cada 100ms.
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --1s.
 
                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+01,+03),(-01,+03),(-02,+01),(+03,+00),(+01,-03),  --2s.

                 (+01,+03),(+01,+03),(+02,+01),(+03,+00),(+01,-03),  
                 (+15,+03),(+15,+03),(+15,+01),(+20,+00),(+20,-03),  --3s.

                 (+25,+03),(+25,+03),(+35,+01),(+35,+00),(+35,-03),  
                 (+37,+03),(+37,+03),(+37,+01),(+45,+00),(+45,-03),  --4s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --5s.
                  
                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --6s.
 
                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+47,+03),(+47,+01),(+46,+00),(+46,-03),  --7s.

                 (+47,+03),(+47,+03),(+47,+01),(+45,+00),(+45,-03),  
                 (+47,+03),(+49,+23),(+59,+27),(+60,+30),(+60,+30),  --8s.

                 (+60,+30),(+60,+30),(+60,+30),(+61,+30),(+60,+30),  
                 (+60,+30),(+60,+30),(+60,+30),(+60,+30),(+60,+30),  --9s.

                 (+60,+30),(+60,+30),(+60,+30),(+60,+30),(+60,+30),  
                 (+60,+30),(+60,+30),(+60,+30),(+60,+30),(+60,+30) );  --10s.

    ---------------------------------------------------------------------
    ------ STEERING WHEEL -----------------------------------------------

    cantidad_datos_Volante: constant := 100;
    type Indice_Secuencia_Volante is mod cantidad_datos_Volante;
    type tipo_Secuencia_Volante is array (Indice_Secuencia_Volante) of Steering_Samples_Type;

    Steering_Simulation: tipo_Secuencia_Volante :=
                 (  0,  0, 0,  5, 4,   -- 1 muestra cada 100ms.
                    0, -2, 0, -3, 0,   -- 1s.
 
                   10,10,10,15,10, 
                   10,10,10,15,15,   -- 2s.

                   10,10,10,05,05, 
                   04,04,06,00,00,   -- 3s.

                   00,00,00,05,05, 
                   -05,-05,00,00,10,  -- 4s.

                   11,05,00,05,05, 
                   05,10,10,10,15,    -- 5s.

                   10,05,01,-01,05, 
                   02,00,00,-02,02,   -- 6s.
 
                   00,00,01,-01,05, 
                   02,00,00,-02,02,   -- 7s.

                   10,15,20,25,30, 
                   35,40,45,50,50,   -- 8s.

                   50,50,50,50,50, 
                   50,50,50,50,50,   -- 9s.

                   50,50,50,50,50,  
                   50,50,50,50,50 ); -- 10s.

    ---------------------------------------------------------------------
    ------ EYESIMAGE ----------------------------------------------------

    cantidad_datos_EyesImage: constant := 100;
    type Indice_Secuencia_EyesImage is mod cantidad_datos_EyesImage;
    type tipo_Secuencia_EyesImage is array (Indice_Secuencia_EyesImage) of Eyes_Samples_Type;

    Eyes_Simulation: tipo_Secuencia_EyesImage :=
                ((85,85),(70,70),(85,85),(85,85),(05,05),  -- 1 muestra cada 100ms.
                 (05,05),(85,85),(20,20),(85,85),(85,85),  --1s.
 
                 (70,70),(60,60),(60,60),(40,40),(40,40),
                 (40,40),(40,40),(40,40),(40,40),(30,30),  --2s.

                 (30,30),(30,30),(40,40),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --3s.

                 (60,60),(60,60),(50,50),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --4s.

                 (30,30),(30,30),(40,40),(40,40),(40,40),
                 (50,50),(50,50),(50,50),(50,50),(50,50),  --5s.
                  
                 (20,20),(20,20),(20,20),(25,25),(25,25),
                 (20,20),(20,20),(20,20),(15,15),(15,15),  --6s.
 
                 (10,10),(10,10),(10,10),(10,10),(10,40),
                 ( 0, 0),( 0, 0),( 5, 5),( 5, 5),( 5, 5),  --7s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),  --8s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),  --9s.

                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0),
                 ( 0, 0),( 0, 0),( 0, 0),( 0, 0),( 0, 0) );  --10s.

    ---------------------------------------------------------------------
    ------ EEG ----------------------------------------------------------

    cantidad_datos_Sensores: constant := 100;
    type Indice_Secuencia_Sensores is mod cantidad_datos_Sensores;
    type tipo_Secuencia_Sensores is array (Indice_Secuencia_Sensores) of EEG_Samples_Type;

    EEG_Simulation: tipo_Secuencia_Sensores := 
      ((7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),  -- 1 muestra cada 100ms.
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),   --1s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),   --2s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --3s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --4s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),   --5s.

       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),
       (8,8,8,8,8,8,8,8,8,8),(8,8,8,8,8,8,8,8,8,8),   --6s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),
       (6,6,6,6,6,6,6,6,6,6),(6,6,6,6,6,6,6,6,6,6),   --7s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --8s.

       (1,1,1,1,1,1,1,1,1,1),(1,1,1,1,1,1,1,1,1,1),
       (1,1,1,1,1,1,1,1,1,1),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(2,2,2,2,2,2,2,2,2,2),
       (2,2,2,2,2,2,2,2,2,2),(3,3,3,3,3,3,3,3,3,3),
       (3,3,3,3,3,3,3,3,3,3),(3,3,3,3,3,3,3,3,3,3),   --9s.

       (4,4,4,4,4,4,4,4,4,4),(4,4,4,4,4,4,4,4,4,4),
       (4,4,4,4,4,4,4,4,4,4),(5,5,5,5,5,5,5,5,5,5),
       (5,5,5,5,5,5,5,5,5,5),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7),
       (7,7,7,7,7,7,7,7,7,7),(7,7,7,7,7,7,7,7,7,7) );   --10s.

end devices;



