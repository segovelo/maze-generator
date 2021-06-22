class Tree{
  ArrayList<Integer> vInTree;
  ArrayList<Integer> eInTree;
 
     Tree(int v1, int v2, int aEdge){
           vInTree = new ArrayList<Integer>();
           eInTree = new ArrayList<Integer>();
           vInTree.add(v1);
           vInTree.add(v2);
           eInTree.add(aEdge);
       
     }
  
  void addToTree(int v1){ vInTree.add(v1);}
  void addEToTree(int aEdge) { eInTree.add(aEdge);}
  int vInTreeSize(){ return vInTree.size();}
  int eInTreeSize() { return eInTree.size();}
  int vertexID(int index){return vInTree.get(index);}
  
  
  int verticesInTree(Edge aEdge){
      int result = 0;
      for(int index=0 ; index<vInTree.size() ; index++){
          if( aEdge.getIdV1() == vInTree.get(index)){
               result = 1;
               if(aEdge.getIdV2() == vInTree.get(index)) result =3;
           } else if(aEdge.getIdV2() == vInTree.get(index)) result = 2;
      }
    return result;
  }
  
  void joinTree( Tree aTree){
    for(int index=0 ; index<aTree.vInTree.size() ; index++){
      this.addToTree(aTree.vInTree.get(index));
      this.eInTree.add(aTree.eInTree.get(index));
    } 
  }
  boolean vertexInTree(int vertexId){
    for(int i=0 ; i<vInTree.size() ; i++){
       if(vertexId == vInTree.get(i)) return true; 
    }
    return false;
  }
    
  
}
