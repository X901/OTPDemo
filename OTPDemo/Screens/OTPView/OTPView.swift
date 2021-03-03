////
//OTPView.swift
//PabdaOTP
//
//Created by Basel Baragabah on 02/03/2021.
//Copyright © 2021 Basel Baragabah. All rights reserved.
//

import SwiftUI

struct OTPView: View {
    // 5 minutes
    @State private var timeRemaining = 300
    @State private var isOtpMatching = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
    var body: some View {
        VStack {
            
            HStack {
                Text("Enter OTP")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                Spacer()
            }
            .padding(.leading)
            
            HStack {
                Text("We send you a code via SMS to verify your account, please enter it in the box below.")
                    .font(.body)
                Spacer()
            }
            .padding(.leading)
            .padding(.top,5)
            .padding(.bottom, 30)
            
            VStack {
                OTPTextFieldView { otp, completionHandler in

                    if otp == "1234" { // this could be a network call
                        completionHandler(true)
                        isOtpMatching = true
                    } else {
                        completionHandler(false)
                        isOtpMatching = false
                    }

                }
                
                
                Text(getTimer())
                    .padding()
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                    }
                
                Button(action: {
                    timeRemaining = 300
                }, label: {
                    Text("Request a new code")
                        .font(.callout)
                        .foregroundColor(.white)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal)
                
            }
            
        }.fullScreenCover(isPresented: $isOtpMatching, content: {
            HomeView()
        })
        
    }
    
    func getTimer() -> String{
        let minutes = Int(timeRemaining) / 60 % 60
        let seconds = Int(timeRemaining) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
