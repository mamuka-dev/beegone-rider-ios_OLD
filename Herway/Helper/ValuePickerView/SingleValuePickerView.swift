//
//  DatePickerProtocol.swift
//  imagePickerTask
//
//  Created by Faizan Ali on 25/10/2018.
//  Copyright © 2018 Faizan Ali. All rights reserved.
//

import UIKit

class SingleValuePickerView: UIView, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var handlerArea: UIView!
    @IBOutlet weak var vwBarHandler: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwMainLayoutHeight: NSLayoutConstraint!
    @IBOutlet weak var vwFooterSafeArea: UIView!
    @IBOutlet weak var vwFooterHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var tableViewBottomLayout: NSLayoutConstraint!
    
    var delegate: SingleValuePickerProtocol!
    var pickerTag: String? = nil
    var parent: UIViewController!
    var selectedValuesIndexes: Array<Int> = Array<Int>()
    var selectedUnitsIndexes: Array<Int> = Array<Int>()
    
    var config: SingleValuePickerConfiguration!
    
    static func show(config: SingleValuePickerConfiguration,
                     delegate: SingleValuePickerProtocol,
                     tag: String?,
                     parent: UIViewController)
    {
        let pv: SingleValuePickerView = UIView.fromNib()
        pv.delegate = delegate
        pv.parent = parent
        pv.pickerTag = tag
        pv.config = config
         
        
        
       pv.setUI()
        
        
        pv.frame = CGRect.init(x: 0, y: 0, width:  (UIApplication.shared.keyWindow?.frame.width)!, height:  (UIApplication.shared.keyWindow?.frame.height)!)
        UIApplication.shared.keyWindow?.addSubview(pv)
        
        
        pv.alpha = 0
        let originOfView = pv.vwMain.frame.origin.y
        pv.vwMain.frame.origin.y = parent.view.frame.size.height + 1
        
        UIView.animate(withDuration: 0.3, animations: {
            pv.alpha = 1
            pv.vwMain.frame.origin.y = parent.view.frame.size.height - originOfView
        }) { (completion) in
        }
        
    }
   
    
    private func setUI(){
        
        registerXib()
        setUpTheme()
        lblTitle.text = config.title
        setButtons()
        
        tableViewBottomLayout.constant = config.allowMultipleSelection ? 68 : 0
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(recognizer:)))
        handlerArea.addGestureRecognizer(panGestureRecognizer)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        downSwipe.direction = .down
        self.addGestureRecognizer(downSwipe)
        
        theTableView.reloadData()
    }
    
    @objc func handleSwipe(_ sender: Any){
        closeView()
    }
    
    func setButtons(){
        btnDone.isHidden = !config.allowMultipleSelection || selectedValuesIndexes.count == 0
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        
        delegate.userMultipleSelected(valuesIndexes: selectedValuesIndexes, unitIndexes: selectedUnitsIndexes, tag: pickerTag)
        self.closeView()
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        closeView()
    }
    
    func setUpTheme(){
        lblTitle.textColor = UIColor.secondaryColor.withAlphaComponent(0.50)
        vwBarHandler.backgroundColor = UIColor.tint1.withAlphaComponent(0.50)
        handlerArea.backgroundColor = .white
        vwFooterSafeArea.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if #available(iOS 11.0, *){
            vwMain.clipsToBounds = true
            vwMain.layer.cornerRadius = 24
            vwMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }else{
            let rectShape = CAShapeLayer()
            rectShape.bounds = vwMain.frame
            rectShape.position = vwMain.center
            rectShape.path = UIBezierPath(roundedRect: vwMain.bounds,
                                          byRoundingCorners: [.topRight , .topLeft],
                                          cornerRadii: CGSize(width: 24, height: 24)).cgPath
            vwMain.layer.mask = rectShape
        }

        var bottomSafeAreaHeight = 0
        if #available(iOS 11.0, *) {
            bottomSafeAreaHeight = Int(self.safeAreaInsets.bottom)
        }
        vwFooterHeight.constant = CGFloat(bottomSafeAreaHeight)

        var estimatedHeight = (config.values.count * 56) + (46 + Int(lblTitle.frame.size.height) + bottomSafeAreaHeight)
        if config.allowMultipleSelection{
            estimatedHeight += 68
        }
        var height = (self.frame.size.height/3) * 2

        if estimatedHeight < 200{
            height = 200
        } else if estimatedHeight < Int(height){
            height = CGFloat(estimatedHeight)
        }

        vwMainLayoutHeight.constant = height
    }
    
    @IBAction func btnNext(_ sender: Any) {
        delegate.userSelected(valueIndex: config.selectedValueIndex, unitIndex: config.selectedUnitIndex, tag: pickerTag)
        self.closeView()
    }
    
