// Homework 2

import UIKit

//1. Compute the ith Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, …)

func Fib(n: Int) -> Int{
    if(n <= 1){
        return n
    }
    return Fib(n-1) + Fib(n-2)
}

Fib(3)

//2. Compute n! for n >= 0
func factorial(i: Int, result: Int) -> Int{
    if(i == 0){
        return result
    }
    
    
    return factorial(i-1, result*i)
}

factorial(3,1)

//3. Compute the sum of all integers between two given integers (inclusive)
func summation(min: Int, max: Int, result: Int) -> Int{
    if(min == max){
        return result + max
    }
    return summation(min+1, max, result+min)
}
summation(4,6,0)

//func summation2(min: Int, max: Int) -> Int{
//    var result = 0
//    for var i = min; i <= max; ++i {
//       result += i
//    }
//    return result
//}
//
//summation2(4, 6)

//4.Given a number of cents, print to the console the corresponding U.S. coins that total to the given number.  Print the solution that needs the fewest coins.  Only use pennies, nickels, dimes, and quarters.  Example: for 113, the answer is “4 quarters”, “1 dime”, “3 pennies”.  Do not print the case where the solution calls for 0 of the coin (e.g. don’t print “0 nickels”).  Use the singular word is the value is 1, or the plural if the coin count is greater than 1.

func giveCoins(i: Int) -> String {
    var change = i
    var quarters = change/25
    var dimes = change/10
    var nickels = change/5
    var pennies = change/1
    var returnString = ""
    
    //Compute number of coins
    if(change>=25){
        quarters = change/25
        change -= (25 * quarters)

        returnString = quarters > 1 ? "\(quarters) quarters" : "\(quarters) quarter"
        returnString += change > 0 ? ", " : ""

        
//        if(change == 0){
//            returnString += "\(quarters) quarters "
//        }
//        if(quarters >= 2){
//            returnString += "\(quarters) quarters, "
//        }
//        else{
//            returnString += "\(quarters) quarter, "
//        }
    }
    if(change>=10){
        dimes = change/10
        change -= (10 * dimes)
        
        returnString += dimes > 1 ? "\(dimes) dimes" : "\(dimes) dime"
        returnString += change > 0 ? ", " : ""
        
//        if(dimes > 1){
//            returnString += "\(dimes) dimes, "
//        }
//        else{
//            returnString += "\(dimes) dime, "
//        }
    }
    if(change>=5){
        nickels = change/5
        change -= (5*nickels)

        returnString += nickels > 1 ? "\(nickels) nickels" : "\(nickels) nickel"
        returnString += change > 0 ? ", " : ""
        
        
//        if(nickels >= 2){
//            returnString += "\(nickels) nickels, "
//        }
//        else{
//            returnString += "\(nickels) nickel, "
//        }
    }
    if(change>=1){
        pennies = change/1
        change -= (1*pennies)

        returnString += pennies > 1 ? "\(pennies) pennies" : "\(pennies) penny"
        returnString += change > 0 ? ", " : ""
        
//        if(pennies >= 2){
//            returnString += "\(pennies) pennies"
//        }
//        else{
//            returnString += "\(pennies) penny"
//        }
    }
    
    
    return returnString
}

giveCoins(35)
























