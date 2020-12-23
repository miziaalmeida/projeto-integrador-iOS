//
//   RedirectViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 09/12/20.
//

import Foundation

class  RedirectViewModel{

    // Funções que formatam a url de abertura de cada streaming
    func searchInNetflix(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.netflix.com/search?q=\(str  )"
    }
    
    func searchInTelecinePlay(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.telecineplay.com.br/search?term=\(str  )"
 
    }
    
    func searchInNow(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.nowonline.com.br/busca?q=\(str  )"
 
    }

}
