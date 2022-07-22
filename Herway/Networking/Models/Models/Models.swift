//
//  Model.swift
//  OffSide
//
//  Created by Faizan Ali  on 2020/11/23.
//

import Foundation

struct VerificationCodeModel:Codable, CodableInit {
    let email:String
    let code:String
}

struct LoginModel:Codable, CodableInit {
    let email:String
    let password:String
}

struct ForgotPasswordModel:Codable, CodableInit {
    let email:String
}

struct resendCodeModel:Codable, CodableInit {
    let email:String
}

struct ResetPasswordModel:Codable, CodableInit {
    let email:String?
    let code:String
    let password:String
    let password_confirmation:String
}


struct InvoiceModel {
    
    var name: String? = nil
    var email: String? = nil
    var phone: String? = nil
    var currency: String? = nil
    var transactionType: String? = nil
    var customerRef: String? = nil
    var invoiceRef: String? = nil
    var street: String? = nil
    var country: String? = nil
    var state: String? = nil
    var city: String? = nil
    var cartDescription: String? = nil
    var invoiceData: [InvoiceData] = [InvoiceData]()
    var subTotal: String? = nil
    var extraDiscount: String? = nil
    var extraCharges: String? = nil
    var shippingCharges: String? = nil
    var totalAmount: String? = nil
    
    
    init() {
    }
}

struct InvoiceData {
    
    var desc: String? = nil
    var sku: String? = nil
    var unitPrice: String? = nil
    var quantity: String? = nil
    var discount: String? = nil
    var discountAmount: String? = nil
    var itemTax: String? = nil
    var taxTotal: String? = nil
    var item_total: String? = nil
    
    init() {
    }
}
