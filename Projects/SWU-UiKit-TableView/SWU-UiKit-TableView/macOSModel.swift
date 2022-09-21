import Foundation

struct MacOS {
    var name: String
    var version: String
}

extension MacOS {
    static func sampleData() -> [MacOS] {
        let ex1 = MacOS(name: "Snow Leopard", version: "10.6")
        let ex2 = MacOS(name: "Lion", version: "10.7")
        let ex3 = MacOS(name: "Panther", version: "10.3")
        return [ex1,ex2,ex3]
    }
}
