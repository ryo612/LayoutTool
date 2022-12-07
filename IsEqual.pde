public boolean TIsEqual(Triangle A, Triangle B)
{
    return  (EIsEqual(A.AB, B.AB) || EIsEqual(A.AB, B.BC) || EIsEqual(A.AB, B.CA))&&
            (EIsEqual(A.BC, B.AB) || EIsEqual(A.BC, B.BC) || EIsEqual(A.BC, B.CA));
}


public boolean EIsEqual(Edge A,Edge B)
{
    return  (PIsEqual(A.start, B.start) && PIsEqual(A.end, B.end))||
            (PIsEqual(A.start, B.end) && PIsEqual(A.end, B.start));
}

public boolean PIsEqual(PVector A,PVector B)
{
    return (A.x == B.x)&&(A.y == B.y);
}
