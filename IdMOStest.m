figure (1)
hold on
for Vds = [0 0.1 0.2 0.3 0.4]
    Ids=[];
    for Vgs = 0:0.05:0.8
        Ids = [Ids IdMOS(Vgs,Vds)];
    end
    plot(0:0.05:0.8, Ids);
end

figure (2)
hold on
for Vgs = 0:0.1:0.8
    Ids=[];
    for Vds = 0:0.05:0.4
        Ids = [Ids IdMOS(Vgs,Vds)];
    end
    plot(0:0.05:0.4, Ids);
end