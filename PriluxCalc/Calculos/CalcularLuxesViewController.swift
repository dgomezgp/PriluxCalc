//
//  CalcularViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 3/3/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

class CalcularLuxesViewController: UIViewController,UITextFieldDelegate {
    
    
    
    var areaIluminanciaPorLuminaria : Double!
    
    var protocoloARecibir : Protocolo?
    
    var luminariaARecibir : Luminaria?
    
    var eleccionARecibir : String?
    
    var apertura : Double?
    
    @IBOutlet weak var anchuraLabel: UILabel!
    
    @IBOutlet weak var anchuraTextField: UITextField!
    
    @IBOutlet weak var longitudLabel: UILabel!
    
    @IBOutlet weak var longitudTextfield: UITextField!
    
    @IBOutlet weak var alturaLabel: UILabel!
    
    @IBOutlet weak var alturaTextfield: UITextField!

    @IBOutlet weak var punLuzLabel: UILabel!
    
    
    @IBOutlet weak var punLuzTextfield: UITextField!
    
    @IBOutlet weak var distanciaSueloLabel: UILabel!
    
    @IBOutlet weak var distanciaSueloTextfield: UITextField!
    
    var luxes : Double?
    
    var puntosLuz : Double?
  
    var mantenimiento = 0.9
    
    
    //Esto recoge el dato del unwind
    var alturaCorregidaRecibida: Double? {
        willSet {
            let convertir = newValue
            let convertirAComa = convertirPuntoAComa(text: String(describing: (convertir)!))
            alturaTextfield.text = String(describing: (convertirAComa))
        }
    }
    
    var areaCorregida : Bool = false
    var areaCorregidaRecibida: Double? {
        willSet {
            areaIluminanciaPorLuminaria = newValue
            areaCorregida = true
        }
    }
    
    @IBOutlet weak var botonCalcular: UIButton!
    
    
    @IBAction func botonAyuda(_ sender: Any) {
        
        //Esto es para crear alertas
        //Crear una alerta
        //UIAlertController
        
        let alerta = UIAlertController(title: "Tutorial", message: "Introduce los datos solicitados para realizar el calculo", preferredStyle: UIAlertControllerStyle.alert)
        //Creamos  Acciones (los botones)
        let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alerta.addAction(accionCancelar)
        present(alerta, animated: true) {
            print("Alerta mostrada")
        }
        
    }
    
