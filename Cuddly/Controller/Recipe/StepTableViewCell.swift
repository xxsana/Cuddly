//
//  StepViewCell.swift
//  Cuddly
//
//  Created by Haru on 2021/05/12.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    var stepLabel = UILabel()
    var numberImageView = UIImageView()
    var stepTitle = UILabel()
    var stepImageView = UIImageView()
    var descLabel = UILabel()
    
    let leadingSpace: CGFloat = 15.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stepLabel)
        addSubview(numberImageView)
        addSubview(stepTitle)
        addSubview(stepImageView)
        addSubview(descLabel)
        
        configureStepLabel()
        setStepLabelConstraints()
        configureNumberImageView()
        setNumberImageViewConstraints()
        configureTitleLabel()
        setTitleConstraints()
        setImageConstraints()
        configureDescLabel()
        setDescLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(step: Step) {
        stepLabel.text = "STEP"
        let imageName = "\(step.number).circle.fill"
        numberImageView.image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .semibold))
        stepTitle.text = step.title
        stepImageView.image = step.image
        descLabel.text = step.description
    }
  
    func configureStepLabel() {
        stepLabel.font = UIFont(name: K.SFProDisplay_Semibold, size: 15)
        stepLabel.textColor = UIColor(named: K.lightYellowGreen)
        stepLabel.sizeToFit()
    }
    
    func setStepLabelConstraints() {
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        stepLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingSpace).isActive = true
        stepLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    func configureNumberImageView() {
        numberImageView.tintColor = UIColor(named: K.lightYellowGreen)
    }
    
    func setNumberImageViewConstraints() {
        numberImageView.translatesAutoresizingMaskIntoConstraints = false
        numberImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        numberImageView.leadingAnchor.constraint(equalTo: stepLabel.trailingAnchor, constant: 2).isActive = true
        numberImageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    func configureTitleLabel() {
        stepTitle.font = UIFont(name: K.appleSDGothicNeo_Bold, size: 15)
    }
    
    func setTitleConstraints() {
        stepTitle.translatesAutoresizingMaskIntoConstraints = false
        stepTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        stepTitle.leadingAnchor.constraint(equalTo: numberImageView.trailingAnchor, constant: 6.0).isActive = true
        stepTitle.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    func setImageConstraints() {
        stepImageView.translatesAutoresizingMaskIntoConstraints = false
        stepImageView.topAnchor.constraint(equalTo: stepTitle.bottomAnchor, constant: 10.0).isActive = true
        stepImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingSpace).isActive = true
        stepImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // deal with ratio
        stepImageView.heightAnchor.constraint(equalToConstant:195).isActive = true
        stepImageView.widthAnchor.constraint(equalTo:stepImageView.heightAnchor, multiplier: 374/195).isActive = true
    }
    
    func configureDescLabel() {
        descLabel.font = UIFont(name: K.appleSDGothicNeo_Medium, size: 14)
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.sizeToFit()
    }
    
    func setDescLabelConstraint() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descLabel.topAnchor.constraint(equalTo: stepImageView.bottomAnchor, constant: 10.0).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingSpace).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leadingSpace).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
    }
}
