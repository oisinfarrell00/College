int frogArr[5];

inline printStatement(){
    printf("\nEMPTY %d, FROG1@%d, FROG2@%d, FROG3@%d, FROG4@%d",frogArr[0],frogArr[1],frogArr[2],frogArr[3],frogArr[4]);
}

proctype moveFrog(int index){
    int temp;
    if
    ::(index<3) -> printf("\nFROG%d (RIGHT) STARTS AT %d",index,frogArr[index]);
    ::(index>=3)-> printf("\nFROG%d (LEFT) STARTS AT %d",index,frogArr[index]);
    fi;
    do
    ::atomic{
        if
        ::(index>=3&&((frogArr[index]-frogArr[0]==2)||(frogArr[index]-frogArr[0]==1)))->
            temp = frogArr[0];
            frogArr[0]=frogArr[index];
            frogArr[index]=temp;
            printf("\nFROG%d FROM %d TO %d",index,frogArr[0],frogArr[index]);
            printStatement();
        ::(index<3&&((frogArr[0]-frogArr[index]==2)||(frogArr[0]-frogArr[index]==1)))->
            temp = frogArr[0];
            frogArr[0]=frogArr[index];
            frogArr[index]=temp;
            printf("\nFROG%d FROM %d TO %d",index,frogArr[0],frogArr[index]);
            printStatement();
        fi; 
    }
    ::atomic {
        (frogArr[1]+frogArr[2]==9&&frogArr[3]+frogArr[4]==3) 
        break;
    }
    od;
}

init {
    frogArr[0]= 3;
    frogArr[1]= 1;
    frogArr[2]= 2;
    frogArr[3]= 4;
    frogArr[4]= 5;    
    printStatement();
    run moveFrog(1);
    run moveFrog(2);
    run moveFrog(3);
    run moveFrog(4);
    (_nr_pr==1)
    printf("\n");
    assert(!(frogArr[1]+frogArr[2]==9&&frogArr[3]+frogArr[4]==3));
}