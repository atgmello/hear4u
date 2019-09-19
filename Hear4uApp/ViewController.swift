//
//  ViewController.swift
//  Hear4uApp
//
//  Created by Student on 12/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class ViewController: UIViewController {

    var audios = [Audio]()
    
    var ref:DatabaseReference!
    
    @IBOutlet weak var SeVazioAviso: UIView!
    
    @IBOutlet weak var TabelaUITable: UITableView!
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadAudios()
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        verifyTableEmpty()
        LoadAudios()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    
        
        TabelaUITable.delegate = self
        TabelaUITable.dataSource = self
        
        
        
        }
    
    func verifyTableEmpty() {
        if audios.isEmpty {
                TabelaUITable.isHidden = true
                SeVazioAviso.isHidden = false
                
            }
        else {
            TabelaUITable.isHidden = false
            SeVazioAviso.isHidden = true
            
        }
    }
    
}





extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audios.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        if let audioCell = cell as? CelulaDeAudio {
        
            
            let audios2 = audios[indexPath.row]
            
            //print("nome: \(audios2.nome)")
            
            audioCell.NomeDoAudio.text = audios2.nome
        
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "telaedicao", sender: audios[indexPath.row] )
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            audios.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "telaedicao" {
            
            if let EdicaoTela = segue.destination as? EdicaoTelaViewController{
                
                if let audioEdicao = sender as? Audio {
                    
                    EdicaoTela.audioEdicao = audioEdicao
                    
                    }
                }
        }
    }

    func LoadAudios() {
        
        
        ref = Database.database().reference()
        
        ref.child("Audios").observe(.value, with: { (snapshot) in
            
            self.audios.removeAll()
            
            
            let results = snapshot.value as? [String : AnyObject]
            
            if let results = results {
                
                for (_ , value) in results {
                    
                    if let alertaValue = value["alerta"] as? String, let fileValue = value["arquivodeaudio"] as? String, let nameValue = value["nome"] as? String {
                        
                        //print (nameValue)
                        //print (fileValue)
                        //print (alertaValue)
                        
                        let audio = Audio(nome: nameValue, arquivodeaudio: fileValue, alerta: alertaValue)
                        
                        self.audios.append(audio)
                        
                        //print(self.audios)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.TabelaUITable.reloadData()
                self.verifyTableEmpty()
            }
        })
    }
}



