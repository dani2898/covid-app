//
//  covidManager.swift
//  covid-app
//
//  Created by Mac13 on 15/12/20.
//

import Foundation

struct covidManager {
   // var delegado: covidManagerDelegate?
       
       let paisURL = "https://corona.lmao.ninja/v3/covid-19/countries/"

    func fetchCovid(nombrePais: String){
            let urlString = "\(paisURL)\(nombrePais)"
            
            print(urlString)
            
            //realizarSolicitud(urlString: urlString)
        }
}
