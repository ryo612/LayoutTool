public Triangle GenerateSuperTriangle()
{
    PVector center = new PVector(displayW/2, displayH/2);
    float radius = PVector.dist(center, new PVector(displayW, displayH));

    return  new Triangle(
        new PVector(center.x - radius*sqrt(3), center.y - radius),
        new PVector(center.x + radius*sqrt(3), center.y - radius),
        new PVector(center.x, center.y + 2*radius)
    );

}
