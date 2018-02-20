//
//  ViewController.swift
//  FloatingHearts
//
//  Created by anysome on 08/18/2017.
//  Copyright (c) 2017 anysome. All rights reserved.
//

import UIKit
import FloatingHearts

class ViewController: UIViewController {

    private struct HeartAttributes {
        static let heartSize: CGFloat = 36
        static let burstDelay = 0.1
    }
    
    var burstTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTheLove))
        view.addGestureRecognizer(tapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        longPressGesture.minimumPressDuration = 0.2
        view.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func didLongPress(longPressGesture: UILongPressGestureRecognizer) {
        switch longPressGesture.state {
        case .began:
            burstTimer = Timer.scheduledTimer(timeInterval: HeartAttributes.burstDelay, target: self, selector: #selector(showTheLove), userInfo: nil, repeats: true)
        case .ended, .cancelled:
            burstTimer?.invalidate()
        default:
            break
        }
    }
    
    @objc
    func showTheLove(gesture: UITapGestureRecognizer?) {
        let heart = HeartView(frame: CGRect(x:0, y:0, width:HeartAttributes.heartSize, height:HeartAttributes.heartSize))
        view.addSubview(heart)
        let fountainX = view.frame.width - 65
        let fountainY = view.bounds.height - HeartAttributes.heartSize / 2.0 - 10
        heart.center = CGPoint(x: fountainX, y: fountainY)
        heart.animateInView(view)
    }

}

