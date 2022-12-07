public boolean CContains(Circle circle, PVector p)
{
    // return circle.center.dist(p) <= circle.radius+0.1;
    if(circle.center.dist(p) <= circle.radius+0.1){
    return true;
  }else{
   return false; 
  }
}

public boolean TContains(Triangle triangle, PVector p)
{
    //println(GetCircumscribedCircle(triangle).r);
    //println("0k"); 
    //println(triangle.A.x);
    return CContains(GetCircumscribedCircle(triangle),p);
}

public boolean EContains(Triangle triangle, Edge e)
{
    return EIsEqual(triangle.AB, e) || EIsEqual(triangle.BC, e) || EIsEqual(triangle.CA, e);
}
