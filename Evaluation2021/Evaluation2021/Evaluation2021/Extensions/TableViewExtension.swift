//
//  TableViewExtension.swift
//  Evaluation2021
//
//  Created by Yashika on 2/13/21.
//  Copyright © 2021 Yashika. All rights reserved.
//
import UIKit

extension UICollectionViewCell: ReusableView {}

extension UITableViewCell: ReusableView {}

extension UITableViewHeaderFooterView: ReusableView {}

extension UITableView {
/// T : UITableViewCell
func register<T: UITableViewCell> (cell: T.Type) {
    let nib = UINib(nibName: T.nibName, bundle: nil)
    register(nib, forCellReuseIdentifier: T.reuseIdentifier)
}
}

// MARK: protocol extentions
protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}
