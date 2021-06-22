
int[] vertices, verticesList;
int dist=50; // Distance between vertices. Determine with screen size the number of verices in the screen
int thickness = 5;
int edgeThick = 5;
int m,n,o,p;
int i =0;
int numVertices=0;
int numEdges = 0;
int startingEdge;
int v1InTree=0;
int v2InTree=0;
int numEdgesTree=0;
int randomVertex=0;
int stackIndex=0;
int op;
int randomEdge, counter=0;
color vertexColor = color(255,0,0);
color edgeColor = color(0,0,255);
Vertex[] myVertices;
Vertex currentVertex = new Vertex();
Vertex prev = new Vertex();
Edge[] myEdges;
ArrayList<Integer> verticesInTree = new ArrayList<Integer>();
ArrayList<Integer> edgesInTree = new ArrayList<Integer>();
ArrayList<Integer> idEdges = new ArrayList<Integer>();
ArrayList<Tree> myTrees = new ArrayList<Tree>();
ArrayList<Edge>  edgesTree = new ArrayList<Edge>();
ArrayList<Edge> path = new ArrayList<Edge>();
ArrayList<Stack> nV = new ArrayList<Stack>();
boolean bothVerticesInTree = false;
boolean finish = false;
boolean once = true;
boolean oncePath = true;
boolean finalPath = false;
boolean forward = true;

void setup(){
 fullScreen();
  m=(int)(width/dist);  
  n=(int)(height/dist);   
  o=(int)(width/dist)-1;
  p=(int)(height/dist)-1; 
  vertices = new int[m*n];  
  myVertices = new Vertex[(m*n)];
  myEdges = new Edge[((m-1)*n+m*(n-1))];
  
     for(int j=0 ; j<n-1 ; j++){
        for(int i=0 ; i<m-1 ; i++){       
              myVertices[(i)+((j)*(m-1))] = new Vertex((i+1)*dist,(j+1)*dist, thickness,vertexColor,  numVertices);   
              vertices[numVertices]=numVertices+1;          
              numVertices++;           
        } 
   }
 
   // Horizontal Edges
   for(int j=0 ; j<n-1 ; j++){
        for(int i=0 ; i<m-2 ; i++){
           myEdges[numEdges] = new Edge(myVertices[i+j*(m-1)], myVertices[i+(j*(m-1))+1], edgeThick, edgeColor,i+j*(m-1),i+j*(m-1)+1);
           idEdges.add(numEdges);
           numEdges++;
        }  
    }
    
    // Vertical Edges
  for(int i=0 ; i<m-1 ; i++){
        for(int j=0 ; j<n-2 ; j++){
                myEdges[numEdges] = new Edge(myVertices[i+(j*(m-1))], myVertices[i+(j*(m-1))+m-1], edgeThick, edgeColor,i+j*(m-1),i+j*(m-1)+m-1);
               idEdges.add(numEdges);
                numEdges++;
        }
    } 
    randomVertex = (int)random(0,numVertices);
    currentVertex = myVertices[0];
    prev = myVertices[0];
}  

