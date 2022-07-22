//
//  HomeBottomViewStage3VC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage3VC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: HomeBottomViewStage3VM {get {return model as! HomeBottomViewStage3VM}}
    override var tableView: UITableView { return theTableView }
    var parentHome: HomeVC!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = HomeBottomViewStage3VM()
    }
    
    override func registerXibs() {
        super.registerXibs()
        theTableView.register(R.nib.homeBottomViewStage3Cell)
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }

    override func cellWasTapped(cell: TableCell, tag: String) {
        
        parentHome.currentState = .search
        parentHome.setupStates()
        
    }

}






