//
//  TipViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

protocol TipViewControllerEvents: AnyObject{
    func present(controller: UIViewController)
    func push(controller: UIViewController)
}

class TipViewController: UIViewController {
    
    var gener: String = ""
    var stream: String = ""
    var selectedMovie = SelectedMovieViewController()
    
    @IBOutlet var buttonGenre: [UIButton]!
    @IBOutlet var buttonStreaming: [UIButton]!
    @IBOutlet var buttonNext: UIButton!
    
    private var viewModel: TipViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStreaming()
        self.viewModel = TipViewModel()
        self.viewModel?.viewController = self
        
    }
    
    @IBAction func actionButtonNext(_ sender: Any) {
        viewModel?.didTapNext()
    }
    
    @IBAction func actionButtonGenre(_ sender: UIButton) {
        viewModel?.didTapButtonGenre(button: buttonGenre, sender)
        
    }
    
    @IBAction func actionButtonStreaming(_ sender: UIButton) {
        viewModel?.didTapButtonStreaming(button: buttonStreaming, sender)
    }
    
    func setStreaming(){
        buttonStreaming.forEach{
            $0.isSelected = false
            $0.alpha = 0.3
        }
    }
}

extension TipViewController: TipViewControllerEvents{
    func present(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func push(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
