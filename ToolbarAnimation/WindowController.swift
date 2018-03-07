//
//  WindowController.swift
//  ToolbarAnimation
//
//  Created by Markos Charatzas on 7/3/18.
//  Copyright © 2018 qnoid. All rights reserved.
//

import AppKit

class WindowController: NSWindowController, CALayerDelegate {

    static let spinAnimation: CAAnimation = {
        let basicAnimation = CABasicAnimation(keyPath:"transform.rotation")
        basicAnimation.fromValue = 2.0 * .pi
        basicAnimation.toValue = 0.0
        basicAnimation.duration = 1.0
        basicAnimation.repeatCount = Float.infinity
        
        return basicAnimation
    }()

    @IBOutlet weak var imageView: NSImageView! {
        didSet{
            let layer = CALayer()
            layer.contentsScale = 2.0
            layer.contentsGravity = "aspectFit"
            layer.contents = #imageLiteral(resourceName: "windmill")
            imageView.layer = layer
            imageView.wantsLayer = true
            imageView.layerContentsRedrawPolicy = .onSetNeedsDisplay
            imageView.layer?.delegate = self
            imageView.needsDisplay = true
        }
    }
    
    func display(_ layer: CALayer) {
        let frame = layer.frame
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.frame = frame
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    

        let key = "spinAnimation"
        
        self.imageView.layer?.add(WindowController.spinAnimation, forKey: key)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
            self.imageView.layer?.removeAnimation(forKey: key)
        }
    }
}
