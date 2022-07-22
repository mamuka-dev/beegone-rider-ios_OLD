//
//  TableViewController.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation
import UIKit

open class TableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, TableCellDelegate, TableViewDataChangedprotocol{

    /// Child class should set these two properties.
    /// We are creating a constructor for now.
    public var model: TableViewModel!
    open var tableView: UITableView? { fatalError()}
    
    //View to show when there is no Data.
    open var noDataView: UIView{
        let v : NoDataView =  NoDataView.fromNib(from: Bundle(for: NoDataView.self))
        return v
    }
    
    // This method is called by the ViewModel when it changes the data
    open func onUnderlyingDataChanged(){ tableView?.reloadData()}
    
    /// Since iOS 13 Navigation Controller show child in model view that could be dismissed by the gestre.
    /// By default we are setting that if this is the initial launch user shoudl not be able to dismiss a controler
    open var allowGestureClose : Bool {return false}
    
    
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.delegate = self
        if #available(iOS 13, *){
            isModalInPopover = allowGestureClose
        }
    }
    
    open override func setupTheme() {
        super.setupTheme()
        tableView?.backgroundColor = nil
    }
    
    open override func setupUI() {
        registerXibs()
        tableView?.contentInset.bottom = 40
    }
    
    // MARK: TableView Overrides
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if(model.tableData.count == 0){
            noDataView.frame = UIScreen.main.bounds
            tableView.backgroundView  = noDataView
            tableView.separatorStyle  = .none
        } else {
            tableView.backgroundView = nil
        }
        
        return model.tableData.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.tableData[section].cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = model.tableData[indexPath.section]
        
        let data = section.cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.nibId, for: indexPath) as! TableCell
        cell.parentController = self
        cell.tableView = tableView
        cell.data = data
        cell.setupUI()
        cell.delegate = self
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let d = model.tableData[section]
        return d.headerViewHeight  == 0 ? CGFloat.leastNormalMagnitude : CGFloat(d.headerViewHeight)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let d = model.tableData[section]
        if(d.headerView == nil) { return nil }
        
        d.headerView!.model = model

        return d.headerView
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let d = model.tableData[section]
        return  d.footerViewHeight == 0 ? CGFloat.leastNormalMagnitude : CGFloat(d.footerViewHeight)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        if( section >= model.tableData.count ){ return nil}
        
        let d = model.tableData[section]
        if(d.footerView == nil) { return nil }
        
        d.footerView!.model = model
        d.footerView!.sectionData = d
        return d.footerView
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableCell
        cell.tapped()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func registerXibs(){}
    open func cellWasTapped(cell: TableCell, tag: String) {}
    
    
}
