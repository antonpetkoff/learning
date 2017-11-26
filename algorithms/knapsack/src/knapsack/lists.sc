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

val l = List(1, 2, 3)
l.combinations(2).toList
