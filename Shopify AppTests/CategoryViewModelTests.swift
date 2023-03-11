//
//  CategoryViewModelTests.swift
//  Shopify AppTests
//
//  Created by Ali Moustafa on 12/03/2023.
//

import XCTest

import Alamofire //to be able to access CategoryViewModel class and its methods.
@testable import Shopify_App

class CategoryViewModelTests: XCTestCase {
    
    var sut: CategoryViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CategoryViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
//    The first test checks that fetchCollections() method is able to retrieve data from the API and decode it into subCatecoryResponse object.
    func testFetchCollections() {
        // Given
        let expectation = self.expectation(description: "Fetch collections")
        
        // When
        sut.fetchCollections()
        sut.didFetchData = {
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.sut.subCategoriesNamesModel)
        }
    }
//    The second test checks that fetchProduct() method is able to retrieve data from the API and decode it into Products object.
    func testFetchProduct() {
        // Given
        let expectation = self.expectation(description: "Fetch products")
        
        // When
        sut.fetchProduct()
        sut.didFetchDatapro = {
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(self.sut.productOfbrandsCategoryModel)
        }
    }
}
