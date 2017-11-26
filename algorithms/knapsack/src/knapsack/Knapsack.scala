package knapsack

import scala.collection.mutable
import scala.util.Random


object KnapsackProblem extends App {
  sealed abstract class Gene
  case class Knapsack(items: mutable.Buffer[Int]) extends Gene

  def generate(size: Int): Knapsack = {
    Knapsack(Stream.continually(Random nextInt 2).take(size).toBuffer)
  }

  def mutate(knapsack: Knapsack) = {
    val index = Random.nextInt(knapsack.items.size)
    knapsack.items.update(index, knapsack.items(index) ^ 1)
  }

  def crossover(k1: Knapsack, k2: Knapsack): Knapsack = {
    val cutoff = k1.items.size / 2
    val newItems = k1.items.take(cutoff)
    newItems.appendAll(k2.items.drop(cutoff))
    Knapsack(newItems)
  }

  // can we use case without match?
  def fitness(knapsack: Knapsack): Int = knapsack match {
    case Knapsack(selection) => {
      selection.zipWithIndex.foldLeft((0, 0)) {
        case ((wSum, vSum), (taken, index)) => {
          (wSum + taken * weights(index), vSum + taken * values(index))
        }
      } match {
        case (wSum, vSum) if wSum > capacity => vSum - 7 * (wSum - capacity)
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
  mutate(knapsack)
  println(s"mutated knapsack = ${knapsack}")
  println(s"mutated knapsackFitness = ${fitness(knapsack)}")

  val knapsack2 = generate(itemCount)
  println(s"knapsack2 = ${knapsack2}")
  println(s"knapsack2Fitness = ${fitness(knapsack2)}")

  val knapsack3 = crossover(knapsack, knapsack2)
  println(s"knapsack3 aftr crossover = ${knapsack3}")
  println(s"knapsack3 fitness = ${fitness(knapsack3)}")
}
