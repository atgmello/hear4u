//
//  AdicionarAudioViewController.swift
//  Hear4uApp
//
//  Created by Student on 17/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdicionarAudioViewController: UIViewController {

    @IBOutlet weak var NovoAlertaTextField: UITextField!
    
    @IBOutlet weak var NovoNomeUITextField: UITextField!
    
    @IBOutlet weak var BotaoEditarUIbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = Database.database().reference()
        
        ref.child("Audios/")
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
