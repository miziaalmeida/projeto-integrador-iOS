//
//  SelectedMovieController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 21/11/20.
//

import UIKit
import SnapKit

class CustomSegmentControl{
    
    var segmentindicator: UIView? = nil // view para a animação do segmentedControll
    
    
    
    // Funcão que faz a animição da barra conforme troca o segment
    func indexChangedSegmentControll(segmentedControll: UISegmentedControl, view:UIView){
        
        let numberOfSegments = CGFloat(segmentedControll.numberOfSegments)
        let selectedIndex = CGFloat(segmentedControll.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex)!.count))
        segmentindicator!.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControll.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + titlecount * 8)
            make.centerX.equalTo(segmentedControll.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex-1.0)*2.0))
        }
        
        UIView.animate(withDuration: 0.5) {
            view.layoutIfNeeded()
        }
    }
    
    
    // Funcão que customiza a segmentedControl
    func segmentControlCustom(custom:UISegmentedControl, view: UIView){
        
        
        custom.backgroundColor = .clear
        custom.tintColor = .clear
        custom.selectedSegmentTintColor = .clear
        
        // Setup da fonte na segmentedControl
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 21)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        segmentindicator = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // Cor da barra que mostra qual segment esta selecionado
            return v
        }()
        
        
        view.addSubview(segmentindicator!)
        segmentindicator!.snp.makeConstraints { (make) in
            make.top.equalTo(custom.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + custom.titleForSegment(at: 0)!.count * 8)
            make.centerX.equalTo(custom.snp.centerX).dividedBy(custom.numberOfSegments)
        }
    }
    
}
