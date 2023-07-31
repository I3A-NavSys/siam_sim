%Clean console and workspace
clc; clear;

%Create set of flight plans
fps = FlightPlanSet();

%Properties
number_of_flightplans = 7;
waypoints_per_fp = 10;
max_aerospace_size = 10;%meters
    
for x=1:number_of_flightplans
    % Create random waypoints location
    way_locs = max_aerospace_size*rand(waypoints_per_fp,3);
    waypoints = Waypoint.empty;
    t = 0;
    
    %Create waypoint object
    for i = 1:size(way_locs,1)
        waypoints(i) = Waypoint(...
            way_locs(i,1),...
            way_locs(i,2),...
            way_locs(i,3),... 
            t,...
            0,...
            true);
        t = t + 10;
    end
    
    %Construct fp
    fp = FlightPlan(x,waypoints, 0);
    %%Add it to the set
    fps.addFlightPlan(fp);
end

% Display route and velocity of FP
% fp.routeFigure()
% fp.velocityFigure()

% Other methods
% fp.reverseWaypoints()
% fp.normalizeVelocity()

%Display routes in the FPSet
%fps.routesFigure();

%fps.detectConflicts(1,1)

%Time dimension figure and animation
% fps.timeDimensionFig();
% fps.animateTimeDimensionFig();

%Conflict resolution
cr = ConflictResolver(1.5);
cr.simplerResolve(fps);

% fps.timeDimensionFig();
% fps.animateTimeDimensionFig();

con = fps.detectConflicts(1,0.1)

%Comput conflits with distance 1m and time_step 1s
%fps.detectConflicts(1,1)

% Other method
%fps.detectConflictsBetTimes(100,0,-10,20);
