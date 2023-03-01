//
//  catagoryViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit

class catagoryViewController: UIViewController {
    
    
    @IBOutlet weak var product: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product.reloadData()
    }
    

    func  registerCollectionView(){
        product.delegate = self
        product.dataSource = self
        
    }

}

extension catagoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
}


extension catagoryViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
}
