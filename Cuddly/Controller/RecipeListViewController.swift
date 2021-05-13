//
//  ViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/03/25.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let allRecipes = RecipeBrain().allRecipes
    
    var csNavigationController: CustomNavigationController!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // configure custom navigation
        csNavigationController = CustomNavigationController(superVC: self)
        csNavigationController.setUpNavigationBar()
        csNavigationController.setTitle(as: "Cuddly-장바구니")
        
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.id.recipeListCell, for: indexPath) as? RecipeListCell {
            cell.configure(with: allRecipes[indexPath.row])
            return cell
        } else {
            print("cannot downcast recipe list cell")
            return UICollectionViewCell()
        }
    }
    
    // present main view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: K.id.recipeMainVC) as! RecipeMainViewController
        vc.recipe = allRecipes[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension RecipeListCell: UICollectionViewDelegateFlowLayout {
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 10
        let height = 13 * width / 9
        return CGSize(width: width, height: height)
    }
    
    // height space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