    @IBAction func botonCalcular(_ sender: Any) {
        
        //comprobamos que los campos no esten vacios
        if(comprobarCamposVacios() == true) {
            print ("HAY CAMPOS VACIOS")
        } else {
            // llamamos a la funcion de calculo
            luxes = calcularLuxes() * Kfactor() * mantenimiento
            print(luxes)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print (protocoloARecibir?.luxes)
        //print (protocoloARecibir?.distanciaSuelo)
        
        //Delegados
        alturaTextfield.delegate = self
        anchuraTextField.delegate = self
        longitudTextfield.delegate = self
        punLuzTextfield.delegate = self
        distanciaSueloTextfield.delegate = self

        
        
        apertura = luminariaARecibir?.apertura
        
        title = "Cálculos"
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo-azul-2x")!)
        
        distanciaSueloTextfield.text = convertirPuntoAComa(text: String(describing: (protocoloARecibir?.distanciaSuelo)!))
        
        if (protocoloARecibir?.nombre != "LIBRE") {

            distanciaSueloLabel.isHidden = true
            distanciaSueloTextfield.isHidden = true
            
        }
       

        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calcularLuxes() -> Double {
     
        puntosLuz = Double(punLuzTextfield.text!)!
        let lumenesPunto = convertirComa(text: String(describing: (luminariaARecibir?.lumenes)!))
        let lumenes = Double(lumenesPunto)
        let anchoPunto = convertirComa(text: anchuraTextField.text!)
        let ancho = Double(anchoPunto)!
        let largoPunto = convertirComa(text: longitudTextfield.text!)
        let largo = Double(largoPunto)!
       
        let resultado: Double =  (puntosLuz! * lumenes!) / (ancho * largo)
        print(resultado)
        return resultado
    }
    
    func Kfactor() ->Double {

        let anchoPunto = convertirComa(text: anchuraTextField.text!)
        let ancho = Double(anchoPunto)!
        let largoPunto = convertirComa(text: longitudTextfield.text!)
        let largo = Double(largoPunto)!
        let alturaPunto = convertirComa(text: alturaTextfield.text!)
        let altura = Double(alturaPunto)!
        let alturaSueloPunto = convertirComa(text: String(describing: (protocoloARecibir?.distanciaSuelo)!))
        let alturaSuelo = Double(alturaSueloPunto)!
        let resultado = ((ancho * largo) / ((altura - alturaSuelo) * (largo + ancho)))
        return resultado
    }

    
    func comprobarCamposVacios() -> Bool {
        
        if self.anchuraTextField.text?.isEmpty == true {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "Por favor rellena el campo Anchura", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.anchuraTextField.text == "0" {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Anchura tiene que se mayor que 0", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.anchuraTextField.text?.first == "," {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Anchura no es correcto", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        if self.longitudTextfield.text?.isEmpty == true {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "Por favor rellena el campo Longitud", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.longitudTextfield.text == "0" {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Longitud tiene que se mayor que 0", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.longitudTextfield.text?.first == "," {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Longitud no es correcto", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.alturaTextfield.text?.isEmpty == true {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "Por favor rellena el campo Altura", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.alturaTextfield.text == "0" {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Altura tiene que se mayor que 0", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.alturaTextfield.text?.first == "," {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Altura no es correcto", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.punLuzTextfield.text?.isEmpty == true {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "Por favor rellena el campo Puntos de Luz", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.punLuzTextfield.text == "0" {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Puntos de Luz tiene que se mayor que 0", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if self.distanciaSueloTextfield.text?.isEmpty == true {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "Por favor rellena el campo Distancia al Suelo", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        if self.distanciaSueloTextfield.text?.first == "," {
            
            
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El valor introducido en el campo Distancia al Suelo no es correcto", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        if Double(self.alturaTextfield.text!)! <= Double(self.distanciaSueloTextfield.text!)! {
            //Esto es para crear alertas
            //Crear una alerta
            //UIAlertController
            
            let alerta = UIAlertController(title: "Aviso", message: "El campo Altura no puede ser inferior o igual al campo Distancia al Suelo", preferredStyle: UIAlertControllerStyle.alert)
            //Creamos  Acciones (los botones)
            let accionCancelar = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alerta.addAction(accionCancelar)
            present(alerta, animated: true)
            return true
        }
        
        return false
        
    }
    
    // Comprobar que los campos usan numeros
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtenetworking = components.joined(separator: "")
        if filtenetworking == string {
            return true
        } else {
            if string == "," {
                let countdots = textField.text!.components(separatedBy:",").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "," {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    //Convertir comas en puntos y viceversa
    
    func convertirComa (text : String) -> String {
    let result = text.replacingOccurrences(of: ",", with: ".")
     print(result)
        return result
    }
    
    func convertirPuntoAComa (text : String) -> String {
        let result = text.replacingOccurrences(of: ".", with: ",")
        print(result)
        return result
    }
    
    //MARK: - SCROLLVIEW
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    
    //MARK: - Notificación telcado
    
    
    @objc func tecladoSeEstaMostrando(notificacion : NSNotification) -> Void{
        let tamanoTeclado = (notificacion.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.constraintBottomScroll.constant = (tamanoTeclado?.height)!
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    @objc func tecladoSeEstaOcultando(notificacion : NSNotification) -> Void {
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        })
        
    }
    
    
    //MARK: - Ciclo de vida
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Con estas lineas de código definimos a nuestro controller como observador de los eventos del teclado.
        NotificationCenter.default.addObserver(self, selector: #selector(self.tecladoSeEstaMostrando(notificacion:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.tecladoSeEstaOcultando(notificacion:)), name: .UIKeyboardWillHide, object: nil)
        
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        /*Es muy importante decirle a nuestro controller que deje de escuchar al teclado
         cuando este ya no esta siendo visible por el usuario, ya que si queremos definir a otro
         controller como observador, estos eventos se cruzaran y se ejecutaran en ambas clases.*/
        
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - TAPGestureRecognizer
    
    @IBAction func tapCerrarTeclado(_ sender: UITapGestureRecognizer) {
        
        /*Esta linea de código es usada para terminar cualquier edición
         que se encuentre realizando nuestro controller*/
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    // segue ResultadoViewController -> CalcularViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ResultadoLuxesViewController {
            alturaCorregidaRecibida = sourceViewController.alturaCorregidaParaEnviar
            areaCorregidaRecibida = sourceViewController.areaCorregidaParaEnviar
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "resultadoLuxesSegue" {
            
            let luxesAEnviar = luxes
            let luminariasAEnviar = puntosLuz
            let normativaAEnviar = protocoloARecibir
            let luminariaAEnviar = luminariaARecibir
            let destinationController = segue.destination as! ResultadoLuxesViewController
            destinationController.luxesARecibir = luxesAEnviar
            destinationController.luminariasARecibir = luminariasAEnviar
            destinationController.normativaARecibir = normativaAEnviar
            destinationController.luminariaARecibir = luminariaAEnviar
            
        }
        
    }
    
    
    
}

