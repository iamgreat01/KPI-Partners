package example

object Closure {

  def main(args: Array[String])
  {
    println( "Final_Sum(1) value = " + sum(1))
    println( "Final_Sum(2) value = " + sum(2))
    println( "Final_Sum(3) value = " + sum(3))
  }

  var a = 3

  // define closure function
  val sum = (b:Int) => b + a

}
