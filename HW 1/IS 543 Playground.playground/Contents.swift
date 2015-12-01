//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print("Hello World")
print("Hi Nathan")

var MyVariable = 42
MyVariable = 50
let MyConstant = 42

let ImplicitInteger = 70
let ImplicitDouble = 70.0
let ExplicitDouble: Double = 70
let ExplicitFloat: Float = 5 //????

let Label = "The width is"
let width = 94
let LabelWidth = Label + " " + String(width)
//let LabelWidthExperiment = Label + width

let Apples = 6
let Oranges = 7
let AppleSummary = "I have \(Apples) Apples"
let OrangeSummary = "I have \(Oranges) oranges"
let FruitSummary = "I have \(Apples + Oranges) pieces of fruit"
let Name = "Jocelynn"
let textbooks = 4.0
let Text = "Hello \(Name), I have \(textbooks - 1.45) Textbooks"

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
shoppingList[0]

/*var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
occupations[1] //????

shoppingList2 = []
occupations2 = [:]

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)*/

var OptionalString: String? = "Hello"
print(OptionalString==nil)

var OptionalName: String? = "Nathan"
var Greeting = "Hello"
if let name = OptionalName {
    Greeting = "Hello, \(name)"
}

let Vegetable = "pepper"
switch Vegetable{
case "celery":
    print("get raisins and make ants on a log")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            //Need variable to capture what kind of number it is
        }
    }
}
print(largest)

var n = 2
while n < 100 {
    n = n * 2
}
print(n)

/*repeat {
    m = m * 2
} while m < 100
print(m)*/

var firstForLoop = 0
for i in 0..<4 {
    firstForLoop += i
}
print(firstForLoop)

var secondForLoop = 0
for var i = 0; i < 4; ++i {
    secondForLoop += i
}
print(secondForLoop)

func Greet(name: String, day: String) -> String { //Use -> to separate the parameter names and types from the function’s return type.
    return "Hello \(name), today is \(day)"
}
Greet("Bob","Tuesday")

func CalculateStats(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score > max {
            max = score
        }else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = CalculateStats([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

/*func averageOf(numbers: Int...) -> Int {
    var Average = 0
    var count = argcount
    
}*/

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A \(name) is a shape with \(numberOfSides) sides."
    }
}

var thingShape = NamedShape(name:"Triangle")
thingShape.numberOfSides = 3
thingShape.simpleDescription()

class Square: NamedShape{
    var sideLength: Double
    
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."}
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
//let two = Rank.Two
let jack = Rank.Jack
let jackRawValue = jack.rawValue
let queen = Rank.Queen
let queenRawValue = queen.rawValue
let aceRawValue = ace.rawValue




