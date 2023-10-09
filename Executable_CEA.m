% of=input("Enter Oxidizer to Fuel Ratio: ") ;
% P_c=input("Enter Chamber Pressure (bar): ") ;
fuelchoice=["H2(L)" "RP-1" "CH4" "CH4(L)"];
fuelip= input("Enter fuel choice: ");
fuel=fuelchoice(fuelip);
oxdchoice=["Air" "O2" "O2(L)"];
oxdip= input("Enter oxidizer choice: ");
oxd=oxdchoice(oxdip);
i=1;
excel=fopen('dataset.csv','w');
for P_c=10:1:200 
    for of=2:1:6
        i=i;
        fid1=fopen('rocket.inp','w');
        fprintf(fid1, "problem rocket  equilibrium o/f=%f  p,bar=%f", of, P_c);
        fprintf(fid1, "\n reactants");
        fprintf(fid1, "\n \t \t fuel = %s  wt%%=100. ", fuel);
        fprintf(fid1, "\n \t \t oxid = %s  wt%%=100.",oxd);
        fprintf(fid1, "\n output  siunits ");
        fprintf(fid1, "\n plot gamma t m ");
        fprintf(fid1, "\n end");
        fclose(fid1);
        fid2=fopen('rocket.out','w');
        fclose(fid2);
        fid3=fopen('rocket.plt','w');
        fclose(fid3);
        system(' echo rocket | FCEA2m.exe > NUL:');
        dataset=importdata('rocket.csv');
        gamma=dataset.data(2,1);
        T_c=dataset.data(2,2);
        M=dataset.data(2,3);
        T(i,1:5)=table(P_c, of, gamma, T_c, M);
        writetable(T,'dataset.csv');
        i=i+1;
    end
end
