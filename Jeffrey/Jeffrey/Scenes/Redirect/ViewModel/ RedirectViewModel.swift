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
        
        return "https://www.netflix.com/search?q=\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
    }
    
    func searchInTelecinePlay(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "_")
        
        return "https://www.telecineplay.com.br/search?term=\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
 
    }
    
    func searchInNow(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.nowonline.com.br/busca?q=\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
 
    }
    
    func searchInDisney(movieName:String) -> String{
        return "https://www.disneyplus.com/pt-br"
 
    }
    
    func searchInClaroVideo(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.clarovideo.com/brasil/search?q=\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
 
    }
    
    func searchInLook(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.looke.com.br/search/\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
    }
    
    func searchInHBO() -> String{
        return "https://hbogo.com.br/home/br"
    }
    
    func searchInNetMovie(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "%20")
        
        return "https://www.netmovies.com.br/search/\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
    }
    
    func searchInGloboPlay(movieName:String) -> String{
        let str = movieName.replacingOccurrences(of: " ", with: "+")
        
        return "https://globoplay.globo.com/busca/?q=\(str  )".folding(options: .diacriticInsensitive, locale: .current) // retira acentos
    }
    
    func searchInApple() -> String{
        return "https://www.apple.com/br/apple-tv-plus/"
    }
    
    func searchInTnt() -> String{
        return "https://www.tntgo.tv/#!/catalogue/FILMES"
    }
    
    func searchInAmazonPrime() -> String{
        return "https://www.primevideo.com/"
    }
    
    
    
    
    

}
