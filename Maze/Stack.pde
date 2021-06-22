class Stack{
  ArrayList<Vertex> vertexStack;
  Stack(){
   vertexStack = new ArrayList<Vertex>(); 
  }
  
  void push(Vertex v){vertexStack.add(v);}
  Vertex pop(){
   if(!this.empty()){
      Vertex v = vertexStack.get(vertexStack.size()-1);
      vertexStack.remove(vertexStack.size()-1);
      return v;
   }
   else return null;
  }
  boolean empty(){
     return ((vertexStack.size()==0) ? true : false);
  }
}
