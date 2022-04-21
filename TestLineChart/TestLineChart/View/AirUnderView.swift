//
//  AirUnderView.swift
//  TestLineChart
//
//  Created by 민성홍 on 2021/12/22.
//

import SwiftUI

struct AirUnderView: View {
    let tempCriteria = [11,15,19,23,26,30,35,38]

    var body: some View {
        VStack {
            HStack {
                Text("매우나쁨")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color("graphText"))

                Spacer()

                Text("좋음")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color("graphText"))

                Spacer()

                Text("매우나쁨")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color("graphText"))
            }

            GeometryReader { proxy in
                VStack {
                    ZStack {
                        Capsule()
                            .fill(Color("customRed"))
                            .frame(width: proxy.size.width, height: 7)

                        HStack(spacing: proxy.size.width / 7 * 3) {
                            Rectangle()
                                .fill(Color("customOrenge"))
                                .frame(width: proxy.size.width / 7, height: 7)

                            Rectangle()
                                .fill(Color("customOrenge"))
                                .frame(width: proxy.size.width / 7, height: 7)
                        }

                        HStack(spacing:  proxy.size.width / 7) {
                            Rectangle()
                                .fill(Color("customBlue"))
                                .frame(width:  proxy.size.width / 7, height: 7)

                            Rectangle()
                                .fill(Color("customBlue"))
                                .frame(width:  proxy.size.width / 7, height: 7)
                        }

                        Rectangle()
                            .fill(Color("customGreen"))
                            .frame(width: proxy.size.width / 7, height: 7)
                    }

                    HStack(spacing: proxy.size.width / 11.5) {
                        ForEach(tempCriteria, id: \.self) { i in
                            Text("\(i)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color("graphText"))
                        }
                    }
                }
            }
            .frame(height: 10)
            .padding(.bottom, 30)

            Divider()

            VStack(alignment: .leading) {
                Text("실내 적정온도 Tip")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.bottom)

                Text("일반적으로 가장 쾌적한 온도는 18도~20도이며 계절에 따라 쾌적온도의 차이가 발생합니다.")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.bottom)

                Text("지역의 이동이 있는 경우 실내 외 온도 차를 5도 이내로 유지해 주시면 건강관리에 도움이 됩니다.")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.bottom)

                Text("5도 이상 차이가 발생할 경우 냉방병, 난반병이 생길 수 있습니다.")
                    .font(.system(size: 14, weight: .regular))
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
}

struct AirUnderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
