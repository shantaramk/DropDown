//
//  DropDownView.swift
//  DropDown
//
//  Created by Shantaram Kokate on 9/26/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
private let notificationCellIdentifier = "NotificationCell"
class DropDownView: UIView, DropDownModel {
    // MARK: - Properties
    //List ot item display dynamically
    var dataSource = [String]() {
        didSet {
            //updateUIViewFrame()
        }
    }
    
    // The view to which the drop down will appear on
    var anchorView: UIView!
    
    // The view height constaint
    var containerViewHeightAnchor: NSLayoutDimension?

    // MAKR: - Lazy loading view
    internal lazy var backgroundView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.12)
        return view
    }()
    internal lazy var containerView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2.0
        view.clipsToBounds = true
        return view
    }()
    lazy var notificationTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: notificationCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func updateUIViewFrame() {
        let count = dataSource.count * 48
        containerView.heightAnchor.constraint(equalToConstant: CGFloat(count)).isActive = true
       // setNeedsDisplay()
    }
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(anchorView : UIView) {
        self.init(frame: UIScreen.main.bounds)
        self.anchorView = anchorView

        setupUIView()
    }
    private func setupUIView() {
        
        setupBackgroundView()
        setupContainerView()
        setupTableView()
    }
    private func setupBackgroundView() {
        addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
        backgroundView.addGestureRecognizer(tapGesture)
    }
    private func setupContainerView() {
        backgroundView.addSubview(containerView)
 
        let d = anchorView
        let btnheight = d?.frame.height
        let btnWidth = d?.frame.width
        let btnx = d?.frame.origin.x
        let btny = d?.frame.origin.y
        
        anchorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: btnheight! + btny! + 1).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: btnx!).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: btnWidth!).isActive = true
        containerViewHeightAnchor = containerView.heightAnchor
         containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true


    }
    private func setupTableView() {
        containerView.addSubview(notificationTableView)
        notificationTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        notificationTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0).isActive = true
    }
    // MARK: - Action
    @objc func dismissView() {
        hide(animated:true)
    }
}
extension DropDownView : UITableViewDataSource {
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataSource.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:notificationCellIdentifier)
            cell?.textLabel?.text = dataSource[indexPath.row]
            return cell!
        }
}
extension DropDownView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide(animated:true)
    }
}
