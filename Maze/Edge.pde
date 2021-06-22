class Edge{
    Vertex v1;
    Vertex v2;
    int thickness;
    int idV1;
    int idV2;
    boolean isInTree;
    boolean isInPath;
    color edgeColor;
    int id;
    Edge(Vertex p1, Vertex p2, int t, color edgeColor, int idV1, int idV2){
       //v1 = new Vertex(p1.getX(), p1.getY(),t,edgeColor, idV1); 
       //v2 = new Vertex(p2.getX(), p2.getY(),t,edgeColor, idV2);
       v1 = p1;
       v2 = p2;
       this.thickness = t;
       this.edgeColor = edgeColor; 
       this.idV1 = idV1;
       this.idV2 = idV2;
       isInTree = false;
       isInPath = false;
   }
  
  void drawEdge(){
    
      if(isInTree) edgeColor= color(0,255,0);
      if(isInPath) edgeColor= color(255,200,0); 
      stroke(edgeColor);
      strokeWeight(thickness);
      line(v1.getX(), v1.getY(), v2.getX(), v2.getY());        
  }
  
   int getV1X(){ return v1.getX();}
   int getV1Y(){ return v1.getY();}
   int getV2X(){ return v2.getX();}
   int getV2Y(){ return v2.getY();}
   int getIdV1(){ return idV1;}
   int getIdV2(){ return idV2;}
   Vertex getV1(){ return v1;}
   Vertex getV2(){ return v2;}
   void setEdge(boolean b){ isInTree = b;}
   void setInPath(boolean b){isInPath=b;}
   void setColor(int r, int g,int b){edgeColor = color(r,g,b);}
   void setThickness(int t){ thickness = t;}
}
