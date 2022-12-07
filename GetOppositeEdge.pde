public Edge GetOppositeEdge(Triangle triangle, PVector point)
{
    if(PIsEqual(point, triangle.A))
    {
        return triangle.BC;
    }
    else if(PIsEqual(point, triangle.B))
    {
        return triangle.CA;
    }
    else
    {
        return triangle.AB;
    }
}
