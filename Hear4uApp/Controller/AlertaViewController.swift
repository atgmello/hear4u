//
//  AlertaViewController.swift
//  Hear4uApp
//
//  Created by Student on 16/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AlertaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference()
        //ref.child("someid/name").setValue("Testes")
        
        ref.child("Alerta/Campainha").observe(.value, with: { (snapshot) in
            let employeeData = snapshot.value as? [String: AnyObject]
            if let employeeData = employeeData {
            
            if let data = employeeData["mensagem"] as? String {
                self.alert(data)
                //print(data)
                }
            }
        })
    }

    
    func alert(_ data: String) {
        
        let alert = UIAlertController(title: "Mensagem", message: data,         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            //Cancel Action
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}
