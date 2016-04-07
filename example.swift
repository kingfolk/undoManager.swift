//
//  example.swift
//
//  Created by Jialei Jin on 4/7/16.
//  Copyright © 2016 Jialei Jin. All rights reserved.
//
// Try example with undoManager.swift on playground.

var undoMgr = UndoManager<Void>()
var drawData: [Int] = []

// Two small func examples to show what you can do in a closures. It's more powerful than you think.
// The memory cost should be cheap. Because closure is store by reference but the captured varaible would be extra cost.
func getUndo() -> (()->Void) {
    return {()->Void in
        drawData.popLast()
    }
}
func getRedo() -> (()->Void) {
    // This capture could work as long as non-class type object. The point is pass-by-value and record the value to data
    let data = drawData.last
    return {()->Void in
        drawData.append(data!)
    }
}

func registerNewData(data: Int) {
    drawData.append(data)
    undoMgr.add(getUndo(), redo: getRedo())
}

registerNewData(3)
registerNewData(2)
registerNewData(6)
registerNewData(-2)

drawData
undoMgr.undo()
undoMgr.undo()
drawData

undoMgr.redo()
drawData

