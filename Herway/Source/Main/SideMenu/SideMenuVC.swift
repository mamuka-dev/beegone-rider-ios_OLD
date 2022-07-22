//
//  SideMenuVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import UIKit
import SDWebImage

class SideMenuVC: TableViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var theTableView: UITableView!

    override var tableView: UITableView { return theTableView }
    private static let shared = SideMenuVC(currentItem: SideMenuItem.home)
    
    var viewModel: SideMenuVM { model as! SideMenuVM }
    
    var block: ((SideMenuItem)-> Void)? = nil
    
     init(currentItem: SideMenuItem) {
        super.init()
        model = SideMenuVM(currentItem: currentItem)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func handleSwipe(_ sender: Any){
        closeView {}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func registerXibs() {
        super.registerXibs()
        theTableView.register(R.nib.sideMenuCell)
    }
    
    static func show(parent: UIViewController, currentItem: SideMenuItem, block: @escaping (SideMenuItem)-> Void){
        shared.viewModel.currentItem = currentItem
        shared.viewModel.prepareData()
        shared.modalPresentationStyle = .overFullScreen
        shared.block = block
        shared.setupUI()
        
        //let parent = UIApplication.shared.delegate?.window??.rootViewController
        DispatchQueue.main.async {
            parent.present(shared, animated: false, completion: nil)
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
       
        block?(.profile)
         
         UIView.transition(with: UIApplication.window(),
                                  duration: 0.5,
                                  options: .transitionFlipFromLeft,
                                  animations: nil,
                                  completion: nil)
         closeView {}
        
    }
    
    @IBAction func btnDriveWithUsTapped(_ sender: Any) {
        
        CommunicationService.share(subject: R.string.localizable.downloadAppFromHere(), text: "", image: nil, url: URL(string: APP_STORELINK)) { success in
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        lblName.text = UserSession.shared.user?.name
        
        
    
    imgView.layer.borderWidth = 0
    imgView.layer.borderColor = UIColor.tint1.cgColor
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        self.view.backgroundColor = UIColor.primaryColor.withAlphaComponent(0.20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let imgStr = UserSession.shared.user?.photo
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr ?? "")")
        imgView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
        
        self.viewMain.frame.origin.x = -320
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            self.view.alpha = 1.0
            self.viewMain.frame.origin.x = 0
        }, completion: { finished in
        })
    }
 
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.closeView {}
    }
    
    @IBAction func btnEmptySpaceTapped(_ sender: Any) {
        closeView {}
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
        
        if let cellData = cell.data as? SideMenuCellData{
            
            if cellData.menuItem == viewModel.currentItem {
                closeView {}
            } else {
                animateAndClose(item: cellData.menuItem)
            }
        }
    }
    
    func animateAndClose(item: SideMenuItem) {
        
        block?(item)
         
         UIView.transition(with: UIApplication.window(),
                                  duration: 0.5,
                                  options: .transitionFlipFromLeft,
                                  animations: nil,
                                  completion: nil)
         closeView {}
    }
    
    func closeView(block: @escaping ()->Void){
       
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            self.view.alpha = 0.0
            self.viewMain.frame.origin.x = -320
        }, completion: { finished in
            self.dismiss(animated: false, completion: nil)
            block()
        })
    }
    
    func gotoView(with storyBoardName: String, identifier: String)  {
        
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let nav =  storyboard.instantiateViewController(withIdentifier: identifier) as! UINavigationController
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.set(rootViewController: nav, withTransition: nil)
            window.makeKeyAndVisible()
        }
        
    }
}
