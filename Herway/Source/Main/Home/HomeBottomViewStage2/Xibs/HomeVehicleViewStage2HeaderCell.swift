//
//  HomeVehicleViewStage2HeaderCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/20.
//

import UIKit

class HomeVehicleViewStage2HeaderCell: TableCell {

    @IBOutlet weak var theCollectionView: UICollectionView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet var theButtons: [UIButton]!
    
    var cellData: HomeVehicleViewStage2HeaderCellData {get {return data as! HomeVehicleViewStage2HeaderCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        self.registerXibs()
        self.theCollectionView.reloadData()
        var i = 0
        theButtons.forEach { btn in
            btn.tag = i
            btn.isHidden = true
            if cellData.getVehicleTypes.count > i {
                btn.isHidden = false
            }
            let type: VehicleType = cellData.getVehicleTypes[i]
            let theName = cellData.taxiServices.first { s in
                s.type == type.rawValue
            }
            
            btn.setTitle(type.title, for: .normal)
            i += 1
        }
        
//        i = 0
//        self.cellData.taxiServices.forEach { service in
//
//            if service.type == cellData.getSelectedType.rawValue {
//                theButtons[i].setTitle(service.name, for: .normal)
//            }
//            i += 1
//        }
        
        
        self.changeUnderlinePosition(for: cellData.getSelectedType)
        
    }
    
    func registerXibs() {
        
        theCollectionView.register(UINib(nibName: "HomeVehicleViewStage2HeaderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeVehicleViewStage2HeaderCollectionCell")
    }
    
    @IBAction func btnServiceTapped(_ sender: UIButton) {
        
        let type = cellData.getVehicleTypes[sender.tag]
        cellData.selectedType = type
        delegate?.cellWasTapped(cell: self, tag: "updateService")
    }
    
    func changeUnderlinePosition(for type: VehicleType){
            
        vwBottom.backgroundColor = .primaryColor
            var i = 0
            theButtons.forEach { (btn) in
                btn.tag = i
                btn.setTitleColor(.secondaryColor, for: .normal)
                i = i + 1
            }
            
            var underlineFinalXPosition = theButtons[0].frame.origin.x
            
        if type == .transportation{
            theButtons[0].setTitleColor(.primaryColor, for: .normal)
               underlineFinalXPosition = theButtons[0].frame.origin.x
                
        } else if type == .truck{
                theButtons[1].setTitleColor(.primaryColor, for: .normal)
               underlineFinalXPosition = theButtons[1].frame.origin.x
                
        } else if type == .delivery{
                theButtons[2].setTitleColor(.primaryColor, for: .normal)
               underlineFinalXPosition = theButtons[2].frame.origin.x
            }
            
            UIView.animate(withDuration: 0.1, animations: {
                self.vwBottom.frame.origin.x = underlineFinalXPosition
            })
        }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.changeUnderlinePosition(for: cellData.getSelectedType)
    }
    
}

class HomeVehicleViewStage2HeaderCellData: TableCellData {
    
    var taxiServices: [TaxiServicesResponse] = [TaxiServicesResponse]()
    var selectedService: TaxiServicesResponse
    var viewModel: HomeBottomViewStage2VM {get {return model as! HomeBottomViewStage2VM}}
    var selectedType: VehicleType = .transportation
    
    init(taxiServices: [TaxiServicesResponse], selectedService: TaxiServicesResponse) {
        
        self.taxiServices = taxiServices
        self.selectedService = selectedService
        super.init(nibId: "HomeVehicleViewStage2HeaderCell")
    }
    
    var getVehicleTypes: [VehicleType] {
        
        var allTypes: [VehicleType] = [VehicleType]()
        
        taxiServices.forEach { service in
            
            if let type = VehicleType(rawValue: service.type ?? "") {
                if !allTypes.contains(type) {
                    allTypes.append(type)
                }
            }
        }
        return allTypes
    }
    
    var getSelectedType: VehicleType {
        
        if let type = selectedService.type {
            return VehicleType(rawValue: type) ?? VehicleType.transportation
        }
        return VehicleType(rawValue: selectedService.type ?? "") ?? VehicleType.transportation
    }
}


extension HomeVehicleViewStage2HeaderCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.cellData.getVehicleTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVehicleViewStage2HeaderCollectionCell", for: indexPath) as! HomeVehicleViewStage2HeaderCollectionCell
        
        let currentType = self.cellData.getVehicleTypes[indexPath.row]
        
        let isSelected = self.cellData.getSelectedType.rawValue == currentType.rawValue
        
        cell.setupUI(title: currentType.title, showBottomView: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let type = cellData.getVehicleTypes[indexPath.row]
        cellData.selectedType = type
        delegate?.cellWasTapped(cell: self, tag: "updateService")
        
        print(indexPath)
    }
}

extension HomeVehicleViewStage2HeaderCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let currentType = self.cellData.getVehicleTypes[indexPath.row]
        let text = currentType.title
        
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:14.0)]).width + 24
        return CGSize(width: cellWidth, height: 35.0)
    }
}
