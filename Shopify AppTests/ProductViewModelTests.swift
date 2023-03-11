//
//  ProductViewModelTests.swift
//  Shopify AppTests
//
//  Created by Ali Moustafa on 12/03/2023.
//

import XCTest
@testable import Shopify_App

class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    
    override func setUp() {
        super.setUp()
        //     set up an instance of ProductViewModel
        viewModel = ProductViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchData() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch data")
        
        // When
        viewModel.SmartCollectionID = "12345" // Set collection ID to a valid value for testing
        viewModel.didFetchData = {
            // Then
            XCTAssertNotNil(self.viewModel.productOBbrandsModel)
            XCTAssertNotNil(self.viewModel.filteredProducts)
            XCTAssertEqual(self.viewModel.productOBbrandsModel?.products?.count, self.viewModel.filteredProducts?.count)
            expectation.fulfill()
        }
        viewModel.fetchData()
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}


/*
 In this test, we set up an instance of ProductViewModel and call its fetchData method, which should fetch products from a Shopify store based on a given collection ID. We set the didFetchData closure to assert that the response contains valid data and that the productOBbrandsModel and filteredProducts properties are not nil and have the same number of products. We use a XCTestExpectation to wait for the asynchronous request to complete before fulfilling the expectation and finishing the test.

 */
