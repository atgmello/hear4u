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
        
        ref.child("someid").observe(.value) {
            (snapshot) in
            let employeeData = snapshot.value as? [String: String]
            print (employeeData)
            if let data = employeeData {
                self.alert(data["name"]!)
            }
        }
    }
    
    func alert(_ data: String) {
        let alert = UIAlertController(title: "Mensagem", message: data,         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            //Cancel Action
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
