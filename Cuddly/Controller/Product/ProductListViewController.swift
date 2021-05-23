//
//  ProductListViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/05/19.
//

import UIKit

class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Properties
    
    let allProducts = Product.fetchProducts()
    
    var navigation: CustomNavigation!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCustomNav()
        
        setDelegate()
        
        // register cell to collection view
        collectionView.register(ProductListCell.nib(), forCellWithReuseIdentifier: K.id.productListCell)

        setCollectionViewLayout()
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.id.productListCell, for: indexPath) as! ProductListCell
        cell.configure(with: allProducts[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: K.id.productMainVC) as! ProductMainViewController
        vc.product = allProducts[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    // MARK: - Helpers
    func configureCustomNav() {
        self.navigationController?.navigationBar.isHidden = true
        navigation = CustomNavigation(superVC: self)
        navigation.setTitle(as: "CuddlyMarket")
        navigation.initCartButton()
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width / 2 - 5
        let height = width * 1.35
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = layout
    }
    
    
}

// MARK: - CollectionViewLayout

extension ProductListViewController: UICollectionViewDelegateFlowLayout {

    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 5
        let height = width * 1.35
        return CGSize(width: width, height: height)
    }
    
    // vertical space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // horizontal space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    

}
