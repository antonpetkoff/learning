


1+2


val a = 3


def sum(f: Int => Int, a: Int, b: Int): Int = {
  if (a > b) 0
  else f(a) + sum(f, a + 1, b)
}


def cube(x: Int): Int = x * x * x


def sumOfCubes(a: Int, b: Int) = sum(cube, a, b)


sumOfCubes(1, 5)


sum((x: Int) => x * x, 1, 5)


// Currying

// first attempt, maybe i need the Y-combinator

// def sum(f: Int => Int): (Int, Int) => Int = (a: Int, b: Int) => {

//   if (a > b) 0

//   else f(a) + ___call_anonymuous_function_again____(f, a + 1, b)

// }

// Standard way of Currying

def sum(f: Int => Int): (Int, Int) => Int = {
  def doSum(a: Int, b: Int): Int = {
    if (a > b) 0
    else f(a) + doSum(a + 1, b)
  }
  doSum
}


def sumOfCubes = sum((x) => x * x * x)


sumOfCubes(1, 5)


// special syntax sugar for the above

def sum(f: Int => Int)(a: Int, b: Int): Int = {
  if (a > b) 0
  else f(a) + sum(f)(a + 1, b)
}


def sumOfCubes = sum(cube)


// type of sum
// (Int => Int) => ((Int, Int) => Int)
// currying is right-associative, so no need to parentheses
// right-associative means that evaluation of the expression is unambiguously evaluated from right to left
// (Int => Int) => (Int, Int) => Int

sumOfCubes(1, 5)


// def sum[T](f: Int => T, nullvalue: T, a: Int, b: Int): T = {

//   if (a > b) nullvalue

//   else f(a) + sum(f, nullvalue, a + 1, b)

// }

// sum((x: Double) => x * x / 3.0, 0.0, 1, 5)


