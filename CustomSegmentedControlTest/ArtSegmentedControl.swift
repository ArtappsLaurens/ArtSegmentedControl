//
//  ArtSegmentedControl.swift
//  CustomSegmentedControlTest
//
//  Created by Laurens Biesheuvel on 27-09-17.
//  Copyright © 2017 Artapps. All rights reserved.
//

import UIKit

@IBDesignable class ArtSegmentedControl: UIControl {

    private var selector : UIView!
    private var borderWidth : CGFloat = 1
    private var buttons : [UIButton] = []
    var options : [String] = ["Placeholder 1", "Placeholder 2", "Placeholder 3"] {
        didSet {
            updateView()
        }
    }
    
    private var selection : Int = 0
    
    var value : Int {
        get {
            return selection
        }
        set (newValue) {
            selection = newValue
            updateView()
        }
        
    }
    
    @objc private func buttonPressed(sender: UIButton)
    {
        
        for (index, button) in buttons.enumerated()
        {
            if(button == sender)
            {
                selection = index
                sendActions(for: .valueChanged)
                button.setTitleColor(.white, for: .normal)
                button.isEnabled = false
                let selectorX = frame.width / CGFloat(options.count) * CGFloat(index)
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    self.selector.frame.origin.x = selectorX
                })
            }
            else
            {
                button.setTitleColor(tintColor, for: .normal)
                button.isEnabled = true
            }
            
        }
        
    }
    private func updateView() {
        buttons.removeAll()
        for subView in subviews {
            subView.removeFromSuperview()
        }
        for (index, option) in options.enumerated()
        {
            let newButton = UIButton(type: .custom)
            newButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            newButton.setTitle(option, for: .normal)
            
            if(index==selection)
            {
                newButton.setTitleColor(.white, for: .normal)
            }
            else
            {
                newButton.setTitleColor(tintColor, for: .normal)
            }
            newButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            buttons.append(newButton)
        }
        
        let selectorX = frame.width / CGFloat(options.count) * CGFloat(selection)
        selector = UIView(frame: CGRect(x: selectorX, y: 0, width: frame.width/CGFloat(options.count), height: frame.height))
        selector.layer.backgroundColor = tintColor.cgColor
        selector.layer.cornerRadius = frame.height / 2
        addSubview(selector)
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.borderWidth = borderWidth
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = frame.height / 2
        updateView()
    }
    

}
