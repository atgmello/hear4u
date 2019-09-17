//
//  ViewController.swift
//  Hear4uApp
//
//  Created by Student on 12/09/19.
//  Copyright © 2019 USP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var audios = [Audio]()
    
    
    @IBOutlet weak var SeVazioAviso: UIView!
    
    @IBOutlet weak var TabelaUITable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabelaUITable.delegate = self
        TabelaUITable.dataSource = self
        
        audios = AppSingleton.shared.getDAOAudiosList()
        
        if audios.isEmpty {
            TabelaUITable.isHidden = true
            SeVazioAviso.isHidden = false
        
        } else {
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
}


