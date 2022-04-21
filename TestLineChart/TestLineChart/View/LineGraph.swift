//
//  Home.swift
//  TestLineChart
//
//  Created by 민성홍 on 2021/12/22.
//

import SwiftUI

struct LineGraph: View {
    var data: [CGFloat]

    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot:Bool = false
    @State var translation : CGFloat = 0

    let sevenArr = [5,4,3,2,1]

    var body: some View {
        VStack {
            HStack {
                Text("24시간 변화")
                    .font(.system(size: 14, weight: .medium))

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 17) {
                    let max = data.max() ?? 0
                    let data = ((data.max() ?? 0) / 6)

                    Text("\(Int(max))")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("graphText"))

                    ForEach(sevenArr, id: \.self) { i in
                        Text("\(Int(data) * i)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("graphText"))
                    }

                    Text("0")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("graphText"))
                }
                .padding(.leading, 20)
                .padding(.trailing)

                ZStack {
                    VStack(spacing: 30) {
                        ForEach(0..<7) { _ in
                            Rectangle()
                                .fill(Color("lineColor"))
                                .frame(height: 1)
                        }
                    }
                    .padding(.trailing, 20)

                    GeometryReader { proxy in
                        let height = proxy.size.height
                        let width = (proxy.size.width) / CGFloat(data.count - 1)

                        let maxPoint = (data.max() ?? 0) + 0.1

                        let points = data.enumerated().compactMap { item -> CGPoint in
                            let progress = item.element / maxPoint

                            let pathHeight = progress * height

                            let pathWidth = width * CGFloat(item.offset)

                            return CGPoint(x: pathWidth, y: -pathHeight + height)
                        }

                        ZStack {
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 0))

                                path.addLines(points)
                            }
                            .strokedPath(StrokeStyle(lineWidth: 1.5))
                            .fill(Color("customBlue"))

                            FillBG()
                                .clipShape(
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: 0))

                                        path.addLines(points)

                                        path.addLine(to: CGPoint(x: proxy.size.width, y: height))

                                        path.addLine(to: CGPoint(x: 0, y: height))
                                    }
                                )
                        }
                        .overlay(
                            VStack(spacing: 0) {
                                Text(currentPlot)
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color("customBlue"), in: Capsule())
                                    .offset(x: translation > (proxy.size.width - 60) ? -10 : 0)
                                    .padding(.bottom, 40)

//                                Rectangle()
//                                    .fill(Color("customBlue"))
//                                    .frame(width: 1, height: 40)
//                                    .padding(.top)

                                Circle()
                                    .fill(Color("customBlue"))
                                    .frame(width: 22, height: 22)
                                    .overlay(
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 10, height: 10)
                                    )

//                                Rectangle()
//                                    .fill(Color("customBlue"))
//                                    .frame(width: 1, height: 50)
                            }
                                .frame(width: 80, height: 170)
                                .offset(y: 50)
                                .offset(offset)
                                .opacity(showPlot ? 1 : 0),
                            alignment: .bottomLeading
                        )
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                showPlot = true
                            }

                            let translation = value.location.x - 40

                            let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)

                            currentPlot = "\(data[index])"
                            self.translation = translation

                            offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                        }).onEnded({ value in
                            withAnimation {
                                showPlot = false
                            }
                        }))
                    }
                        .padding(.trailing, 20)
                }
            }

            HStack(spacing: 11) {
                ForEach(0..<24) { i in
                    if i % 2 == 0 {
                        Text("\(i)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("graphText"))
                    }
                }
            }
            .padding(.leading, 40)
        }
    }

    @ViewBuilder
    func FillBG() -> some View {
        LinearGradient(colors: [Color("customBlue").opacity(0.3),
                                Color("customBlue").opacity(0.2),
                                Color("customBlue").opacity(0.1)] + Array(repeating: Color.white.opacity(0.1), count: 1),
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
