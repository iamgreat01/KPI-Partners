package example

object Anonymous1 {

  def main(args: Array[String]) {

    var myfun1 = () => {
      "Hi all"
    }
    println(myfun1())

    def myfunction(fun: (String, String) => String) = {
      fun("ABC", "XYZ")
    }

    val f1 = myfunction((str1: String,
                         str2: String) => str1 + str2)

    // Shorthand declaration using wildcard
    val f2 = myfunction(_ + _)
    println(f1)
    println(f2)
  }
}
