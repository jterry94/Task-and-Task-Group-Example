//
//  MathClass.swift
//  MathClass
//
//  Created by Jeff_Terry on 12/26/21.
//

import Foundation
import Swift

class MathClass :ObservableObject {
    
    @Published var calculationString = ""
    @Published var enableButton = true
    
    /// slowMath
    /// Uses Task and TaskGroup to thread the internals of a Loop so that they run concurrently
    /// Uses await to update the GUI upon completion.
    func slowMath() {
        
        
        
        Task{
            
            await updateGUI(text: "Start time \(Date())\n")
            
            
            let combinedResults = await withTaskGroup(of: (Int, String).self, /* this is the return from the taskGroup*/
                                                      returning: [(Int, String)].self, /* this is the return from the result collation */
                                                      body: { taskGroup in  /*This is the body of the task*/
                
                // We can use `taskGroup` to spawn child tasks here.
                
                
                for i in stride(from: 0, through: 25, by: 1){
                    
                    taskGroup.addTask {
                        
                        
                        //Create a new instance of the SlowCalculator object so that each has it's own calculating function to avoid potential issues with reentrancy problem
                        let resultText = await SlowCalculator().slowSum(i: i, addend1: Double.random(in: 0.0...100.0), addend2: Double.random(in: 0.0...100.0), randomSleep: UInt32(Int.random(in: 1...5)))
                        
                        await self.updateGUI(text: resultText)
                        
                        return (i, resultText)  /* this is the return from the taskGroup*/
                        
                    }
                    
                    
                }
                
                // Collate the results of all child tasks
                var combinedTaskResults :[(Int, String)] = []
                for await result in taskGroup {
                    
                    combinedTaskResults.append(result)
                }
                
                return combinedTaskResults  /* this is the return from the result collation */
                
            })
            
            
            //Do whatever processing that you need with the returned results of all of the child tasks here.
            
            await updateGUI(text: "End time \(Date())\n")
            
            await setButtonEnable(state: true)
            
            // Sort the results based upon the index of the result
            let sortedCombinedResults = combinedResults.sorted(by: { $0.0 < $1.0 })
            
            for item in sortedCombinedResults{
                
                // Display the sorted text in the GUI
                await updateGUI(text: "\(item.1)")
                
            }
            
        }
        
        
        
    }
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
            
            
            
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = false
                }
            }
            
        }
        
    }
    
    /// updateGUI
    /// This adds the text String to the text displayed in the GUI.
    /// This function runs on the Main Thread only
    /// - Parameter text: text to be added so that it can be displayed
    @MainActor func updateGUI(text:String){
        
        calculationString += text
        
    }
    
    
}


