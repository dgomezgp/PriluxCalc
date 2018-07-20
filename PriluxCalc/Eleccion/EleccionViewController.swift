//
//  EleccionViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 4/7/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

class EleccionViewController: UIViewController {
    
    var protocoloARecibir : Protocolo?
    
    var luminariaARecibir : Luminaria?
    
    @IBAction func luxesBoton(_ sender: Any) {
    }
    
    
    @IBAction func unidadesBoton(_ sender: Any) {
    }
    
    @IBAction func botonAyuda(_ sender: Any) {
        
        //Esto es para crear alertas
        //Crear una alerta
        //UIAlertController
        
        let alerta = UIAlertController(title: "Tutorial", message: "Elige que deseas calcular: \n -Unidades: Muestra el número de unidades necesarias para iluminar el lugar. \n -Luxes: Muestra el numero de luxes a razón del número de puntos de luz", preferredStyle: UIAlertControllerStyle.alert)
        //Creamos  Acciones (los botones)
        let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerta.addAction(accionCancelar)
        present(alerta, animated: true) {
            print("Alerta mostrada")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Elección"
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo-azul-2x")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "luxesSegue" {
                let eleccionAEnviar = "LUXES"
                let normativaAEnviar = protocoloARecibir
                let luminariaAEnviar = luminariaARecibir
                let destinationController = segue.destination as! CalcularLuxesViewController
                destinationController.protocoloARecibir = normativaAEnviar
                destinationController.luminariaARecibir = luminariaAEnviar
                destinationController.eleccionARecibir = eleccionAEnviar
        }
        
        if segue.identifier == "unidadesSegue" {
            let eleccionAEnviar = "UNIDADES"
            let normativaAEnviar = protocoloARecibir
            let luminariaAEnviar = luminariaARecibir
            let destinationController = segue.destination as! CalcularViewController
            destinationController.protocoloARecibir = normativaAEnviar
            destinationController.luminariaARecibir = luminariaAEnviar
            destinationController.eleccionARecibir = eleccionAEnviar
        }
        
    }
    

}
