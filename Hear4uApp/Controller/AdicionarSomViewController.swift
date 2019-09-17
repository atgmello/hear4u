//
//  AdicionarSomViewController.swift
//  Hear4uApp
//
//  Created by Student on 17/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdicionarSomViewController: UIViewController {

    @IBOutlet weak var NomeDoAudio: UITextField!
    
    
    @IBOutlet weak var AlertaDoSom: UITextField!
    
    

    @IBAction func AdicionarAudio(_ sender: UIButton) {
        
        let alerta = AlertaDoSom.text
        
        let nome = NomeDoAudio.text
        
        let ref = Database.database().reference()
        
        if let safeNome = nome, let safealerta = alerta{
            
            ref.child("Audios/\(safeNome)/alerta").setValue("\(safealerta)" )
            ref.child("Audios/\(safeNome)/nome").setValue("\(safeNome)" )
            
        }
        
        
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
