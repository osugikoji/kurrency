//
//  Icon.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

enum Icon: String, CaseIterable {
    case menu = "ic_menu"
    case refresh = "ic_refresh"
    case arrowLeft = "ic_arrow_left"
    case arrowDown = "ic_arrow_down"
    case swap = "ic_swap"
    case exchange = "ic_exchange"
    case settings = "ic_settings"
    case argentina = "ic_argentina"
    case brazil = "ic_brazil"
    case canada = "ic_canada"
    case chile = "ic_chile"
    case china = "ic_china"
    case colombia = "ic_colombia"
    case euro = "ic_euro"
    case japan = "ic_japan"
    case northKorea = "ic_north_korea"
    case southKorea = "ic_south_korea"
    case unitedStates = "ic_united_states"
    case uruguay = "ic_uruguay"
}

extension UIImage {
    
    public class var uruguay: UIImage {
        UIImage(named: Icon.uruguay.rawValue)!
    }
    
    public class var unitedStates: UIImage {
        UIImage(named: Icon.unitedStates.rawValue)!
    }
    
    public class var southKorea: UIImage {
        UIImage(named: Icon.southKorea.rawValue)!
    }
    
    public class var northKorea: UIImage {
        UIImage(named: Icon.northKorea.rawValue)!
    }
    
    public class var japan: UIImage {
        UIImage(named: Icon.japan.rawValue)!
    }
    
    public class var euro: UIImage {
        UIImage(named: Icon.euro.rawValue)!
    }
    
    public class var colombia: UIImage {
        UIImage(named: Icon.colombia.rawValue)!
    }
    
    public class var china: UIImage {
        UIImage(named: Icon.china.rawValue)!
    }
    
    public class var canada: UIImage {
        UIImage(named: Icon.canada.rawValue)!
    }
    
    public class var argentina: UIImage {
        UIImage(named: Icon.argentina.rawValue)!
    }
    
    public class var brazil: UIImage {
        UIImage(named: Icon.brazil.rawValue)!
    }
    
    public class var chile: UIImage {
        UIImage(named: Icon.chile.rawValue)!
    }
    
    public class var settings: UIImage {
        UIImage(named: Icon.settings.rawValue)!
    }
    
    public class var exchange: UIImage {
        UIImage(named: Icon.exchange.rawValue)!
    }
    
    public class var swap: UIImage {
        UIImage(named: Icon.swap.rawValue)!
    }
    
    public class var menu: UIImage {
        UIImage(named: Icon.menu.rawValue)!
    }
    
    public class var refresh: UIImage {
        UIImage(named: Icon.refresh.rawValue)!
    }
    
    public class var arrowDown: UIImage {
        UIImage(named: Icon.arrowDown.rawValue)!
    }
    
    public class var arrowLeft: UIImage {
        UIImage(named: Icon.arrowLeft.rawValue)!
    }
}

private struct IconSample: View {
    
    private let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Icon.allCases, id: \.self) {
                    Image($0.rawValue)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

internal struct IconSample_Previews: PreviewProvider {
    static var previews: some View {
        IconSample()
    }
}
