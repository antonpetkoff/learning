package knapsack

import scala.util.Random


object KnapsackProblem extends App {
  sealed abstract class Gene
  case class Knapsack(items: Vector[Int]) extends Gene

  def generate(size: Int): Knapsack = {
    Knapsack(Stream.continually(Random nextInt 2).take(size).toVector)
  }

  // can we use case without match?
  def fitness(knapsack: Knapsack): Int = knapsack match {
    case Knapsack(selection) => {
      selection.zipWithIndex.foldLeft((0, 0)) {
        case ((wSum, vSum), (taken, index)) => {
          (wSum + taken * weights(index), vSum + taken * values(index))
        }
      } match {
        case (wSum, vSum) if wSum > capacity => vSum - 7 * (capacity - wSum)
        case (_, vSum) => vSum
      }
    }
  }

  def readInput(): (Int, Int, List[Int], List[Int]) = {
    val Array(capacity, itemCount) = readLine().split("\\s+").map(_.toInt)
    val (values, weights) = Stream.continually {
      readLine().split("\\s+").map(_.toInt).toList
    }.take(itemCount).toList.unzip {
      case List(value, weight) => (value, weight)
    }
    (capacity, itemCount, values, weights)
  }

  val (capacity, itemCount, values, weights) = readInput()

  println("values: " + values)
  println("weights: " + weights)

  val knapsack = generate(itemCount)
  println(s"knapsack = ${knapsack}")
  val knapsackFitness = fitness(knapsack)
  println(s"knapsackFitness = ${knapsackFitness}")
}
