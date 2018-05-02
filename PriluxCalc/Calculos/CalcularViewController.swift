//
//  CalcularViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 3/3/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

class CalcularViewController: UIViewController {
    
    
    
    
    var areaIluminanciaPorLuminaria : Double!
    
    var protocoloARecibir : Protocolo?
    
    var luminariaARecibir : Luminaria?
    
    var apertura : Double?
    
    @IBOutlet weak var anchuraLabel: UILabel!
    
    @IBOutlet weak var anchuraTextField: UITextField!
    
    @IBOutlet weak var longitudLabel: UILabel!
    
    @IBOutlet weak var longitudTextfield: UITextField!
    
    @IBOutlet weak var alturaLabel: UILabel!
    
    @IBOutlet weak var alturaTextfield: UITextField!
    
    @IBOutlet weak var distanciaSueloLabel: UILabel!
    
    @IBOutlet weak var distanciaSueloTextfield: UITextField!
    
    
    @IBOutlet weak var luxLabel: UILabel!
    
    
    @IBOutlet weak var luxTextfield: UITextField!
    
    var luxes : Double?
    var numeroLuminarias : Double?
    
    @IBOutlet weak var botonCalcular: UIButton!
    
    @IBAction func botonCalcular(_ sender: Any) {
        
        // llamamos a la funcion de calculo
         luxes = calcularLuxes()
         numeroLuminarias = calcularNumeroLuminarias()
        print(luxes)
        print(numeroLuminarias)
        print(luminariaARecibir?.apertura)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (protocoloARecibir?.luxes)
        print (protocoloARecibir?.distanciaSuelo)
        
        //Imprime en los textfield los valores traidos de los protocolos
        luxTextfield.text = String(describing: (protocoloARecibir?.luxes)!)
        distanciaSueloTextfield.text = String(describing: (protocoloARecibir?.distanciaSuelo)!)
        
       apertura = luminariaARecibir?.apertura

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    func calcularLuxes() -> Double {
        
        let grados = calcularGrados(apertura: apertura!)
        let radianes = calcularRadianes(grados: grados)
        let radio = calcularRadio(altura: Double(alturaTextfield.text!)!, radinanes: radianes)
        areaIluminanciaPorLuminaria = pow(radio, 2.0)
        let lumenes = 10250.0
        let resultadoSuelo = lumenes / areaIluminanciaPorLuminaria
        return resultadoSuelo
    }
   
    func calcularNumeroLuminarias() -> Double {
        
        let ancho = Double(anchuraTextField.text!)
        let alto = Double (longitudTextfield.text!)
        
        let resultado = (ancho! * alto!) / areaIluminanciaPorLuminaria
        return resultado
    }
    
    
    
    func calcularGrados(apertura: Double) -> Double{
        return apertura / 2
        
    }
    
    func calcularRadianes(grados: (Double)) -> Double {
        var resultado: Double
        let calculo = 2 * Double.pi
        let calculo2 = calculo / 360.0
        resultado = calculo2 * grados
        
        return resultado
    }
    

    
    func calcularRadio ( altura: Double,radinanes: Double) -> Double {
        
        let resultado = tan(radinanes) * (Double(altura) - Double(distanciaSueloTextfield.text!)!)
        
        print("Altura suelo:\(Double((protocoloARecibir?.distanciaSuelo)!))")
        
        return resultado
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "resultadoSegue" {
            
                let luxesAEnviar = luxes
                let luminariasAEnviar = numeroLuminarias
                let destinationController = segue.destination as! ResultadoViewController
                destinationController.luxesARecibir = luxesAEnviar
                destinationController.luminariasARecibir = luminariasAEnviar
            
            
            
        }
        
    }
    

}
