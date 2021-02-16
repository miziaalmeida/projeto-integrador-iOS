//
//  ListViewModel.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

protocol ListViewModelProtocol: AnyObject {
    var viewController: ListViewControllerEvents? {get set}
}

class ListViewModel: ListViewModelProtocol{
    
    weak var viewController: ListViewControllerEvents?
    var customSegmentedControl = CustomSegmentedControl()
}
