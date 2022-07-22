//
//  HomeBottomViewStage4RatingCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit
import Cosmos
import SDWebImage

class HomeBottomViewStage4RatingCell: TableCell {

    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var imgView: UIImageView!
    
    var cellData: HomeBottomViewStage4RatingCellData {get {return data as! HomeBottomViewStage4RatingCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr1 =  cellData.currentRequest.provider?.avatar
        let url1 = URL(string: "\(IMAGE_BASE_URL)\(imgStr1 ?? "")")
        imgView.sd_setImage(with: url1, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
        
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnRatingTapped(_ sender: Any) {
       
        let rating = vwRating.rating
        if rating < 1 {
            Utility.showLoaf(message: R.string.localizable.kindlyGiveRating(), state: .error)
        } else {
            cellData.rating = Int(rating)
            delegate?.cellWasTapped(cell: self, tag: "ratingRide")
        }
    }
    
}

class HomeBottomViewStage4RatingCellData: TableCellData {
    
    var rating: Int = 0
    var comments: String = ""
    var currentRequest: RideDetailResponseData
    init(currentRequest: RideDetailResponseData) {
        self.currentRequest = currentRequest
        super.init(nibId: "HomeBottomViewStage4RatingCell")
    }
}
