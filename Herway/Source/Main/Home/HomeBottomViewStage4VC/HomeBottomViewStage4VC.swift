//
//  HomeBottomViewStage4VC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage4VC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: HomeBottomViewStage4VM {get {return model as! HomeBottomViewStage4VM}}
    override var tableView: UITableView { return theTableView }
    var parentHome: HomeVC!
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func initialize(request: RideDetailResponseData, estimatedPrice: EstimatedPriceResponse?) {
        model = HomeBottomViewStage4VM(request: request, estimatedPrice: estimatedPrice)
    }
    
    func initialize(popUpState: PopupState, estimatedPrice: EstimatedPriceResponse?, servicesResponse: TaxiServicesResponse? = nil) {
        model = HomeBottomViewStage4VM(request: nil, estimatedPrice: estimatedPrice, servicesResponse: servicesResponse)
        
        self.viewModel.popupState = popUpState
        self.viewModel.prepareData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerXibs() {
        super.registerXibs()
        theTableView.register(R.nib.homeBottomViewStage4HeaderCell)
        theTableView.register(R.nib.homeBottomViewStage4PromoCell)
        theTableView.register(R.nib.homeBottomViewStage4BottomCell)
        theTableView.register(R.nib.homeBookingInvoiceCell)
        theTableView.register(R.nib.homeBottomViewStage4RatingCell)
        theTableView.register(R.nib.homeEstimatedPriceCell)
        theTableView.register(R.nib.homeScheduleCell)
        theTableView.register(R.nib.homeBottomViewStage3Cell)
        theTableView.register(R.nib.homeServiceDetailCell)
        
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    
    func showScheduleDatePicker() {
        datePicker = UIDatePicker.init()
            datePicker.backgroundColor = UIColor.white
                    
            datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .dateAndTime
                    
            datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
            datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.parentHome.view.addSubview(datePicker)
                    
            toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: R.string.localizable.done(), style: .done, target: self, action: #selector(self.onDoneButtonClick))]
            toolBar.sizeToFit()
        self.parentHome.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
            
        if let date = sender?.date {
            let scheduleDate = date.toString(format: DateFormat.defaultDate.rawValue)
            let scheduleTime = date.toString(format: DateFormat.defaultTime.rawValue)
            print("Picked the date \(scheduleDate) \(scheduleTime)")
            parentHome.selectedScheduleDate = scheduleDate
            parentHome.selectedScheduleTime = scheduleTime
            
            let scheduleDate1 = date.toString(format: DateFormat.normalFormate.rawValue)
            
            viewModel.scheduleDate = "\(scheduleDate1) \(scheduleTime)"
            viewModel.prepareData()
        }
    }

    override func cellWasTapped(cell: TableCell, tag: String) {
        
        
        
        if let cellData = cell.data as? HomeBottomViewStage3CellData {
            
            if tag == "closePromo" {
                parentHome.showPopupState = .none
                parentHome.setupStates()
            } else {
                if let p = cellData.promoCode {
                    parentHome.applyPromoCode(promoCode: p) { msg, success in
                        if !success {
                            if let msg = msg {
                                Utility.showLoaf(message: msg, state: .error)
                            }
                        }
                        self.parentHome.showPopupState = .none
                        self.parentHome.setupStates()
                    }
                }
            }
            
        } else if let cellData = cell.data as? HomeBottomViewStage4RatingCellData {
            
            parentHome.rateTheRide(rating: cellData.rating, comment: cellData.comments)
        } else if tag == "endRide" {
            UserDefaults.standard.setHomeState(state: .initial)
            parentHome.setupStates()
        } else if tag == "CloseServiceDetail" {
            parentHome.showPopupState = .none
            parentHome.setupStates()
        } else if tag == "gotoRating" {
            UserDefaults.standard.setHomeState(state: .rating)
            parentHome.setupStates()
        } else if tag == "cancelRide" {
            parentHome.cancelTheRide()
            
        } else if tag == "payOnline" {
            parentHome.showPayOnlineView()
            
        } else if tag == "reloadHome" {
            parentHome.showPopupState = .none
            parentHome.setupStates()
            
        } else if tag == "scheduleDate" {
            self.showScheduleDatePicker()
        } else if tag == "scheduleDone" {
            parentHome.showPopupState = .none
//            parentHome.setupStates()
            if self.parentHome.selectedScheduleDate == nil {
                Utility.showLoaf(message: "Kindly select schedule Date!", state: .error)
                return
            }
            self.bookTaxi()
        }
    }
    
    func bookTaxi() {
        
        if self.parentHome.destinationLat == nil || self.parentHome.destinationLng == nil {
            Utility.showLoaf(message: R.string.localizable.kindlySelectDestination(), state: .error)
            return

        } else if self.parentHome.lblPickup.text == R.string.localizable.enterYourPickupLocation() {
            Utility.showLoaf(message: R.string.localizable.kindlySelectPickupLocation(), state: .error)
            return
        }
        
        UserDefaults.standard.setHomeState(state: .findingRide)
        self.parentHome.setupStates()
        parentHome.bookTaxi { msg, success in
            
            if success {
                print("Nice...")
            } else if let msg = msg {
                UserDefaults.standard.setHomeState(state: .search)
                self.parentHome.setupStates()
                Utility.showLoaf(message: msg, state: .error)
            }
        }
    }

}







