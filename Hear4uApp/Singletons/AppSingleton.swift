//
//  AppSingleton.swift
//  Hear4uApp
//
//  Created by Student on 16/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import Foundation

class AppSingleton
{
    static let shared = AppSingleton()
    
    func getDAOAudiosList() -> [Audio] {
        return [
            Audio(nome: "Microondas", arquivo_de_audio: "", alerta: "Sua comida esta pronta"),
            Audio(nome: "Campanhia", arquivo_de_audio: "", alerta: "Tem alguem na porta")
        ]
    }
}
