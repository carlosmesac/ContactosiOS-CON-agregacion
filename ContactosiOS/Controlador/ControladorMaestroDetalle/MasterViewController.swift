//
//  MasterViewController.swift
//  ContactosiOS
//
//  Created by Ernestina Martel Jordán on 5/10/18.
//  Copyright © 2018 Ernestina Martel Jordán. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var controladorDatosDeContacto = DatosDeContactoController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: - Segues

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MuestraDetallesDelContacto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controladorVistaDetalle  = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controladorVistaDetalle.datosDeContacto = self.controladorDatosDeContacto.obtenerContacto(indice: indexPath.row)
                controladorVistaDetalle.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controladorVistaDetalle.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controladorDatosDeContacto.numeroDeContactos()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaDatosDeContacto", for: indexPath)

        let etiquetaNombre = cell.textLabel!
        let etiquetaNumero =  cell.detailTextLabel!
        
        if
            let datosDeContacto = controladorDatosDeContacto.obtenerContacto(indice: indexPath.row)
        {
             etiquetaNombre.text = datosDeContacto.nombre
             etiquetaNumero.text = datosDeContacto.telefono
        }else{
            etiquetaNombre.text = ""
            etiquetaNumero.text = ""
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
@IBAction func cancel(segue: UIStoryboardSegue) {
        if (segue.identifier == "retornaCancel") {    //cierra escena de agregación
            self.dismiss (animated: true, completion: nil) }
        
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
        if (segue.identifier == "retornaDone") {
            // obtener el controlador de agregación
            let controladorAgregacion =
                segue.source as! AgregacionViewController
            // obtener el nuevo contacto
            if let aux = controladorAgregacion.nuevoContacto {
                //agrega nuevo contacto a la lista
                controladorDatosDeContacto.agregarContacto(dato:aux) }
            // recarga la tabla
            self.tableView.reloadData()
            //cierra escena de agregación
            self.dismiss(animated:true, completion: nil)
        }
    }

    

}

