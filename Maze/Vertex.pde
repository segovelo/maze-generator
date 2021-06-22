class  Vertex{
     int x, y;
     int thickness;
     color vertexColor;
     boolean isInTree;
     int id;
     ArrayList<Vertex> neighbours;
     ArrayList<Edge> edges;
     
     Vertex prev;
     Vertex(int x, int y, int t, color vertexColor, int id){
        this.x = x;
        this.y = y;
        this.thickness = t;
        this.vertexColor = vertexColor;  
        this.id = id;
        isInTree = false;
        neighbours = new ArrayList<Vertex>();
        edges = new ArrayList<Edge>();
        prev = new Vertex();
     }
    Vertex(){}
   void drawVertex(){
     stroke(vertexColor);
     fill(vertexColor);
     ellipse(x,y,thickness,thickness);    
  }
  
  boolean getIsInTree(){ return isInTree;}
   void setIsInTree(boolean m){isInTree=m;} 
  

  int getX(){ return x;}
  int getY(){ return y;}
  int getId(){ return id;}
  void setPrev(Vertex v){prev=v;}
  Vertex getPrev(){return prev;}
  void addNeighbour(Vertex v){neighbours.add(v);}
  void removeNeighbour(){neighbours.remove(0);}
  Vertex getNeighbour(int i){return this.neighbours.get(i);}
  int sizeNeighbours(){return this.neighbours.size();}
  void addEdge(Edge e){edges.add(e);}
  
  Edge getEdge(int id){
     for(int i=0;i<edges.size();i++){
       if(edges.get(i).getIdV1()==id)return edges.get(i);
       if(edges.get(i).getIdV2()==id) return edges.get(i);   
     }
     return null;
  }
   String printEdge(int i){
      String str ="";    
      str = edges.get(i).getIdV1()+"-"+edges.get(i).getIdV2();
      return str;
   }
}
