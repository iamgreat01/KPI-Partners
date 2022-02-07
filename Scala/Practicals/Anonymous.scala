package example

object Anonymous {

  def main(args: Array[String])
  {

    var myfunc1 = (str1:String, str2:String) => str1 + str2

    var myfunc2 = (_:String) + (_:String)

    println(myfunc1("ABC", "EFG"))
    println(myfunc2("ABC", "XYZ"))
  }
}
