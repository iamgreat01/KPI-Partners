package example

object Anonymous2 {

  def main(args: Array[String]): Unit = {

    var func = (x:Int) => x+1

    var x = func(7)-1

    println(x);


    var func1 = (x: Int, y: Int) => x*y

    println(func1(3, 4))

 // with no parameter
    var func2 = () => {
    //  System.getProperty("Testing!!")
      println("hi")
    }

println(func2)



  }

}
