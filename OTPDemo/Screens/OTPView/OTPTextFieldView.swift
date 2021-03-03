////
//PasscodeField.swift
//PabdaOTP
//
//Created by Basel Baragabah on 02/03/2021.
//Copyright © 2021 Basel Baragabah. All rights reserved.

//
import SwiftUI
import SwiftUIX

public struct OTPTextFieldView: View {
    
    var maxDigits: Int = 4
    
    @State var pin: String = ""
    @State var isDisabled = false

    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            ZStack {
                pinDots
                backgroundField
            }
        }
        
    }
    
    private var pinDots: some View {
        HStack(spacing:14) {
            ForEach(0..<maxDigits) { index in
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                    .padding()
                        .background(RoundedRectangle(cornerRadius: 5)            .stroke(Color(.lightGray), lineWidth: 0.5))
                        .frame(width: 60, height: 60)
                    
                    
                    Text(self.getDigits(at: index))
                        .font(.system(size: 50, weight: .thin, design: .default))
                }
                

            }
        }
        .padding(.horizontal)
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return CocoaTextField("", text: boundPin, onCommit: submitPin)
            .keyboardType(.numberPad)
            .isFirstResponder(true)
            .foregroundColor(.clear)
            .accentColor(.clear)

      

    }
    
    

    private func submitPin() {
        guard !pin.isEmpty else {
            return
        }
        
        if pin.count == maxDigits {
            isDisabled = true
            
            handler(pin) { isSuccess in
                if isSuccess {
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    pin = ""
                    isDisabled = false
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getDigits(at index: Int) -> String {
        if index >= self.pin.count {
            return ""
        }
        
            return self.pin.digits[index].numberString
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

struct PasscodeField_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView { otp, completionHandler in }
    }
}


