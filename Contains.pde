public boolean Contains(Circle circle, PVector p)
{
    return circle.center.dist(p) <= circle.radius+0.1;
}

public boolean Contains(Triangle triangle, PVector p)
{
    return Contains(GetCircumscribedCircle(triangle),p);
}

public boolean Contains(Triangle triangle, Edge e)
{
    return IsEqual(triangle.AB, e) || IsEqual(triangle.BC, e) || IsEqual(triangle.CA, e);
}
