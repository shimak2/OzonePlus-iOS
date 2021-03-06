//
//  Utill.swift
//  OzonePlus
//
//  Created by Ahamed Shimak on 10/25/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Util: NSObject {
    
    static let dimViewIdentifier = 22222
    
    static func displayActivityIndicator() {
        let window : UIView = (UIApplication.shared.delegate?.window!)!
        displayActivityIndicatorForView(view: window, actType: .ballPulse)
    }
    
    static func displayActivityIndicatorForImageView(view: UIView) {
        displayActivityIndicatorForView(view: view, actType: .lineScaleParty)
    }
    
    static func displayActivityIndicatorForView(view: UIView, actType: NVActivityIndicatorType) {
        let size = view.frame.size.width * 12 / 100
        let viewFrame = CGRect(x: 0, y: 0, width: size, height: size)
        let center = view.center
        
        let activityIndicator = NVActivityIndicatorView(frame: viewFrame, type: actType, color: UIColor.white, padding: NVActivityIndicatorView.DEFAULT_PADDING);
        activityIndicator.center = center
        activityIndicator.startAnimating()
        
        view.addSubview(addBlurView(view))
        view.addSubview(activityIndicator)
    }
    
    private static func addBlurView(_ inView : UIView) -> UIView {
        let bluredView = UIView()
        
        bluredView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //bluredView.alpha = 0.0
        bluredView.frame = inView.bounds
        bluredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bluredView.tag = dimViewIdentifier
        
        return bluredView
    }
    
    static func removeActivityIndicator() {
        let window : UIView = (UIApplication.shared.delegate?.window!)!
        
        removeIndicator(forView: window)
        removeDimView(view: window)
    }
    
    static func removeActivityIndicator(forView: UIView) {
        removeIndicator(forView: forView)
        removeDimView(view: forView)
    }
    
    static func removeIndicator(forView: UIView) {
        let subviews = forView.subviews.reversed()
        
        if let i = subviews.index(where: { $0.isKind(of: NVActivityIndicatorView.classForCoder()) }) {
            (subviews[i] as! NVActivityIndicatorView).stopAnimating()
        }
    }
    
    private static func removeDimView(view: UIView) {
        let subviews = view.subviews.reversed()
        
        if let i = subviews.index(where: { $0.tag == dimViewIdentifier }) {
            subviews[i].removeFromSuperview()
        }
    }
}
