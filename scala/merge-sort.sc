// excercise paremeterization techniques, including implicit

object MergeSort {
  // recursive functions need to provide a return type
  // put parameter functions as last argument, in order to leverage type inference
  //  this way there will be a bigger chance for the types to be infered
  //  because the previous arguments' types are known at compile-time
  def mergeSort[T](xs: List[T])(less: (T, T) => Boolean): List[T] = {
    // merge doesn't need [T] template, because it is nested
    def merge(xs: List[T], ys: List[T]): List[T] = {
      (xs, ys) match {
        case (Nil, ys) => ys
        case (xs, Nil) => xs
        case (x :: xsTail, y :: ysTail) =>
          if (less(x, y)) x :: merge(xsTail, ys)
          else y :: merge(xs, ysTail)
      }
    }

    val middle = xs.length / 2

    if (middle == 0) {
      xs
    } else {
      val (left, right) = xs splitAt middle
      merge(mergeSort(left)(less), mergeSort(right)(less))
    }
  }

  val numbers = List(6, 4, 9, 2, 3, 1, 1)
  mergeSort[Int](numbers)((x: Int, y: Int) => x < y)
  mergeSort(numbers)(_ < _)

  var strings = List("z", "fgd", "43asd", "kndik", "ihjk")
  // _ will fill arguments one by one in lambda expression
  mergeSort(strings)(_.compareTo(_) < 0)
}
