//
//  ContentView.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 29.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State var index = 0 //Отвечает за выделенное Вью авторизации

    var body: some View {
        GeometryReader { _ in
            VStack() {
                Image("nike")
                .resizable()
                .frame(width: 270, height: 170)

                ZStack {
                    SignUp(index: self.$index)
                        .zIndex(Double(self.index))
                    Login(index: self.$index)
                }.offset(y: -40)

                HStack(spacing: 15) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 1)

                    Text("OR")

                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 1)
                }
                .padding(.horizontal, 50)
                .padding(.top, 15)

                HStack(spacing: 45) {
                    Button {
                        //Code
                    } label: {
                        Image("apple")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                    Button {
                        //Code
                    } label: {
                        Image("fb")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                    Button {
                        //Code
                    } label: {
                        Image("twitter")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }

                }
                .padding(.top, 18)
            }
            .padding(.vertical)
        }.background(Color.white)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//MARK: - CShapes
struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: -13))
        }
    }
}

struct CShape1: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: -12))
        }
    }
}
//MARK: - Login View
struct Login: View {
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10.0) {
                        Text ("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray) //Если первый экран показан, то цвет белый
                            .font(.title)
                            .fontWeight(.bold)

                        Capsule()
                            .fill(self.index == 0 ? .blue : .clear)
                            .frame(width: 100, height: 5)
                    }.offset(y: -20)
                    Spacer()
                }.padding(.top, 60)

                VStack {
                    HStack(spacing: 15.0) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.gray)
                        TextField("", text: $email, prompt: Text("Email Address").foregroundColor(.gray))
                            .foregroundColor(.white)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 40)
                    .offset(y: -5)

                VStack {
                    HStack(spacing: 15.0) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color.gray)
                        SecureField("", text: $pass, prompt: Text("Password").foregroundColor(.gray))
                            .foregroundColor(.white)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 40)

                HStack {
                    Spacer(minLength: 0)

                    Button {
                        //Code
                    } label: {
                        Text("Forget password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }.padding(.horizontal)
                    .padding(.top, 30)
            }.padding()
                .padding(.bottom, 65)
                .background(Color("Color1"))
                .clipShape(CShape()) //Скос
                .contentShape(CShape()) //Обрезать зону действия по форме
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: -5)
                .cornerRadius(35)
                .onTapGesture {
                    self.index = 0
                }
                .padding(.horizontal, 10)

            Button {
                //Code
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .padding(.horizontal, 50)
                    .background(Color.orange)
                    .clipShape(Capsule())
                    //.shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .offset(y: 24)
            .opacity(self.index == 0 ? 1 : 0)
        }
    }
}

//MARK: - SignUp View
struct SignUp: View {
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @Binding var index : Int

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)

                    VStack(spacing: 10.0) {
                        Text("SignUp")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)

                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }.offset(y: 5)
                }.padding(.top, 35)

                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        TextField("", text: $email, prompt: Text("Email Address").foregroundColor(.gray))
                            .foregroundColor(.white)

                    }
                    Divider().background(Color.white.opacity(0.5))
                }.padding()
                    .padding(.top, 30)

                VStack {
                    HStack(spacing: 15.0) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color.gray)
                        SecureField("", text: $pass, prompt: Text("Password").foregroundColor(.gray))
                            .foregroundColor(.white)
                    }

                    Divider().background(Color.white.opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 40)

                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.gray)
                        SecureField("", text: $repass, prompt: Text("Repeat password").foregroundColor(.gray))
                            .foregroundColor(.white)
                    }
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }.padding()
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: -5)
            .cornerRadius(35)
            .onTapGesture {
                self.index = 1
            }
            .padding(.horizontal, 10)

            Button {
                //Code
            } label: {
                Text("SignUp")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 60)
                    .background(Color.orange)
                    .clipShape(Capsule())
                    .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: -5)
            }
            .offset(y: 24)
            .opacity(self.index == 1 ? 1 : 0)
        }
    }
}
