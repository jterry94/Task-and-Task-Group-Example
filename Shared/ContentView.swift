//
//  ContentView.swift
//  Shared
//
//  Created by Jeff_Terry on 12/26/21.
//

import SwiftUI
import Observation


struct ContentView: View {
    
    
    @Bindable var myMathClass = MathClass()
    
    var body: some View {
        VStack{
            TextEditor(text: $myMathClass.calculationString)
            Divider()
            Button("Begin Calculation", action: self.startCalculation)
                .disabled(myMathClass.enableButton == false)
        }
        
        
    }
    
    func startCalculation(){
        
        myMathClass.enableButton = false
        myMathClass.slowMath()
    }
    
    
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
