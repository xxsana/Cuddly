//
//  LinkedProductViewController.swift
//  Cuddly
//
//  Created by Haru on 2021/04/09.
//

import UIKit

class LinkedProductViewController: UIViewController {

    @IBOutlet weak var backingImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var handleView: UIView!
    
    // to store backing image
    var backingImage: UIImage?
    let maxTopConstant: CGFloat = 30.0
    
    enum CardViewState {
        case expanded
        case normal
    }
    
    // default card view state is normal
    var cardViewState: CardViewState = .normal
    
    // to store the card view top constraint value before the dragging start
    // default is 30 pt from safe area top
    var cardPanStartingTopConstant: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayer()

        // update the backing image view
        backingImageView.image = backingImage
        
        // round the handle view
        handleView.clipsToBounds = true
        handleView.layer.cornerRadius = 3.0
        
        // hide the card view at the bottom when the View first load
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
        
        let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = keyWindow.safeAreaInsets.bottom
        
        cardViewTopConstraint.constant = safeAreaHeight + bottomPadding //hide상태에서 출발
        
        // backingImageViewTapped() will be called when user tap on the dimmer view
        let backingImageViewTap = UITapGestureRecognizer(target: self, action: #selector(backingImageViewTapped))
        backingImageView.addGestureRecognizer(backingImageViewTap)
        backingImageView.isUserInteractionEnabled = true
        
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        
        // by default iOS will delay the touch before recording the drag/pan information
        // we want the drag gesture to be recorded down immediately, hence setting no delay
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        
        self.view.addGestureRecognizer(viewPan)
        
    }//end of viewDidLoad()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showCard()
    }
    
    //set shadow and rounded corner of CardView
    func setUpLayer() {
        
        //a Float value between 0.0 to 1.0 determines how opaque it shadow will be
        cardView.layer.shadowOpacity = 0.5
        
        //how far the shadow will go to the right and the height determines how far the shadow will go down
        cardView.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        
        //defines the blur radius or the spread of the shadow, defaults to 3
        cardView.layer.shadowRadius = 11
        cardView.layer.shadowColor = UIColor.black.cgColor
        
        //Add rounded corners to view using CALayer
        cardView.layer.cornerRadius = 40
    }
    
    @objc func backingImageViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }
    
    
    // this function will be called when user pan/drag the view
    @IBAction func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        // panRecognizer == viewPan
        // how much distance has user dragged the card view
        let translation = panRecognizer.translation(in: self.view)
        
        // how fast the user drag
        let velocity = panRecognizer.velocity(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            cardPanStartingTopConstant = cardViewTopConstraint.constant
        case .changed:
            if self.cardPanStartingTopConstant + translation.y > maxTopConstant {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstant + translation.y
            }
        case .ended:
            // if user drag down with a very fast spped (ie. swipe)
            if velocity.y > 1500.0 {
                // hide the card and dismiss current view controller
                hideCardAndGoBack()
                return
            }
            
            // 드래그가 끝난 뒤의 위에서부터 constraint를 확인 후 위에서 1/4면 아예 올리고
            // 밑에서 70 떨어진 중간쯤이면 가운데로 만들고
            // 밑에서 70 안이면 없애버림
            guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
            
            let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
            let bottomPadding = keyWindow.safeAreaInsets.bottom
            if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.25 {
                //show the card at expanded state
                showCard(atState: .expanded)
            } else if self.cardViewTopConstraint.constant < (safeAreaHeight) - 70 {
                showCard(atState: .normal)
            } else {
                // hide the card and dismiss current view controller
                hideCardAndGoBack()
            }
        default:
            break
        }
        //positive number means user dragged downward
        // negative number means user dragged upward
//        print("user has dragged \(translation.y) point vertically")
    }

    //MARK: Animations
    private func showCard(atState: CardViewState = .normal) {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        // set the new top constraint value for card view
        // card view won't move up just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
        
        let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = keyWindow.safeAreaInsets.bottom
        
        if atState == .expanded {
            // if state is expanded, top constrain is away from safe area top
            cardViewTopConstraint.constant = maxTopConstant
        } else {
            cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.0
        }
        
        cardPanStartingTopConstant = cardViewTopConstraint.constant
            
        // move card up from bottom by telling the app to refresh the frame/position of view
        // create a new property animator
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {self.view.layoutIfNeeded()
        })
        
        // run the animation
        showCard.startAnimation()
    }
    
    private func hideCardAndGoBack() {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        // set the new top constraint value for card view
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
        let safeAreaHeight = keyWindow.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = keyWindow.safeAreaInsets.bottom
            
        // move the card view to bottom of screen
        cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        
        // move down to bottom
        // create a new property animator
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        // when the animation completes, (position == .end)
        // dismiss this view controller
        hideCard.addCompletion({ position in
            if(self.presentingViewController != nil) { //불렀던 뷰
                self.dismiss(animated: false, completion: nil)
            }
        })
        
        // run the animation
        hideCard.startAnimation()
    }
    
}