void draw(){
 
   background(200,200,255);
   numEdges = 0;
    textSize(10);      
    
   // Horizontal Edges
   for(int j=0 ; j<n-1 ; j++){
        for(int i=0 ; i<m-2 ; i++){
           myEdges[numEdges].drawEdge();
          if(dist>=80) text("E "+myEdges[numEdges].getIdV1()+"-"+myEdges[numEdges].getIdV2(),myEdges[numEdges].getV1X()+2*dist/5,myEdges[numEdges].getV1Y()-5);
           numEdges++;
        }  
    }
    
    // Vertical Edges
  for(int i=0 ; i<m-1 ; i++){
        for(int j=0 ; j<n-2 ; j++){
                myEdges[numEdges].drawEdge();
                if(dist>=80)text("E "+myEdges[numEdges].getIdV1()+"-"+myEdges[numEdges].getIdV2(),myEdges[numEdges].getV1X()+5,myEdges[numEdges].getV1Y()+dist/2);
                numEdges++;
        }
    }   
    
     if((verticesInTree.size()<numVertices) || myTrees.size()>1){
          if(counter==0){
              randomEdge = (int)random(0,idEdges.size());
              if(idEdges.size()>0){
                   op = verticesInTree(idEdges.get(randomEdge));
                  switch(op){
                      case 0:
                             Tree newTree = new Tree(myEdges[idEdges.get(randomEdge)].getIdV1(),
                             myEdges[idEdges.get(randomEdge)].getIdV2(),idEdges.get(randomEdge));
                             myTrees.add(newTree);                                         
                             edgesInTree.add(idEdges.get(randomEdge));
                             verticesInTree.add(myEdges[idEdges.get(randomEdge)].getIdV1());
                             verticesInTree.add(myEdges[idEdges.get(randomEdge)].getIdV2());
                             myEdges[idEdges.get(randomEdge)].setEdge(true);
                             myEdges[idEdges.get(randomEdge)].setThickness((int)2*edgeThick);
                             edgesTree.add(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV1().addEdge(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV2().addEdge(myEdges[idEdges.get(randomEdge)]);
                             idEdges.remove(randomEdge);
                             numEdgesTree++;
                             
                             break;
                             
                      case 1:
                             for(int i=0 ; i<myTrees.size() ; i++){
                                 if( myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV1())){
                                       myTrees.get(i).addToTree(myEdges[idEdges.get(randomEdge)].getIdV2());
                                       myTrees.get(i).addEToTree(idEdges.get(randomEdge));
                                       break;
                                 } 
                             } 
                             edgesInTree.add(idEdges.get(randomEdge));
                             verticesInTree.add(myEdges[idEdges.get(randomEdge)].getIdV2());
                             myEdges[idEdges.get(randomEdge)].setEdge(true);
                             myEdges[idEdges.get(randomEdge)].setThickness((int)2*edgeThick);                            
                             edgesTree.add(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV1().addEdge(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV2().addEdge(myEdges[idEdges.get(randomEdge)]);
                             idEdges.remove(randomEdge);
                             numEdgesTree++;
                             break;
                      
                      case 2:  
                             for(int i=0 ; i<myTrees.size() ; i++){
                                 if( myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV2())){
                                       myTrees.get(i).addToTree(myEdges[idEdges.get(randomEdge)].getIdV1());
                                       myTrees.get(i).addEToTree(idEdges.get(randomEdge));
                                       break;
                                 } 
                             }                      
                             edgesInTree.add(idEdges.get(randomEdge));
                             verticesInTree.add(myEdges[idEdges.get(randomEdge)].getIdV1());
                             myEdges[idEdges.get(randomEdge)].setEdge(true);
                             myEdges[idEdges.get(randomEdge)].setThickness((int)2*edgeThick);                         
                             edgesTree.add(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV1().addEdge(myEdges[idEdges.get(randomEdge)]);
                             myEdges[idEdges.get(randomEdge)].getV2().addEdge(myEdges[idEdges.get(randomEdge)]);                             
                             idEdges.remove(randomEdge);
                             numEdgesTree++;
                             break;  
                      
                      case 3:
                            for(int i=0 ; i<myTrees.size() ; i++){
                                 if( myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV1()) &&
                                     myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV2())){
                                       bothVerticesInTree = true;
                                       break;
                                 }     
                                 if( myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV1()))v1InTree=i;
                                 if( myTrees.get(i).vertexInTree(myEdges[idEdges.get(randomEdge)].getIdV2()))v2InTree=i;
                              }
                              if(!bothVerticesInTree){
                                  if(myTrees.get(v1InTree).vInTreeSize() > myTrees.get(v2InTree).vInTreeSize()){
                                      for(int i=0;i<myTrees.get(v2InTree).vInTreeSize();i++){
                                          myTrees.get(v1InTree).addToTree(myTrees.get(v2InTree).vertexID(i));
                                      } 
                                       myEdges[idEdges.get(randomEdge)].setEdge(true);
                                       myEdges[idEdges.get(randomEdge)].setThickness((int)2*edgeThick);
                                       myTrees.remove(v2InTree);
                                   } else{  
                                         for(int i=0;i<myTrees.get(v1InTree).vInTreeSize();i++){
                                              myTrees.get(v2InTree).addToTree(myTrees.get(v1InTree).vertexID(i));
                                          } //End of For
                                          myEdges[idEdges.get(randomEdge)].setEdge(true);
                                          myEdges[idEdges.get(randomEdge)].setThickness((int)2*edgeThick);
                                          myTrees.remove(v1InTree);                                     
                                        }// End Of Else
                                   edgesTree.add(myEdges[idEdges.get(randomEdge)]);                             
                                   myEdges[idEdges.get(randomEdge)].getV1().addEdge(myEdges[idEdges.get(randomEdge)]);
                                   myEdges[idEdges.get(randomEdge)].getV2().addEdge(myEdges[idEdges.get(randomEdge)]);
                                   numEdgesTree++;        
                              }// End of  if(!bothVerticesInTree)
                               else{
                                    myEdges[idEdges.get(randomEdge)].setColor(180,180,180);
                                    bothVerticesInTree = false;
                                    }
                              idEdges.remove(randomEdge);
                              break;  

                  } // End of switch
               }
          } else if (counter>1) counter = -1;
          //counter++;
     } // End of  if(verticesInTree.size()<numVertices || myTrees.size()>1)
       else if(idEdges.size()>0){
                randomEdge = (int)random(0,idEdges.size());
                myEdges[idEdges.get(randomEdge)].setColor(180,180,180);
                idEdges.remove(randomEdge);
              } else finish = true;
       
     
     //  Draw Vertices
     strokeWeight(2);
    for(int j=0 ; j<n-1 ; j++){
        for(int i=0 ; i<m-1 ; i++){       
           myVertices[i+(j*(m-1))].drawVertex();
           if(dist>=40)text("V" + (i+((j)*(m-1))), myVertices[i+(j*(m-1))].getX()+5, myVertices[i+(j*(m-1))].getY()-5);
        }
     }     
    
   if(finish && once){
      for(int i=0; i<edgesTree.size();i++){
        myVertices[edgesTree.get(i).getIdV2()].addNeighbour(edgesTree.get(i).getV1());
        myVertices[edgesTree.get(i).getIdV1()].addNeighbour(edgesTree.get(i).getV2());
      }   
      once = false;
    } // End of if(finish)
    
    if(dist>=80 && finish){    
      textSize(12);
      text("current Vertex V "+currentVertex.getId(), 50,height-80);
    }

    if(finish && !once && !finalPath){
      if(forward){
         Stack s = new Stack();
         if(currentVertex.getId()==0)       
            for(int i=0; i<currentVertex.sizeNeighbours();i++) s.push(currentVertex.getNeighbour(i));       
         else if(currentVertex.sizeNeighbours()>1){
                 for(int i=0; i<currentVertex.sizeNeighbours();i++) 
                    if(currentVertex.getNeighbour(i).getId()!=currentVertex.getPrev().getId())s.push(currentVertex.getNeighbour(i));
              }
          nV.add(s); 
      } // end of if(forward)
      else {
         currentVertex.getEdge(currentVertex.getPrev().getId()).setInPath(false);
         currentVertex.getEdge(currentVertex.getPrev().getId()).setThickness(2*edgeThick);
         path.remove(stackIndex-1);
         currentVertex = currentVertex.getPrev();
         stackIndex--;    
        }
        if(!(nV.get(stackIndex).empty())){
           Vertex v2 = nV.get(stackIndex).pop();         
           currentVertex.getEdge(v2.getId()).setInPath(true);
           currentVertex.getEdge(v2.getId()).setThickness(3*edgeThick);
           path.add(currentVertex.getEdge(v2.getId()));
           if(v2.getId()==numVertices-1) finalPath = true; 
           v2.setPrev(currentVertex);
           currentVertex = v2; 
           stackIndex++;          
           forward = true;
        } // end of if(!s.empty())
        else { forward = false; 
               nV.remove(stackIndex);
             }   
    }// End of if(finish && !finalPath)
   textSize(12);
   if(dist>=80){
      text("Path: ",20,height-50);
      for(int i=0;i<path.size();i++)
          text("E "+path.get(i).getIdV1()+"-"+path.get(i).getIdV2(),60+70*i,height-50);
   }
   if(dist>=40){    
       text(numVertices +" Vertices and " + numEdges + " Edges, Random Edge: "+ 
       randomEdge + ",  "+" Edges left: "+idEdges.size()+"   Edges On Tree:  "+ 
       numEdgesTree +"    "+ op, 45,30);
   }   
    
    //if(finish && !once && !finalPath)delay(300);
}


   int verticesInTree(int rnd){
       boolean v1In = false;
       boolean v2In = false;
       int result = 0;
      for(int i=0; i<verticesInTree.size(); i++){
           if(verticesInTree.get(i) == myEdges[rnd].getIdV1()) v1In = true;
           if(verticesInTree.get(i) == myEdges[rnd].getIdV2()) v2In = true;     
           if(v1In && v2In) return 3;
      }     
     //if(v1In && v2In)result = 3;
         if(v1In) result = 1;
           else if(v2In) result = 2;
     return result; 
   }



  /* boolean notAllVerticesInTree(){
       
       int inTree=0, result = 1;
       if(verticesInTree.size() == 0) return true;
       for(int j=0; j< verticesInTree.size() ; j++){ 
            for(int i=0 ; i<numVertices ; i++){
               inTree = 0;
                if( verticesInTree.get(j) == myVertices[i].getId()){
                      inTree = 1;
                      break;
                }                                  
            }
            result *= inTree;
            if(result == 0) return true;
       }       
     return false;
   }  */

/* boolean checkAllVerticesConnected(ArrayList<Vertex> verticesInTree, Vertex[] myVertices){
      int i = 0;
      int arrayListLength = verticesInTree.size();
      if(arrayListLength != myVertices.length) return false;
          else{
                do{
                      if(verticesInTree.get(i) != myVertices[i]) return false;
                      i++;
                    }while(i<= verticesInTree.size());
                    return true;
              }     
 }
 
 boolean isVertexInList(ArrayList<Vertex> verticesInTree, Edge aEdge){
    if(verticesInTree.size() > 0 && aEdge != null){
             int index = 0;
           do{
                if((verticesInTree.get(index).getX() == aEdge.getV1X() &&
                    verticesInTree.get(index).getY() == aEdge.getV1Y()) ||
                   (verticesInTree.get(index).getX() == aEdge.getV2X() &&
                   verticesInTree.get(index).getY() == aEdge.getV2X())) return true;
                index++;
           }while(index< verticesInTree.size());
    
    }
  return false; 
 }  */
