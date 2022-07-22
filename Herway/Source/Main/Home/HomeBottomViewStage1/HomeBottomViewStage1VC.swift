//
//  HomeBottomViewStage1VC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/4.
//

import UIKit

class HomeBottomViewStage1VC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: HomeBottomViewStage1VM {get {return model as! HomeBottomViewStage1VM}}
    var parentHome: HomeVC!
    
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = HomeBottomViewStage1VM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.homeBottomViewStage1Cell)
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }

    override func cellWasTapped(cell: TableCell, tag: String) {
        
        if tag == "home" {
            
            UserDefaults.standard.setHomeState(state: .search)
            parentHome.shouldShowHomeAddress = true
            parentHome.shouldShowWorkAddress = false
            parentHome.setupStates()
        } else if tag == "pickup" {
            
            UserDefaults.standard.setHomeState(state: .search)
            parentHome.shouldShowWorkAddress = false
            parentHome.shouldShowHomeAddress = false
            parentHome.destinationLat = nil
            parentHome.destinationLng = nil
            parentHome.lblPickup.text = R.string.localizable.enterYourPickupLocation()
            parentHome.isPickupState = true
            parentHome.updateServiceType(for: VehicleType.delivery.rawValue)
            parentHome.setupStates()
        } else if tag == "work" {
            
            UserDefaults.standard.setHomeState(state: .search)
            parentHome.shouldShowWorkAddress = true
            parentHome.shouldShowHomeAddress = false
            parentHome.setupStates()
        } else {
            parentHome.destinationLat = nil
            UserDefaults.standard.setHomeState(state: .search)
            parentHome.shouldShowWorkAddress = false
            parentHome.shouldShowHomeAddress = false
            parentHome.setupStates()
        }
        
        
    }

}





