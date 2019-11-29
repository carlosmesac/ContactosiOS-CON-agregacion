//
//  DetailViewController.swift
//  ContactosiOS
//
//  Created by Ernestina Martel Jordán on 5/10/18.
//  Copyright © 2018 Ernestina Martel Jordán. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var fechaCumple: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let datos = self.datosDeContacto {
            if let nombre  = self.nombre {
                nombre.text = datos.nombre
            }
            if let direccion  = self.direccion {
                direccion.text = datos.direccion
            }
            if let telefono  = self.telefono {
                telefono.text = datos.telefono
            }
            if let fechaCumple  = self.fechaCumple {
                let fechaFormato = DateFormatter()
                fechaFormato.dateFormat = "dd/MM/yyyy"
                let fecha = fechaFormato.string(from: datos.fechaCumple as Date)
                fechaCumple.text = fecha
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var datosDeContacto: DatosDeContacto? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

