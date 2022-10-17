topico = "/planesvuelo";

try
    rosinit("192.168.1.131",11311);
catch
    disp("ROS ya inicializado");
end

pub = rospublisher(topico, "siam_main/FlightPlan");
msg = rosmessage('siam_main/FlightPlan');
point = rosmessage("geometry_msgs/Point");

msg.FlightPlanId = 100;
msg.Status = 0;
msg.Priority = 7;
msg.OperatorId = 10;
msg.DroneId = 1000;
msg.Dtto = 200;

point.X = 1;
point.Y = 2;
point.Z = 3;

msg.Orig = point;

point.X = 11;
point.Y = 22;
point.Z = 33;

msg.Dest = point;

for i = 1:1:10
    point.X = i;
    point.Y = i;
    point.Y = i;

    msg.Route(i) = point;
end

send(pub,msg);
