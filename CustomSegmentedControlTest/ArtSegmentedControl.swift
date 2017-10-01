//
//  ArtSegmentedControl.swift
//  CustomSegmentedControlTest
//
//  Created by Laurens Biesheuvel on 01-10-17.
//  Copyright © 2017 Artapps. All rights reserved.
//

import UIKit

class ArtSegmentedControl: UIControl {

    private var borderWidth : CGFloat = 1
    private var stackView : UIStackView!
    private var selector : UIView!
    var options : [String] = ["Placeholder 1", "Placeholder 2", "Placeholder 3"] {
        didSet {
            setButtons()
        }
    }
    
    var value = 0 {
        didSet (newValue) {
            sendActions(for: .valueChanged)
            setButtons()
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        collectedInit()
        
    }
    
    func placeSelector() {
        let selectorX = frame.width / CGFloat(options.count) * CGFloat(value)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.selector.frame.origin.x = selectorX
        })
        
    }
    
    func collectedInit() {
        backgroundColor = .clear
        clipsToBounds = true
        selector = UIView(frame: CGRect.zero)
        selector.backgroundColor = tintColor
        addSubview(selector)
        layer.borderWidth = borderWidth
        setButtons()
        updateColor()
        
    }
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
        stackView.frame = bounds
        let selectorX = frame.width / CGFloat(options.count) * CGFloat(value)
        selector.frame = CGRect(x: selectorX, y: 0, width: frame.width/CGFloat(options.count), height: frame.height)
        selector.layer.cornerRadius = frame.height/2
    }
    
    @objc private func buttonPressed(sender: UIButton)
    {
        
        for (index, subview) in stackView.arrangedSubviews.enumerated() {
            let button = subview as! UIButton
            if(button==sender)
            {
                value = index
            }
        }
    }
    
    
    func setButtons() {

        if(stackView != nil)
        {
            stackView.removeFromSuperview()
        }
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        for (index, option) in options.enumerated() {
            let newButton = UIButton(type: .custom)
            newButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            newButton.setTitle(option, for: .normal)
            
            if(index==value)
            {
                newButton.setTitleColor(.white, for: .normal)
                newButton.isEnabled = false
            }
            else
            {
                newButton.setTitleColor(tintColor, for: .normal)
                newButton.isEnabled = true
            }
            newButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(newButton)
        }
        placeSelector()
        
    }
    
    func updateColor() {
        layer.borderColor = tintColor.cgColor
        selector.backgroundColor = tintColor
    }
    
    override func tintColorDidChange() {
        updateColor()
        setButtons()
    }
    
}

