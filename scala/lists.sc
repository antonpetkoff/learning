List(List(1,2),List(2,3)).unzip { case List(a, b) => (a, b) }

Stream.continually {
  "42  4".split("\\s+").map(_.toInt).toList
}.take(4).toList.unzip {
  case List(a, b) => (a, b)
}

case class Person(name: String, number: String)

def matchPerson(person: Person): String = person match {
  // Then you specify the patterns:
  case Person("George", number) => "We found George! His number is " + number
  case Person("Kate", number)   => "We found Kate! Her number is " + number
  case Person(name, number)     => "We matched someone : " + name + ", phone : " + number
}
matchPerson(Person("George", "Skeleta"))

// pattern-matching over non-case class with custom extractor

// TODO: why is val needed?
class Person2(val name: String, val number: String)

object Person2 {
  def unapply(arg: Person2): Option[(String, String)] = {
    Some((arg.name, arg.number))
  }
}

def matchPerson2(person: Person2): String = person match {
  // Then you specify the patterns:
  case Person2("George", number) => "We found George! His number is " + number
  case Person2("Kate", number)   => "We found Kate! Her number is " + number
  case Person2(name, number)     => "We matched someone : " + name + ", phone : " + number
}

matchPerson2(new Person2("George", "Skeleta"))

import scala.util.Random

Stream.continually{Random nextInt 2}.take(10).toList

Random.nextInt(2)

List(1, 2, 3).fold(0) { (sum: Int, v: Int) =>
  sum + v
}

val values = List(1, 2, 3, 4, 5)
val weights = List(10, 3, 7, 15, 30)
val knapsack: Vector[Int] = Vector(0, 1, 0, 0, 1)

val (wSum, vSum) = knapsack.zipWithIndex.fold((0, 0)) {
  case ((wSum, vSum), (taken, index)) => {
    (wSum + taken * weights(index), vSum + taken * values(index))
  }
}

//implicit object TupleNumeric extends Numeric[(Int, Int)] {
//
//}


//val knapsackValue = knapsack.zip(values).fold(0) {
//  case (sum: Int, (taken: Int, value: Int)) => sum + (taken * value)
//}
//
//val knapsackWeight = knapsack.zip(weights).fold(0) {
//  case (sum: Int, (taken: Int, weight: Int)) => sum + (taken * weight)
//}

// incorrect attempt, it seems that fold expects a lower bound accumulator type
// TODO: type variance
//def knapsackSum(knapsack: Seq[Int])(values: Seq[Int]): Int = {
//  knapsack.zip(values).fold(0) {
//    case (sum: Int, (taken: Int, value: Int)) => sum + taken * value
//  }
//}

def sumItems(knapsack: Seq[Int])(values: Seq[Int]): Int = {
  knapsack.zip(values).foldLeft(0) {
    case (sum: Int, (taken: Int, value: Int)) => sum + taken * value
  }
}

// notice the underscore for partial application
val knapsackSumOf = sumItems(knapsack)(_)
val knapsackValue = knapsackSumOf(values)
val knapsackWeight = knapsackSumOf(weights)
