public boolean IsSharingPoint(Triangle A, Triangle B)
{
    return  PIsEqual(A.A, B.A) || PIsEqual(A.A, B.B)|| PIsEqual(A.A, B.C)||
            PIsEqual(A.B, B.A) || PIsEqual(A.B, B.B)|| PIsEqual(A.B, B.C)||
            PIsEqual(A.C, B.A) || PIsEqual(A.C, B.B)|| PIsEqual(A.C, B.C);
}
