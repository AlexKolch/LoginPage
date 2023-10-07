//
//  ContentView.swift
//  LoginPage
//
//  Created by Алексей Колыченков on 29.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var index = 0 //Отвечает за выделенное Вью авторизации

    var body: some View {
        ///Проверка статуса авторизации
        VStack {
            if status {
                Home()
            } else {
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
                        ///Logo
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
        }.onAppear() {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - Домашняя страница
struct Home: View {
    var body: some View {
        VStack {
            Text("Home").fontWeight(.bold)
            Button {
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            } label: {
                Text("Logout")
            }
        }
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
//MARK: - SignIn View
struct Login: View {
    @State var email = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var showSignUp = false
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
                ///Button create account
                HStack {
                    Spacer(minLength: 0)

                    Button {
                        self.showSignUp.toggle()
                    } label: {
                        Text("Don't Have An Account?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }.padding(.horizontal)
                    .padding(.top, 30)
                    .sheet(isPresented: $showSignUp) {
                        SignUp(index: self.$index)
                    }
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
            ///Кнопка Login
            Button {
                signInWithEmail(email: self.email, password: self.pass) { verified, _ in
                    if !verified {
                        self.message = "Такой пользователь не зарегистрирован"
                        self.alert.toggle()
                        self.email = ""
                        self.pass = ""
                    } else {
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .padding(.horizontal, 50)
                    .background(Color.orange)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)
            }
            .offset(y: 24)
            .opacity(self.index == 0 ? 1 : 0)
        }.alert(isPresented: $alert) {

            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))

        }
    }
}

//MARK: - SignUp View
struct SignUp: View {
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var message = ""
    @State var showAlert = false
   // @Binding var showSignUp : Bool
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
            ///Кнопка Sign Up
            Button {
                signUpWithEmail(email: self.email, password: self.pass) { verified, status in
                    if self.repass != self.pass {
                        self.message = "The entered password does not match!"
                        self.showAlert.toggle()
                    } else if !verified {
                        self.message = status
                        self.showAlert.toggle()
                    } else {
                        UserDefaults.standard.set(true, forKey: "status")
                       // self.showSignUp.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
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
        }.alert(isPresented: $showAlert) {

            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))

        }
    }
}

//MARK: - Firebase func
///Вход в приложение
func signInWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { res, err in
        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }

        completion(true, (res?.user.email)!)
    }
}
///Регистрация в приложение
func signUpWithEmail(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { res, err in
        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }

        completion(true, (res?.user.email)!)
    }
}
