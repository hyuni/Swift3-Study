//: ## Generic Stack

//: ### TODO
//: - stack 기본 구현
//: - Equaltable 구현
//: - Iterator 구현

import Foundation
import UIKit
import XCTest


public struct Stack<T: Equatable>: Equatable {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
    
    public static func ==(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        return lhs.array == rhs.array
    }
}



//extension Stack: Equatable where T: Equatable {
//    public static func ==(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
//        return lhs.array == rhs.array
//    }
//}

//extension Array: Equatable where Element: Equatable {
//
//}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { _ -> T? in
            return curr.pop()
        }
    }
}


//extension Stack where T: Equatable {
//    public static func ==(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
//        return lhs.array == rhs.array
//    }
//    
//    /// comment-out : T supported Equatable. [T] supperted Equatable
////    public static func ==(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
////        guard lhs.count == rhs.count else {
////            return false
////        }
////        
////        var result = true
////        
////        for (index1, item1) in lhs.array.enumerated() {
////            let item2 = rhs.array[index1]
////            
////            if item1 == item2 {
////                //result = false
////                //break
////                continue
////            } else {
////                result = false
////                break
////            }
////        }
////        
////        return result
////    }
//    
//}


//: TestCase
class StackTestCase: XCTestCase {
    var stack1 = Stack(array: ["Carl", "Lisa", "Stephaie", "Jeff", "Wade"])
    
    var stack2: Stack<String>!

    override func setUp() {
        stack1 = Stack(array: ["Carl", "Lisa", "Stephaie", "Jeff", "Wade"])
        
        stack2 = stack1
    }
    
    override func tearDown() {
    }
    
    func testBasic() {
        
        XCTAssertEqual(stack1.count, 5)
        XCTAssertEqual(stack2.count, 5)
        
        XCTAssertEqual(stack1.array, ["Carl", "Lisa", "Stephaie", "Jeff", "Wade"])
        XCTAssertEqual(stack2.array, ["Carl", "Lisa", "Stephaie", "Jeff", "Wade"])
        
        XCTAssert(stack1.array == stack2.array)
        XCTAssertEqual(stack1.array, stack2.array)
        
        XCTAssert(stack1 == stack2)
        XCTAssertEqual(stack1, stack2)
        
        stack1.push("Mike")
        
        XCTAssertEqual(stack1.count, 6)
        XCTAssertEqual(stack1.array, ["Carl", "Lisa", "Stephaie", "Jeff", "Wade", "Mike"])
        
        XCTAssertEqual(stack2.count, 5)
        XCTAssertNotEqual(stack1.array, stack2.array)
    }
    
    func testIterator() {
        var stack = Stack<String>()
        
        for item in stack1 {
            stack.push(item)
        }
        
        // makeIterator using pop()
        XCTAssertEqual(stack1.array, stack.array.reversed())
    }
}


TestRunner().runTests(testClass: StackTestCase.self)
