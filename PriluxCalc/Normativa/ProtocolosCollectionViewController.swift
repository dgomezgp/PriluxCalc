//
//  ProtocolosCollectionViewController.swift
//  PriluxCalc
//
//  Created by David Gomez on 3/3/18.
//  Copyright © 2018 David Gomez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProtocolosCollectionViewController: UICollectionViewController {
    
    var protocolos:[Protocolo] = [Protocolo(nombre: "Calculo Libre", luxes: 0, distanciaSuelo: 0),
                                  Protocolo(nombre: "Oficina (Leer y Escribir)", luxes: 500, distanciaSuelo: 0.75),
                                  Protocolo(nombre: "Oficina (Poner y Copiar)", luxes: 300, distanciaSuelo: 0.75),
                                  Protocolo(nombre: "Despensa", luxes: 100, distanciaSuelo: 0),
                                  Protocolo(nombre: "Area de Trafico y Corredores", luxes: 100, distanciaSuelo: 0),
                                  Protocolo(nombre: "Vivir en Privado", luxes: 300, distanciaSuelo: 0.75)]

    var indexPathCollection = 0
    var luminariaARecibir: Luminaria?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.delegate = self
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return protocolos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaCollection", for: indexPath) as! CeldasProtocoloCollectionViewCell
    
        //Customizarla
        cell.nombreLabel.text = protocolos[indexPath.row].nombre
        cell.distanciaLabel.text = String(protocolos[indexPath.row].distanciaSuelo)
        cell.luxesLabel.text = String(protocolos[indexPath.row].luxes)
        cell.imageView.image = UIImage(named: "light-bulb" )
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
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
        
        if segue.identifier == "calcularSegue" {
            if indexPathCollection != -1 {
                let protocoloAEnviar = protocolos[indexPathCollection]
                let luminariaAEnviar = luminariaARecibir
                let destinationController = segue.destination as! CalcularViewController
                destinationController.protocoloARecibir = protocoloAEnviar
                destinationController.luminariaARecibir = luminariaAEnviar
            }
                
                
            
        }
        
        
    }
    
    
}
