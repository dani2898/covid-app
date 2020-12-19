//
//  covidManager.swift
//  covid-app
//
//  Created by Mac13 on 15/12/20.
//

import Foundation

protocol covidManagerDelegate{
    func actualizarCovid(covid: CovidModelo)
    
    func huboError(cualError: Error)
}
	
struct covidManager {
    var delegado: covidManagerDelegate?
       
       let paisURL = "https://corona.lmao.ninja/v3/covid-19/countries/"

    func fetchCovid(nombrePais: String){
            let urlString = "\(paisURL)\(nombrePais)"
            
            print(urlString)
            
            realizarSolicitud(urlString: urlString)
        }
    
    func realizarSolicitud(urlString: String){
           //Crear url
           if let url = URL(string: urlString){
               //crear url session
               let session = URLSession(configuration: .default)
               
               //Asignar tarea a la sesión
               
               let tarea = session.dataTask(with: url)  {(data, respuesta, error) in
                   if error != nil {
                       self.delegado?.huboError(cualError: error!)
                       
                       return
                   }
                   
                   if let datosSeguros = data {
                       //Decodificar el objeto Json de la api
                    if let covid = self.parseJSON(CovidData: datosSeguros){
                           self.delegado?.actualizarCovid(covid: covid)
                       }
                   
                   }
               }
               
               //Empezar la tarea
               tarea.resume()
           }
           
           
       }
    
    func parseJSON(CovidData : Data) -> CovidModelo?{
            let decoder = JSONDecoder()
            do {
                let dataDecodificada = try decoder.decode(covidData.self, from: CovidData)
                
                let casos = dataDecodificada.cases
                let muertes = dataDecodificada.deaths
                let recuperados = dataDecodificada.recovered
                let pruebas = dataDecodificada.tests
                let bandera = dataDecodificada.countryInfo.flag
                let pais = dataDecodificada.country
                
                
                let objCovid = CovidModelo(casos: casos, muertes: muertes, recuperados: recuperados, pruebas: pruebas, bandera: bandera, pais: pais)
                
                return objCovid
                
            } catch  {
                self.delegado?.huboError(cualError: error)
                return nil
            }
           
        }
        
}
