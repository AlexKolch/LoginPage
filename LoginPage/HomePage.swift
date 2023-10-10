//
//  HomePage.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 08.10.2023.
//

import SwiftUI

enum Shoes: String, CaseIterable {
    case one = "Nike Air Jordan 1"
    case two = "Nike ISPA Link"
    case free = "NIKE AIR FLEA 2"
    case four = "NIKE METCON 9"
    case five = "NIKE AIR ZOOM GT HUSTLE 2"

    var image: Image {
        Image(self.rawValue)
    }
}

struct HomePage: View {
    @State var showl = true
    @State var show2 = false
    @State var showTop = false
    @State var showDetail = false

    var body: some View {
        ZStack {
            Color(showDetail ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)).ignoresSafeArea()
            ///Main stack
            VStack {
                Image("nike")
                    .resizable()
                    .frame(width: 125, height: 90)
                Spacer()
                ZStack {
                    Spacer()
                        .frame(width: 275.0, height: 368.0)
                        .background(showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
                        .cornerRadius(42)
                        .shadow(radius: 35, y: 20)
                        .rotationEffect(.degrees(8))
                        .offset(x: 30, y: -30)
                        .padding(.top, 50)

                    Spacer()
                        .frame(width: 275.0, height: 368.0)
                        .background(showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
                        .cornerRadius(42)
                        .shadow(radius: 5)
                        .rotationEffect(.degrees(-8))
                        .offset(x: -30, y: -30)
                        .padding(.top, 50)
///Основная плашка с товаром
                    ZStack {
                        Spacer()
                            .frame(width: 275.0, height: 368.0)
                            .background(showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
                            .cornerRadius(42)
                            .shadow(radius: 5)

                        VStack {

                                Image("Nike Air Jordan 1").resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 265.0, height: 368.0)
                                    .offset(y: 40)
                                    .overlay {
                                        showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) : Color(.clear)
                                    }
                                Text("Nike Air Jordan 1").foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    .bold()
                                    .offset(y: -75)

                        }
                    }
                }
                Spacer()

                Button {
                    self.showDetail.toggle()
                } label: {
                    Text("Buy now").foregroundColor(.white)
                        .frame(width: 169, height: 42)
                        .background(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)))
                        .cornerRadius(20)
                        .shadow(color: Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)).opacity(0.6), radius: 10, x: 10, y: 10)
                        .padding()
                }

                HStack {
                    Text("Favorites")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.leading)
                    Spacer()
                }

                ScrollView( .horizontal, showsIndicators: true) {
                    HStack(spacing: 15) {
                        ForEach(Shoes.allCases, id: \.self) { shoes in
                            shoes.image.resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
//                                .overlay(content: {
//                                    RoundedRectangle(cornerRadius: 25).strokeBorder(Color(.orange), lineWidth: 2)
//                                })
                                .onTapGesture {
                                    self.showDetail.toggle()
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }

            DetailView(showDetail: $showDetail)
                .offset(y: showDetail ? 0 : 600)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showDetail)
        }
    }
}

struct DetailView: View {
    @Binding var showDetail: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 16.0) {

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Man's Shoe").foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            Text("Nike Air Jordan 1").bold()
                        }
                        Spacer()
                        Text("300$").bold().font(.system(size: 24))
                    }.padding(.horizontal)

                    Text("Select Size").font(.caption).padding(.horizontal)
                    ///Text размеров
                    VStack(alignment: .center, spacing: 8) {
                        //1 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 5.5").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 39)").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 40)").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                        }
                        //2 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 6.5").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 7").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 7.5").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                                .opacity(0.2)
                        }
                        //3 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 5.5").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                            Text("UK 6 (EU 39)").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                                .opacity(0.2)
                            Text("UK 6 (EU 40)").font(.footnote)
                                .frame(width: 102, height: 41)
                                .background(Color(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)))
                                .cornerRadius(5)
                        }
                    }.padding(.leading, 30)

                    Button {
                        //Code
                    } label: {
                        Text("Add to bag").foregroundColor(.white)
                            .frame(width: 321, height: 44)
                            .background(Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)))
                            .cornerRadius(20)
                            .shadow(color: Color(#colorLiteral(red: 0.9803921569, green: 0.3921568627, blue: 0, alpha: 1)).opacity(0.6), radius: 10, y: 10)
                            .padding(.leading, 30)
                    }
                }.padding(.top, 10)
                    .frame(width: 383, height: 400)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: .black.opacity(0.2), radius: 20, y: 20)
            }

            Image(systemName: "xmark")
                .frame(width: 30, height: 30)
                .offset(x: 160, y: 12)
                .onTapGesture {
                    self.showDetail = false
                }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

extension Image: Hashable {
    var name: String {
        return ""
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


