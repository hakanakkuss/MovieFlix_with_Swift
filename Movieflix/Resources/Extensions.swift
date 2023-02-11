//
//  Extensions.swift
//  Movieflix
//
//  Created by Macbook Pro on 11.02.2023.
//

import Foundation

extension String {
    
    ///Bu fonksiyon section isimlerinin baş harflerini büyük geri kalanını küçük yapmak için kullanılmıştır.
    func capitalizeFirstLetter () -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
