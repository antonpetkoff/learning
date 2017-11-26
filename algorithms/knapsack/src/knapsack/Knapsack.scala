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

  val POPULATION_SIZE: Int = itemCount * 2
  val GENERATIONS_COUNT: Int = 1000
  val MUTATION_PROBABILITY: Double = 0.3
  val PARENT_COUNT: Int = Math.round(Math.ceil(POPULATION_SIZE * 0.1)).asInstanceOf[Int]
  val MAX_PRINTS: Int = 5
  val ELITE_SIZE: Int = Math.round(Math.ceil(itemCount * 0.1)).asInstanceOf[Int]

  def evolve: Knapsack = {
    var population: Seq[Knapsack] = Stream.continually(generate(itemCount)).take(POPULATION_SIZE).toList
    var generation: Int = 0
    var prints: Int = 0

    while (generation < GENERATIONS_COUNT) {
      // mutation phase
      population
        .drop(ELITE_SIZE) // preserve the top
        .foreach { knapsack => {
          if (Random.nextDouble < MUTATION_PROBABILITY) {
            mutate(knapsack)
          }
        }}

      // crossover phase
      val ordered = population.sortBy(-fitness(_))
      val fitParents = ordered.take(PARENT_COUNT)
      val weakParents = ordered.drop(POPULATION_SIZE - PARENT_COUNT)
      val children = (fitParents ++ weakParents)
        .combinations(2)
        .map { case List(k1, k2) => {
          crossover(k1, k2)
        }}

      population = population ++ children

      // selection phase
      population = population.sortBy(-fitness(_)).take(POPULATION_SIZE)

      if (prints < MAX_PRINTS && (generation == 10 || generation % 100 == 0)) {
        println(s"generation ${generation}")
        println(s"population: ${population}")
        println(s"population fitness: ${population.map(fitness)}")
        println(s"best fitness = ${fitness(population.maxBy(fitness))}\n")
        prints += 1
      }
      generation += 1
    }
    population.maxBy(fitness)
  }

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
  println(s"knapsack3 after crossover = ${knapsack3}")
  println(s"knapsack3 fitness = ${fitness(knapsack3)}")

  println("running evolution...")
  val best: Knapsack = evolve
  println(s"best knapsack: ${best}")
  println(s"best knapsack fitness: ${fitness(best)}")
}

/*
5 3
2 3
5 1
3 2
 */