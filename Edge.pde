public class Edge
{
    PVector start;
    PVector end;

    public Edge(PVector s, PVector e)
    {
        start = s;
        end = e;
    }

    public void EDraw()
    {
        line(start.x, start.y, end.x, end.y);
    }
    
    PVector mid(){
      return PVector.add(start, end).mult(0.5);
    }
}

void Line(PVector a, PVector b){
  line(a.x, a.y, b.x, b.y);
}
