//
//  ViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/25.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Properties
    
    let allRecipes = Recipe.fetchRecipes()
    
    var navigation: CustomNavigation!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // custom navigation
        self.navigationController?.navigationBar.isHidden = true
        navigation = CustomNavigation(superVC: self)
        navigation.setTitle(as: "Cuddly")
        navigation.initCartButton()
        
        // collection view delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // register cell to collection view
        collectionView.register(RecipeListCell.nib(), forCellWithReuseIdentifier: RecipeListCell.identifier)
        
        // collection view layout
        let layout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width / 2 - 10
        let height = 13 * width / 9
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = layout
        
    }
    

    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.id.recipeListCell, for: indexPath) as! RecipeListCell
        cell.configure(with: allRecipes[indexPath.row])
        return cell
    }
    
    // present main view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: K.id.recipeMainVC) as! RecipeMainViewController
        vc.recipe = allRecipes[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionViewLayout

//extension RecipeListCell: UICollectionViewDelegateFlowLayout {
extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        let height = 13 * width / 9
        return CGSize(width: width, height: height)
    }
    
    // vertical space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // horizontal space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
