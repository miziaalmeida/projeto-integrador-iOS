//
//  ListViewModel.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

protocol ListViewModelProtocol: AnyObject {
//    func didTapSegmentedControl(segmentedControlList: UISegmentedControl, _ sender: UISegmentedControl, view: UIView)
    var viewController: ListViewControllerEvents? {get set}
}

class ListViewModel: ListViewModelProtocol{
    
    weak var viewController: ListViewControllerEvents?
    var customSegmentedControl = CustomSegmentedControl()
    
//    func didTapSegmentedControl(segmentedControlList: UISegmentedControl, _ sender: UISegmentedControl, view: UIView){
//        customSegmentedControl.indexChangedSegmentedControl(segmentedControl: segmentedControlList, view: view)
//        print(segmentedControlList.selectedSegmentIndex)
//    }
}
