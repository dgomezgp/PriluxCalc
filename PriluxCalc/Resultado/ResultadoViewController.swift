//
//  ResultadoViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 3/3/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

class ResultadoViewController: UIViewController {
    
    @IBOutlet weak var luxesLabel: UILabel!
    
    @IBOutlet weak var resultadoLuxesLabel: UILabel!
    
    @IBOutlet weak var luminariasLabel: UILabel!
    
    @IBOutlet weak var resultadoLuminariasLabel: UILabel!
    
    var luxesARecibir: Double?
    var luminariasARecibir: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoLuxesLabel.text = String(luxesARecibir!)
        resultadoLuminariasLabel.text = String(luminariasARecibir!)
        
        title = "Resultado"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
