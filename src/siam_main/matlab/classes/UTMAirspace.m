
classdef UTMAirspace < handle
    
    properties
        %Entities needed in the airspace

        %Registry service
        S_Registry Registry;

        %Flight Planner service
        S_FlightPlansPlanner FlightPlansPlanner;

        %Servicio de monitorizacion de vuelos
        %S_FlightPlansMonitor;
        
        %ROS info
        rosMasterIp string
        rosMasterPort uint32 = 11311;

        %Gazebo Clock
        GClock_sub;
        GClock_Upt_timer;
        Gclock;
    end
    
    methods
        %Class constructor
        function obj = UTMAirspace()
            run(fullfile("ROSconfig.m"));               %Load ROS configuration variables
            obj.rosMasterIp = ROS_IP;
            %Connect with ROS master
            obj.ConnectWithROSMaster();
            %Create instances of objects
            obj.S_Registry = Registry();
            obj.S_FlightPlansPlanner = FlightPlansPlanner(obj);
        end

        %Connection with ROS Master
        function ConnectWithROSMaster(obj)
            try
                rosinit(obj.rosMasterIp, obj.rosMasterPort);
            catch
                disp("ROS is already initialised. Restarting connection...");
                rosshutdown;
                rosinit(obj.rosMasterIp, obj.rosMasterPort);
            end

            %Suscribe to the clock
            obj.GClock_sub = rossubscriber("/clock");
            %Added timer to update GClock every 1sec
            obj.GClock_Upt_timer = timer("TimerFcn", @obj.updateGclock,"ExecutionMode","fixedRate");
            start(obj.GClock_Upt_timer);
        end
        
        %Update of Gazebo Clock value
        function obj = updateGclock(obj, timer, time)
            [msg, status] = receive(obj.GClock_sub, 0.1);
            if status
                obj.Gclock = msg.Clock_.Sec;
            end
        end

        function obj = removeAllModelsFromSimulation(obj)
            for i=1:size(obj.S_Registry.drones,2);
                drone = obj.S_Registry.drones(i);
                drone.removeDrone();
            end
        end

%         %Not in use
%         function obj = LaunchSimulinksModels(obj)
%             %numDrones = size(obj.S_Registry.drones,2);
%             SimulationsInputs = Simulink.SimulationInput.empty;
% 
%             %Name of Simulink models and blocks to edit
%             sim_ModelName = 'autonomous_drone';
%             sim_pub_bus_command = sim_ModelName + "/drone simulator/command bus/pub_bus_command";
%             sim_sub_camera = sim_ModelName + "/drone simulator/camera bus/ROS communication/sub_camera";
%             sim_sub_odometry = sim_ModelName + "/drone simulator/imu bus/sub_odometry";
%             sim_sub_fp_request = sim_ModelName + "/sub_flightPlans_request";
%             sim_pub_fp_response = sim_ModelName + "/pub_flightPlans_response";
% 
%             open_system(sim_ModelName);
% 
%             for drone = obj.S_Registry.drones
%                 %Create a Simulation Input object
%                 drone.SimulationInput = Simulink.SimulationInput(sim_ModelName);
%                 
%                 %Cambiamos los parametros de los bloques de Simulink
%                 drone.SimulationInput = drone.SimulationInput.setBlockParameter(sim_pub_bus_command, "Topic", "/drone/"+drone.droneId+"/bus_command");
%                 drone.SimulationInput = drone.SimulationInput.setBlockParameter(sim_sub_camera, "Topic", "/drone/"+drone.droneId+"/onboard_camera/image_raw");
%                 drone.SimulationInput = drone.SimulationInput.setBlockParameter(sim_sub_odometry, "Topic", "/drone/"+drone.droneId+"/odometry");
%                 drone.SimulationInput = drone.SimulationInput.setBlockParameter(sim_sub_fp_request, "Topic", "/drone/"+drone.droneId+"/flightPlans/request");
%                 drone.SimulationInput = drone.SimulationInput.setBlockParameter(sim_pub_fp_response, "Topic", "/drone/"+drone.droneId+"/flightPlans/response");
%                 %drone.SimulationInput.PreSimFcn = @(obj,i)obj.InitRandom(i);
% 
%                 %Asignamos sus datos
%                 drone.SimulationInput = drone.SimulationInput.setVariable('drone', drone);
%                 
%                 %Almacenamos los datos en el vehiculo y en el planificador
%                 %droneVehicle.SimulationInput = simulModelConfig;
%                 SimulationsInputs(drone.droneId) = drone.SimulationInput;
%             end
%             warning('off','shared_robotics:robotutils:common:SavedObjectInvalid');
%             parsim(SimulationsInputs, 'RunInBackground','on','ShowSimulationManager','on', 'SetupFcn', @(~) rng(drone.droneId));
%         end
    end
end

