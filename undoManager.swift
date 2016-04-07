//
//  undoManager.swift
//
//  Created by king on 4/7/16.
//  Copyright © 2016 king. All rights reserved.
//

import Foundation

class UndoManager<U> {
    var pointer = -1;
    var stack: [[String: ()->U]] = []
    init() {
    }
    func add(undo: () -> U, redo: () -> U) {
        let dropNum:Int = stack.count - pointer - 1
        stack = Array(stack.dropLast(dropNum))
        stack.append(["undo": undo, "redo": redo])
        pointer = self.stack.count - 1;
    }
    func redo() -> U? {
        if (self.canRedo()) {
            if let lambda = stack[pointer+1]["redo"] {
                pointer += 1
                return lambda()
            }
        }
        return nil
    }
    func undo() -> U?{
        if (self.canUndo()) {
            if let lambda = stack[pointer]["undo"] {
                pointer -= 1
                return lambda()
            }
        }
        return nil
    }
    func canRedo() -> Bool {
        if (self.pointer < self.stack.count - 1) {
            return true
        }
        return false
    }
    func canUndo() -> Bool {
        if (self.pointer > -1) {
            return true
        }
        return false
    }
}
