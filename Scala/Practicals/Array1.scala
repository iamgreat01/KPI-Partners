package example


class ArrayExample{
  var arr = Array(1,2,3,4,5)
  def show(){
    for(a<-arr)                       // Traversing array elements
      println(a)
    println("Third Element  = "+ arr(2))        // Accessing elements by using index
  }
}

object Array1{
  def main(args:Array[String]){
    var a = new ArrayExample()
    a.show()
  }
}
