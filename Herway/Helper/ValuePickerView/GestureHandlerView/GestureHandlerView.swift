//
//  DatePickerProtocol.swift
//  imagePickerTask
//
//  Created by Faizan Ali on 25/10/2018.
//  Copyright © 2018 Faizan Ali. All rights reserved.
//

import UIKit

public class GestureHandlerView: UIView {

    var handlerArea: UIView
    var vwMain: UIView
    var cardHeight:CGFloat
    var cardHandleAreaHeight:CGFloat = 0
    var parent: UIView
    
    var gestureProtocol: GestureHandlerViewProtocol
    
    enum CardState {
        case expanded
        case collpased
    }

    var cardVisible = true
    var nextState:CardState {
        return cardVisible ? .collpased : .expanded
    }
    
    
    // Animation
    var animations:[UIViewPropertyAnimator] = []
    var currentAnimationProgress:CGFloat = 0
    var animationProgressWhenIntrupped:CGFloat = 0
    
    init(frame: CGRect, cardHeight: CGFloat, parent: UIView, theProtocol: GestureHandlerViewProtocol, vwMain: UIView, handlerArea: UIView) {
        self.cardHeight = cardHeight
        self.parent = parent
        self.gestureProtocol = theProtocol
        self.vwMain = vwMain
        self.handlerArea = handlerArea
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func panned(recognizer:UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            startIntractiveAnimation(state: nextState, duration: 0.9)
        case .changed:
            let translation =  recognizer.translation(in: self.handlerArea)
            let fractionCompleted = translation.y / cardHeight
            let fraction = cardVisible ? fractionCompleted : -fractionCompleted
            updateIntractiveAnimation(animationProgress: fraction)
        case .ended:

            continueAnimation(finalVelocity: recognizer.velocity(in: self.handlerArea))
        default:
            break
        }
        
    }
    
    func createAnimation(state:CardState,duration:TimeInterval) {
        
        guard animations.isEmpty else {
            print("Animation not empty")
            return
            
        }
        
        print("array count",self.animations.count)

        let cardMoveUpAnimation = UIViewPropertyAnimator.init(duration: duration, dampingRatio: 1.0) { [weak self] in
            guard let `self` = self else  {return}
            switch state {
            case .collpased:
                self.vwMain.frame.origin.y = self.frame.height - self.cardHandleAreaHeight
                
            case .expanded:
                self.vwMain.frame.origin.y = self.frame.height - self.cardHeight
            }
        }
        cardMoveUpAnimation.addCompletion { [weak self] _ in
            
            self?.cardVisible =  state ==  .collpased ? false : true
            if !self!.cardVisible{
                self?.gestureProtocol.onClose()
            }
            self?.animations.removeAll()
        }
        cardMoveUpAnimation.startAnimation()
        animations.append(cardMoveUpAnimation)
        
        let cornerRadiusAnimation = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
            switch state {
            case .expanded:
                self?.vwMain.layer.cornerRadius = 12
            case .collpased:
                self?.vwMain.layer.cornerRadius = 0
            }
        }
        cornerRadiusAnimation.startAnimation()
        animations.append(cornerRadiusAnimation)
        
        let visualEffectAnimation = UIViewPropertyAnimator.init(duration: duration, curve: .linear) { [weak self ] in
            switch state {
            case .expanded:
                self!.parent.backgroundColor = UIColor.tint1.withAlphaComponent(0.70)
            case .collpased:
                self?.backgroundColor = nil
            }
        }
        visualEffectAnimation.startAnimation()
        animations.append(visualEffectAnimation)
        
        
        
    }
    
    func startIntractiveAnimation(state:CardState,duration:TimeInterval) {
        if animations.isEmpty {
            createAnimation(state: state, duration: duration)
            // Create Animations
        }
        // Here we are pause the animation and get fraction Complete value and store it. so when use change the animation we can update animation.fractionComplete in next method
        for animation in animations {
            animation.pauseAnimation()
            animationProgressWhenIntrupped = animation.fractionComplete
        }
    }
    
    func updateIntractiveAnimation(animationProgress:CGFloat)  {
        for animation in animations {
       //     print(animationProgress + animationProgressWhenIntrupped)
            animation.fractionComplete = animationProgress + animationProgressWhenIntrupped
           // print(animation.fractionComplete)
        }
    }
    
    func continueAnimation (finalVelocity:CGPoint) {
        print(cardVisible == (finalVelocity.y < 0))
        
        
        if cardVisible == (finalVelocity.y < 0) {
            var completedFraction:CGFloat = 0
            for animation in animations {
                completedFraction = animation.fractionComplete
                animation.stopAnimation(true)

            }
            animations.removeAll()
            self.cardVisible =  !self.cardVisible
            self.createAnimation(state: nextState, duration: TimeInterval(completedFraction * 0.9))
            
        } else {
            for animation in animations {
                animation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                
            }
        }
    }
    

}


protocol GestureHandlerViewProtocol {
    
    func onClose()
}
