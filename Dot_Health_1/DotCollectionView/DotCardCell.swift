//
//  DotCardCell.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 08/06/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import UIKit
import Kingfisher
import TinyConstraints
protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
}
class DotCardCell: UICollectionViewCell, SelfConfiguringCell  {
    static var reuseIdentifier: String = "cardCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
//    lazy var activityIndicatorView: UIActivityIndicatorView = {
//        let aiv = UIActivityIndicatorView()
//        aiv.startAnimating()
//        return aiv
//    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Theme.mainFontName, size: 20)
        label.textColor = Theme.backgroundColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func setupView(){
        //configure Cell
        backgroundColor = Theme.backgroundColor
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.borderWidth = 1
        layer.insertSublayer(setGradient(hex: Theme.gradientColorDark!.hexValue, hex: Theme.gradientColorLight!.hexValue, frameSize: bounds), at: 0)
        layer.cornerRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0.2748524845, green: 0.4150594473, blue: 0.4139105678, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        clipsToBounds = true
        self.layer.masksToBounds = true
        //Setup cell
        addSubview(cardImageView)
        addSubview(nameLabel)
        cardImageView.edgesToSuperview(excluding: .bottom, insets: .left(45) + .right(45) + .top(15))
        cardImageView.height(contentView.bounds.height/2 - 60)
        nameLabel.topToBottom(of: cardImageView)
        nameLabel.edgesToSuperview(excluding: .top, insets: .left(5) + .right(5) + .bottom(5))
      
        
    }
    func setGradient(hex stringDark: String, hex StringLight: String, frameSize : CGRect) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(hex: stringDark).cgColor, UIColor(hex: StringLight).cgColor]
        gradient.locations = [0.5 , 1.2]
        gradient.startPoint = CGPoint(x: 0.6, y: 1.3)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.frame = frameSize
        return gradient
    }
}
