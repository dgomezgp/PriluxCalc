//
//  ResultadoViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 3/3/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

class ResultadoLuxesViewController: UIViewController {
    
    @IBOutlet weak var luxesLabel: UILabel!
    
    @IBOutlet weak var resultadoLuxesLabel: UILabel!
    
    @IBOutlet weak var luminariasLabel: UILabel!
    
    @IBOutlet weak var resultadoLuminariasLabel: UILabel!
    
    @IBOutlet weak var recalcularBoton: UIButton!
    
    @IBOutlet weak var imagenContenedor: UIImageView!
    
    var luxesARecibir: Double?
    var luminariasARecibir: Double?
    var normativaARecibir: Protocolo?
    var luminariaARecibir: Luminaria?
    
    //valor enviado en el unwind
    
    var alturaCorregidaParaEnviar : Double?
    var areaCorregidaParaEnviar : Double?
    
    @IBAction func botonAyuda(_ sender: Any) {
        
        //Esto es para crear alertas
        //Crear una alerta
        //UIAlertController
        
        let alerta = UIAlertController(title: "Tutorial", message: "Muestra el resultado del calculo. \n Si tu eleccion no cumple la normativa pulsa el boton Recalcular y automaticamente te corregira la altura a la que debe estar la luminaria para poder cumplir la normativa vigente.", preferredStyle: UIAlertControllerStyle.alert)
        //Creamos  Acciones (los botones)
        let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerta.addAction(accionCancelar)
        present(alerta, animated: true) {
            print("Alerta mostrada")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Resultado"
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo-azul-2x")!)
        
        
        //Calculos para realizar si el calculo no cumple la normativa
        
        if (normativaARecibir?.nombre == "LIBRE") {
            resultadoLuxesLabel.text = String(Int(luxesARecibir!))
            let luminariasRedondeo = redondeo(numero: luminariasARecibir!)
            resultadoLuminariasLabel.text = "Necesitas \(String(Int(luminariasRedondeo))) unidades del producto: \n \((luminariaARecibir?.nombre)!)"
            recalcularBoton.isHidden = true
        } else {
            print ("Luxes Recibidos: \(luxesARecibir) tiene que ser mayor que \(normativaARecibir?.luxes) ")
            if (Double(luxesARecibir!) < Double((normativaARecibir?.luxes)!)) {
                recalcularBoton.isHidden = false
                alturaCorregidaParaEnviar = recalcular()
                resultadoLuxesLabel.text = " El resultado no cumple la normativa vigente"
                resultadoLuminariasLabel.text = " Por favor pulsa el boton recalcular"
                luminariasLabel.isHidden = true
                luxesLabel.isHidden = true
            } else {
                resultadoLuxesLabel.text = String(Int(luxesARecibir!))
                let luminariasRedondeo = redondeo(numero: luminariasARecibir!)
                resultadoLuminariasLabel.text = "Necesitas \(String(Int(luminariasRedondeo))) unidades del producto: \n \((luminariaARecibir?.nombre)!)"
                recalcularBoton.isHidden = true
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //realiza los calculos en el caso de que no cumpla normativa
    func recalcular () -> Double{
        print("Luxes normativa: \(normativaARecibir?.luxes)")
        print("Lumenes luminaria: \(luminariaARecibir?.lumenes)")
        let area = (luminariaARecibir?.lumenes)! / (normativaARecibir?.luxes)!
        areaCorregidaParaEnviar = area
        print ("Area: \(area)")
        let radio =  sqrt(area / Double.pi)
        print ("Radio: \(radio)")
        let resultado = radio / tan(Double((((luminariaARecibir?.apertura)!/2) / 360) * 2 ) * Double.pi)
        print("Altura para el recalculo:  \(resultado)")
        return resultado
    }
    
    //Redondea el resultado y en caso de que redonde a la baja suma uno para redondear a la alta
    func redondeo (numero : Double) -> Double {
        
        var resultado = round(numero)
        
        if resultado < numero {
            resultado = numero + 1
            round(resultado)
        }
        print ("REDONDEO: \(resultado)")
        return resultado
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
