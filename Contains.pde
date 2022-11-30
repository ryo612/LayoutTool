public boolean CContains(Circle circle, PVector p)
{
    return circle.center.dist(p) <= circle.radius+0.1;
}

public boolean TContains(Triangle triangle, PVector p)
{
    return CContains(GetCircumscribedCircle(triangle),p);
}

public boolean EContains(Triangle triangle, Edge e)
{
    return IsEqual(triangle.AB, e) || IsEqual(triangle.BC, e) || IsEqual(triangle.CA, e);
}
