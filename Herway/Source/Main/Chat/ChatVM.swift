//
//  ChatVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/9.
//

import Foundation
import UIKit

class ChatVM: TableViewModel {
    
    var request: RideDetailResponseData
    var allMessages: [UserChatDataResponse] = [UserChatDataResponse]()
    
    init(request: RideDetailResponseData) {
        self.request = request
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        self.allMessages.forEach { msg in
            if msg.type == "" {
                if let msg = msg.message {
                    section.addCell(cellData: ChatCurrentUserCellData(text: msg))
                }
            } else {
                if let msg = msg.message {
                    section.addCell(cellData: ChatOtherUserCellData(text: msg))
                }
            }
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func fetchData() {
        
        self.getAllMessages { msg, success in
            self.prepareData()
        }
    }
    
    
    
    func sendMessage(msg: String, block: @escaping (String?, Bool)-> Void) {
        
        guard let bookingId = self.request.id else { return }
        guard let uid = self.request.userID else { return }
        guard let pid = self.request.providerID else { return }
        guard let type = self.request.serviceTypeID else { return }
        
//        ActivityIndicator.shared.showLoadingIndicator()
        Routes.sendChatMessage(booking_id: String(bookingId), uid: String(uid), pid: String(pid), message: msg, type: String(type)).send(UserSendChatResponse.self) { (result) in
            
//            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                block(error.localizedDescription, false)
            case .success(_):
                block(nil, true)
            }
        }
    }
    
    func getAllMessages(block: @escaping (String?, Bool)-> Void) {
        
        guard let bookingId = self.request.id else { return }
        
//        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getChat(requestId: String(bookingId)).send(UserChatResponse.self) { (result) in
            
//            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                block(error.localizedDescription, false)
            case .success(let response):
                
                self.allMessages.removeAll()
                if let chat = response.chat {
                    self.allMessages = chat
                }
                block(nil, true)
            }
        }
    }
    
    
    
}
