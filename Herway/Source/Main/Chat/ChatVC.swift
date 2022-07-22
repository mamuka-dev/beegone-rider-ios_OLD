//
//  ChatVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/9.
//

import UIKit

class ChatVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: ChatVM {get {return model as! ChatVM}}
    override var tableView: UITableView { return theTableView }
    weak var timer: Timer?
    
    func initiaizeData(request: RideDetailResponseData) {
        model = ChatVM(request: request)
    }
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopTimer()
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            self?.viewModel.fetchData()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.chatCurrentUserCell)
        theTableView.register(R.nib.chatOtherUserCell)
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        txtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if let text = txtField.text {
            print(text)
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {

        if txtField.text == nil || txtField.text!.isEmpty {
            Utility.showLoaf(message: R.string.localizable.kindlyEnterMessage(), state: .error)
            return
        }
        let theMsg = self.txtField.text!
        self.view.endEditing(true)
        viewModel.sendMessage(msg: txtField.text!) { msg, success in
            if success {
                let msg = UserChatDataResponse(type: "", message: theMsg)
                self.txtField.text = ""
                self.viewModel.allMessages.append(msg)
                self.viewModel.prepareData()
                
            } else {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
        
        self.txtField.text = ""
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}
