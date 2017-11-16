package knapsack

case class Gene(chromosomes: Vector[Int])

object Knapsack extends App {
  val Array(m, n) = readLine().split("\\s+").map(_.toInt)
  val (values, weights) = Stream.continually {
    readLine().split("\\s+").map(_.toInt).toList
  }.take(n).toList.unzip {
    case List(value, weight) => (value, weight)
  }

  println("values: " + values)

  println("weights: " + weights)
}
