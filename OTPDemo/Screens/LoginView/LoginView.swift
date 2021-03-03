////
//ContentView.swift
//PabdaOTP
//
//Created by Basel Baragabah on 02/03/2021.
//Copyright © 2021 Basel Baragabah. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var showOTPView = false

    var body: some View {
        VStack {
            Button(action: {
                showOTPView.toggle()
            }, label: {
                Text("Login")
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 50)
                    .background(Color.white)

            })
            .padding()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)

            .overlay(
                GeometryReader { geometry in
                        BottomSheetView(
                            isOpen: self.$showOTPView,
                            maxHeight: geometry.size.height * 0.8
                        ) {
                            if showOTPView {
                            OTPView()
                            }
                        }
                }
            )
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
