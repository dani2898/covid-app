import Foundation

struct covidData: Codable{
    
    let cases: Int
    let deaths: Int
    let recovered: Int	
    let tests: Int
    let country: String
    let countryInfo: CountryInfo
    
    struct CountryInfo: Codable{
        let flag : String
    }
}
