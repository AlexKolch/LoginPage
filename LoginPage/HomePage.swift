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

///Устанавливает картинку
    var image: Image {
        Image(self.rawValue)
    }
}

struct HomePage: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State var showShoes = false
    @State var showDetail = false

    var body: some View {
        ZStack {
            Color(showDetail ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)).ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: showDetail)
            ///Main VStack
            VStack {
                Image("nike")
                    .resizable()
                    .frame(width: 125, height: 90)
                Spacer()
                ZStack {
                    Spacer()
                        .modifier(CustomModifierSpacer(showDetail: $showDetail))
                        .shadow(radius: 35)
                        .rotationEffect(.degrees(8))
                        .offset(x: 30, y: -30)
                        .padding(.top, 50)

                    Spacer()
                        .modifier(CustomModifierSpacer(showDetail: $showDetail))
                        .shadow(radius: 5)
                        .rotationEffect(.degrees(-8))
                        .offset(x: -30, y: -30)
                        .padding(.top, 50)
                    ///Основная плашка с товаром
                    ZStack {
                        Spacer()
                            .modifier(CustomModifierSpacer(showDetail: $showDetail))
                            .shadow(radius: 5)

                        VStack {
                            Image(viewModel.selectedShoes.rawValue).resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 265.0, height: 368.0)
                                .offset(y: 40)
                                .overlay {
                                    showDetail ? Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)).opacity(0.2) : Color(.clear)
                                }.animation(.easeInOut(duration: 0.1), value: showDetail)
                            Text(viewModel.selectedShoes.rawValue)
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .bold()
                                .offset(y: -65)
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
                Spacer()

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
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectedShoes = shoes
                                    }
                                    self.showShoes.toggle()
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }

            DetailView(viewModel: viewModel, showDetail: $showDetail)
                .offset(y: showDetail ? 0 : 600)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showDetail)
        }
    }
}

struct DetailView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Binding var showDetail: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 16.0) {

                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Man's Shoe").foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            Text(viewModel.selectedShoes.rawValue).bold()
                        }
                        Spacer()
                        Text("200$").bold().font(.system(size: 24))
                    }.padding(.horizontal)

                    Text("Select Size").font(.caption).padding(.horizontal)
                    ///Text размеров
                    VStack(alignment: .center, spacing: 8) {
                        //1 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 5.5").modifier(CustomModifierShoesSize())
                            Text("UK 6 (EU 39)").modifier(CustomModifierShoesSize())
                            Text("UK 6 (EU 40)").modifier(CustomModifierShoesSize())
                        }
                        //2 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 6.5").modifier(CustomModifierShoesSize())
                            Text("UK 7").modifier(CustomModifierShoesSize())
                            Text("UK 7.5").modifier(CustomModifierShoesSize())
                                .opacity(0.2)
                        }
                        //3 line
                        HStack(alignment: .center, spacing: 8) {
                            Text("UK 5.5").modifier(CustomModifierShoesSize())
                            Text("UK 6 (EU 39)").modifier(CustomModifierShoesSize())
                                .opacity(0.2)
                            Text("UK 6 (EU 40)").modifier(CustomModifierShoesSize())
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



