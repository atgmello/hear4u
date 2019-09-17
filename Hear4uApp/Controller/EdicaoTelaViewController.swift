//
//  EdicaoTelaViewController.swift
//  Hear4uApp
//
//  Created by Student on 16/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import FirebaseDatabase


class EdicaoTelaViewController: UIViewController {
    
    @IBOutlet weak var NomeTextField: UITextField!
    
    @IBOutlet weak var LabelTesteUILabel: UILabel!
    
    @IBOutlet weak var AlertaTextField: UITextField!
    
    
    @IBOutlet weak var Label2TextField: UILabel!
    
 
    @IBAction func EditarButton(_ sender: Any) {
        
        var audioEdicao: Audio?
        
        let alerta = AlertaTextField.text
        
        let nome = NomeTextField.text
        
        let ref = Database.database().reference()
        
        if let safeAudio = audioEdicao, let safeAlerta = alerta, let safeName = nome  {
            
            let updates = ["Audios/\(safeAudio.nome)/alerta": "\(safeAlerta)", "Audios/\(safeAudio.nome)/nome": "\(safeName)" ]
            ref.updateChildValues(updates)
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
