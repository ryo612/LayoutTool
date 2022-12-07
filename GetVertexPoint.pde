public PVector GetVertexPoint(Triangle triangle, Edge edge)
{
    if(EIsEqual(edge, triangle.AB))
    {
        return triangle.C;
    }
    else if(EIsEqual(edge, triangle.BC))
    {
        return triangle.A;
    }
    else
    {
        return triangle.B;
    }
}
