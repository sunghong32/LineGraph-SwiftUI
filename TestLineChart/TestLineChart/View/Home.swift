//
//  Home.swift
//  TestLineChart
//
//  Created by 민성홍 on 2021/12/22.
//

import SwiftUI

struct Home: View {
    @Environment(\.verticalSizeClass) var sizeVClass

    let height = UIScreen.main.bounds.height / 3

    var body: some View {
        if sizeVClass == .regular {
            VStack {
                LineGraph(data: samplePlot)
                    .frame(height: height)


                AirUnderView()
                    .background(Color("lineColor"))

                Spacer()
            }
            .ignoresSafeArea(.all)
            .padding(.top, 60)
        } else {
            HStack {
                LineGraph(data: samplePlot)
                    .frame(height: height)


                AirUnderView()
                    .background(Color("lineColor"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

let samplePlot: [CGFloat] = [
    3, 5, 6, 6, 7, 8, 9, 12, 15, 16, 16, 19, 21, 24, 23, 21, 17, 17, 15, 15, 14, 12, 10, 10
]
