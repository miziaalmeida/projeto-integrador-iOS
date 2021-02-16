//
//  CustomSegmentedControl.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 21/11/20.
//

import UIKit
import SnapKit

class CustomSegmentedControl{
    
    var segmentedIndicator: UIView? = nil // view para a animação do segmentedControll
    
    // Funcão que faz a animição da barra conforme troca o segmented
    func indexChangedSegmentedControl(segmentedControl: UISegmentedControl, view: UIView){
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!.count))
        segmentedIndicator!.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(60 + titlecount * 10)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex-1.0)*2.0))
        }
        
        UIView.animate(withDuration: 0.5) {
            view.layoutIfNeeded()
        }
    }
    
    
    // Funcão que customiza a segmentedControl
    func segmentedControlCustom(custom: UISegmentedControl, view: UIView){
        custom.backgroundColor = .clear
        custom.tintColor = .clear
        custom.selectedSegmentTintColor = .clear
        
        // Setup da fonte na segmentedControl
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 21)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        segmentedIndicator = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1) // Cor da barra que mostra qual segment esta selecionado
            return v
        }()
        
        view.addSubview(segmentedIndicator!)
        segmentedIndicator!.snp.makeConstraints { (make) in
            make.top.equalTo(custom.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(60 + custom.titleForSegment(at: 0)!.count * 10)
            make.centerX.equalTo(custom.snp.centerX).dividedBy(custom.numberOfSegments)
        }
    }
}
