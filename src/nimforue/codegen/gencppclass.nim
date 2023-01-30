import std/[sequtils, strutils, strformat, sugar, macros, genasts, os]
import ../../buildscripts/nimforueconfig
import ../codegen/[models, modulerules]
import ../utils/utils


  #no fields for now. They could be technically added though




func funParamsToStrSignature(fn:CppFunction) : string = fn.params.mapIt(it.typ & " " & it.name).join(", ")
func funParamsToStrCall(fn:CppFunction) : string = fn.params.mapIt(it.name).join(", ")

func `$`*(cppCls: CppClassType): string =
  func funcForwardDeclare(fn:CppFunction) : string = 
    let accessSpecifier = 
      case fn.accessSpecifier:
      of caPublic: "public"
      of caPrivate: "private"
      of caProtected: "protected"

    &"""
{accessSpecifier}:
  virtual {fn.returnType} {fn.name}({fn.funParamsToStrSignature()}) override;
  {fn.returnType} {fn.name}Super({fn.funParamsToStrSignature()}) {{ {cppCls.parent}::{fn.name}(); }}
    """
    
#     &"""
# {accessSpecifier}:
#   virtual {fn.returnType} {fn.name}({fn.funParamsToStrSignature()}) override {{}};
#     """
  
    
  let funcs = cppCls.functions.mapIt(it.funcForwardDeclare()).join("\n")
  let kind = if cppCls.kind == cckClass: "class" else: "struct"
  let parent = if cppCls.parent.len > 0: &"  : public {cppCls.parent}  " else: ""
 
  &"""
  DLLEXPORT {kind} {cppCls.name} {parent} {{
    {funcs}
  }};
  """

func `$`*(cppHeader: CppHeader): string =
  let includes = cppHeader.includes.mapIt(&"#include \"{it}\"").join("\n")
  let classes = cppHeader.classes.mapIt(it.`$`()).join("\n")
  &"""
#pragma once
{includes}
{classes}
  """



proc saveHeader*(cppHeader: CppHeader, folder: string = ".") =
  if OutputHeader == "": return #TODO assert when done
  let path = PluginDir / folder / cppHeader.name 
  writeFile(path,  $cppHeader)

#Not used for UETypes. Will be used in the future when supporting non UObject base types.
func createNimType(typedef: CppClassType, header:string): NimNode = 
  let ptrName = ident typeDef.name & "Ptr"
  let parent = ident typeDef.parent
  result = genAst(name = ident typeDef.name, ptrName, parent):
          type 
            name* {.inject, importcpp, header:header .} = object of parent #TODO OF BASE CLASS 
            ptrName* {.inject.} = ptr name

func toEmmitTemplate*(fn:CppFunction, class:string) : string  = 
  let comma = if fn.params.len > 0: "," else: ""
  let returns = if fn.returnType == "void": "" else: "return "
  &"""
    {fn.returnType} {class}::{fn.name}({fn.funParamsToStrSignature()}) {{
     {returns} {fn.name.firstToLow()}_impl(this {comma} {fn.funParamsToStrCall});
    }}
  """
#notice fn has params
func genSuperFunc*(fn:NimNode, class:string) : NimNode = 
  let superName = fn.name.strVal.capitalizeAscii() & "Super"
  let name = ident(superName)
  let nameLit = newStrLitNode(superName)
  let clsName = ident class & "Ptr"
  # let params = fn.params probably wont use genAst but just hijack the params, remember self is alredy here
  genAst(name, nameLit, clsName):
    proc super(self:clsName) : void {.importcpp:nameLit.}


func genOverride*(fn:NimNode, fnDecl : CppFunction, class:string) : NimNode = 
  let exportCppPragma =
    nnkExprColonExpr.newTree(
      ident("exportcpp"),
      newStrLitNode("$1_impl")#Import the cpp func. Not sure if the value will work across all the signature combination
    )
  #Adds the parameter to the nim function so we can call it
  fn.params.insert(1, nnkIdentDefs.newTree(ident "self", ident class & "Ptr", newEmptyNode()))
  fn.addPragma(exportCppPragma)
  fn.body.insert(0, genSuperFunc(fn, class))
  
  let toEmit = toEmmitTemplate(fnDecl, class)
  let override = 
    genAst(fn, toEmit):
      fn
      {.emit: toEmit.}
  result = override
  debugEcho result.repr

#TODO change this for macro cache
var cppHeader* {.compileTime.} = CppHeader(name: OutputHeader, includes: @["UEDeps.h"])
var emittedClasses* {.compileTime.} = newSeq[string]()

# func getOrCreateCppClass*(name, parent :string) : CppClass = 
#   let cls = cppHeader.classes.filterIt(it.name == name)
#   if cls.len > 0: cls[0]
#   else:
#     CppClass(name: name, kind: cckClass, parent: parent, functions: @[])

# const header = "UEGenClassDefs.h"
# static:
#   when defined(game):
#     cppHeader.includes.add header


#Only function overrides
func toCppClass*(ueType:UEType) : CppClassType = 
    case ueType.kind:
    of uetClass:
        CppClassType(name:ueType.name, kind: cckClass, parent:ueType.parent, functions: ueType.fnOverrides)
    of uetStruct: #Structs can keep inhereting from Nim structs for now. We will need to do something about the produced fields in order to gen funcs. 
        CppClassType(name:ueType.name, kind: cckStruct, parent:ueType.superStruct, functions: @[])
    else:
        error("Cant convert a non class or struct to a CppClassType")
        CppClassType() 

proc addCppClass*(class: CppClassType) =
  var class = class
  if class.parent notin (ManuallyImportedClasses & emittedClasses) and class.kind == cckClass:
    class.parent =  class.parent & "_" #The fake classes have a _ at the end we need to remove the emitted classes from here as well

  
  cppHeader.classes.add class
  saveHeader(cppHeader, "NimHeaders") #it would be better to do it only once






