//
//  LuminariaCollectionViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 2/5/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LuminariaCollectionViewController: UICollectionViewController {
    
    var luminaria:[Luminaria] = [Luminaria(nombre: "Bura", lumenes: 100, apertura: 120),
                                  Luminaria(nombre: "Nigra", lumenes: 200, apertura: 120),
                                  Luminaria(nombre: "Livia", lumenes: 300, apertura: 120),
                                  Luminaria(nombre: "Argia", lumenes: 400, apertura: 120),
                                  Luminaria(nombre: "Hexagon", lumenes: 500, apertura: 120),
                                  Luminaria(nombre: "Avatar", lumenes: 600, apertura: 120)]
    
    var indexPathCollection = 0
    //JSON
    var luminariasDic = [[String:String]]()
    var urlAPIString = "http:www.grupoprilux.com/priluxcalc/test.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.delegate = self
        
        
        //JSON
        if let url = URL (string: urlAPIString) {
            
            if let data = try? Data(contentsOf: url) {
                let json = try? JSON(data:data)
                print(json ?? "No se han encontrado datos")
                //print(json!["NOMBRE"])
                print ("----------------------------------------")
                self.parse(json: json!)
                /*
                 
                 DispatchQueue.global(qos: .userInitiated).async {
                 if let url = URL (string: urlAPIString) {
                 
                 if let data = try? Data(contentsOf: url) {
                 let json = try? JSON(data:data)
                 print(json ?? "No se han encontrado datos")
                 print(json!["data"]["first_name"])
                 print ("----------------------------------------")
                 self.parse(json: json!)
                 
                 }
                 */
                
                
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: TRATAMIENTO CON JSON
    
    
    func parse (json:JSON) {
        //esto es para borrar el array para poder hacer otras busquedas
        luminariasDic.removeAll()
        for resultado in json[].arrayValue {
            //print ("resultado es \(resultado)")
            //print ("first name es \(resultado["first_name"].stringValue)")
            
            
            //Obetenemos los valores del json
            let nombre = resultado["NOMBRE"].stringValue
            let lumenes = resultado["LUMENES"].stringValue
            let apertura = resultado["APERTURA"].stringValue
            let foto = resultado["FOTO"].stringValue
            //print(resultado["NOMBRE"])
            //print(resultado["FOTO"])
            
            // Creamos un diccionario con todos los valores recogidos
            
            let dic = ["NOMBRE":nombre,"LUMENES":lumenes,"APERTURA":apertura,"FOTO":foto] as [String : String]
            
            
            //Añadimos este diccionario a nustro array de diccionarios (petitions)
            // append es para añadir en la utlima posicion de un array
            luminariasDic.append(dic)
            
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    }
    
    
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return luminariasDic.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaCollection", for: indexPath) as! LuminariaCollectionViewCell
        
        
        //Tratamiento de imagenes de producto
        let imagenString = luminariasDic[indexPath.row]["FOTO"]!
        if imagenString.isEmpty || imagenString == "" {
            cell.imagenContenedor.image = UIImage(named: "imagenNoDisponible")
            
        } else {
            // Cargar imagen desde una URL
            // creamos un objeto url para introducir la URL
            let urlACargar = URL(string: imagenString)
            // cogemos el contenido de una URL y lo convertimos a un objeto Data
            let data = try? Data(contentsOf: urlACargar!)
            //Cargamos el objeto data en el UIImage
            if (data == nil){
                cell.imagenContenedor.image = UIImage(named: "imagenNoDisponible")
            } else {
                cell.imagenContenedor.image = UIImage(data: data!)
            //redondea los bordes de la imagen
            //cell.imagenContenedor.layer.cornerRadius = 30.0
            //cell.imagenContenedor.clipsToBounds = true
            }
        
        }
        
        //Customizarla
        cell.nombreLuminariaLabel.text = luminariasDic[indexPath.row]["NOMBRE"]
        cell.lumenesLabel.text = luminariasDic[indexPath.row]["LUMENES"]
        cell.aperturaLabel.text = luminariasDic[indexPath.row]["APERTURA"]
        //cell.imagenContenedor.image = UIImage(named: "light-bulb" )
        cell.imagenContenedor.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imagenContenedor.layer.borderWidth = 2
        cell.imagenContenedor.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        indexPathCollection = indexPath.row
        
        return true
        
        
    }
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "normativaSegue" {
            if indexPathCollection != -1 {
                let luminariaAEnviar = luminaria[indexPathCollection]
                let destinationController = segue.destination as! ProtocolosCollectionViewController
                destinationController.luminariaARecibir = luminariaAEnviar
            }
            
            
            
        }
        
        
    }
    
    
}
