//
//  CustomerModelTestCase.swift
//  Shopify AppTests
//
//  Created by Zienab on 11/03/2023.
//

import XCTest
@testable import Shopify_App
final class CustomerModelTestCase: XCTestCase {
    
    var customer : Customer!
    let firstName = "Zienab"
    let lastName = "Hussien"
    let email = "zienab@gmail.com"
    let password = "12345"
    
    override func setUpWithError() throws {
        customer = Customer(first_name: firstName, last_name: lastName,
                            email: email, phone: "", tags: "", id: 0,
                            note: password, verified_email: true, addresses: [])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCustomerCanCreateNewInstance(){
        
        XCTAssertNotNil(customer)
    }
    
    func testisValidFirstName(){
        XCTAssertTrue(customer.isValidFirstName())
    }
    
    func testIsvalidEmail(){
        XCTAssertTrue(customer.isValidEmail())
    }
    
    func testisValidPassword(){
        XCTAssertTrue(customer.isValidPassword())
    }

    func testIsValidAllData(){
        XCTAssertTrue(customer.isDataValid())
    }
    
}