//    @IBAction func btnCross(_ sender: Any){
////        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
////            self.vwMain.frame.origin.y = self.parent.view.frame.size.height + 1
////        }, completion: { finished in
////        })
//
//        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
//            self.alpha = 0.0
//        }, completion: { finished in
////            App.shared.generateHapticFeedback()
//            self.removeFromSuperview()
//        })
//    }
    
    func closeView(){
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.vwMain.frame.origin.y = UIScreen.main.bounds.size.height + 1
                    self.alpha = 0.0
                }, completion: { finished in
                    self.removeFromSuperview()
                })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        config.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleValuePickerCell", for: indexPath) as! SingleValuePickerCell
        
        
        if config.allowMultipleSelection{
            let theIndex = selectedValuesIndexes.firstIndex { (index) -> Bool in
                index == indexPath.row                
            }
            
            cell.setupUI(value: config.values[indexPath.row], unit: config.units?[indexPath.row], isSelected: theIndex != nil, isAllowMultipleSelection: true)
            return cell
        }
        
        cell.setupUI(value: config.values[indexPath.row], unit: config.units?[indexPath.row], isSelected: false, isAllowMultipleSelection: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if config.allowMultipleSelection{
            
            let theIndex = selectedValuesIndexes.firstIndex { (index) -> Bool in
                index == indexPath.row
            }
            
            if theIndex != nil{
                selectedValuesIndexes.remove(at: theIndex!)
            } else{
                selectedValuesIndexes.append(indexPath.row)
            }
            
            let unitIndex = selectedUnitsIndexes.firstIndex { (index) -> Bool in
                index == indexPath.row
            }
            
            if unitIndex != nil{
                selectedUnitsIndexes.remove(at: theIndex!)
            } else{
                let unit = config.units?[indexPath.row]
                if unit != nil{
                    selectedUnitsIndexes.append(indexPath.row)
                }
            }
            setButtons()
            theTableView.reloadData()
            return
        }
        
        config.selectedValueIndex = indexPath.row
        let unit = config.units?[indexPath.row]
        if unit != nil{
            config.selectedUnitIndex = indexPath.row
        }
        
        delegate.userSelected(valueIndex: config.selectedValueIndex, unitIndex: config.selectedUnitIndex, tag: pickerTag)
        self.closeView()
    }
    
    func registerXib(){
        let nib = UINib.init(nibName: "SingleValuePickerCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "SingleValuePickerCell")
    }
    
    var cardHeight:CGFloat  {
        return vwMainLayoutHeight.constant
    }
    var cardHandleAreaHeight:CGFloat = 0
    
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
    
}




extension SingleValuePickerView{
    
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
                self?.closeView()
            }
            self?.animations.removeAll()
        }
        cardMoveUpAnimation.startAnimation()
        animations.append(cardMoveUpAnimation)
        
//        let cornerRadiusAnimation = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
//            switch state {
//            case .expanded:
//                break
////                self?.vwMain.layer.cornerRadius = 12
//            case .collpased:
//                break
////                self?.vwMain.layer.cornerRadius = 0
//            }
//        }
//        cornerRadiusAnimation.startAnimation()
//        animations.append(cornerRadiusAnimation)
        
        let visualEffectAnimation = UIViewPropertyAnimator.init(duration: duration, curve: .linear) { [weak self ] in
            switch state {
            case .expanded:
                self?.backgroundColor = UIColor.tint1.withAlphaComponent(0.70)
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


extension UIView {
    public class func fromNib<T: UIView>(from bundle: Bundle = Bundle.main) -> T {
        return bundle.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    public func takeScreenshot() -> UIImage? {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
            return image
    }
}
