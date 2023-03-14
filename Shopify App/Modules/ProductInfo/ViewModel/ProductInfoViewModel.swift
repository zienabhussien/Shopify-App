//
//  ProductInfoViewModel.swift
//  Shopify App
//
//  Created by Zienab on 10/03/2023.


import Foundation

class ProductInfoViewModel {
    
    var bindProductToProductInfo : (() -> ()) = {}
    
    var productVal : ProductInfo? {
        didSet {
            bindProductToProductInfo()
        }
    }
    
    func getSingleProduct(productId : Int){
        NetworkService.fetchFromApi(endPoint: EndPoints.SingleProduct(id: productId)) { [weak self](data : ProductInfo?) in
            guard let data = data else{ return}
            self?.productVal = data
            print(data)
        }
    }
    
    
}
