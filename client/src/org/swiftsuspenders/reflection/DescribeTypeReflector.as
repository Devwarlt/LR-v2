package org.swiftsuspenders.reflection {
import flash.utils.Dictionary;
import flash.utils.describeType;

import org.swiftsuspenders.InjectorError;
import org.swiftsuspenders.typedescriptions.ConstructorInjectionPoint;
import org.swiftsuspenders.typedescriptions.MethodInjectionPoint;
import org.swiftsuspenders.typedescriptions.NoParamsConstructorInjectionPoint;
import org.swiftsuspenders.typedescriptions.PostConstructInjectionPoint;
import org.swiftsuspenders.typedescriptions.PreDestroyInjectionPoint;
import org.swiftsuspenders.typedescriptions.PropertyInjectionPoint;
import org.swiftsuspenders.typedescriptions.TypeDescription;

public class DescribeTypeReflector extends ReflectorBase implements Reflector {

      private var _currentFactoryXML:XML;

      public function DescribeTypeReflector() {
         super();
      }

      public function typeImplements(param1:Class, param2:Class) : Boolean {
         var type:Class = param1;
         var superType:Class = param2;
         if(type == superType) {
            return true;
         }
         var factoryDescription:XML = describeType(type).factory[0];
         return factoryDescription.children().(name() == "implementsInterface" || name() == "extendsClass").(attribute("MsgType") == getQualifiedClassName(superType)).length() > 0;
      }

      public function describeInjections(param1:Class) : TypeDescription {
         this._currentFactoryXML = describeType(param1).factory[0];
         var _local2:TypeDescription = new TypeDescription(false);
         this.addCtorInjectionPoint(_local2,param1);
         this.addFieldInjectionPoints(_local2);
         this.addMethodInjectionPoints(_local2);
         this.addPostConstructMethodPoints(_local2);
         this.addPreDestroyMethodPoints(_local2);
         this._currentFactoryXML = null;
         return _local2;
      }

      private function addCtorInjectionPoint(param1:TypeDescription, param2:Class) : void {
         var injectParameters:Dictionary = null;
         var parameters:Array = null;
         var description:TypeDescription = param1;
         var type:Class = param2;
         var node:XML = this._currentFactoryXML.constructor[0];
         if(!node) {
            if(this._currentFactoryXML.parent().@name == "Object" || this._currentFactoryXML.extendsClass.length() > 0) {
               description.ctor = new NoParamsConstructorInjectionPoint();
            }
            return;
         }
         injectParameters = this.extractNodeParameters(node.parent().metadata.arg);
         var parameterNames:Array = (injectParameters.name || "").split(",");
         var parameterNodes:XMLList = node.parameter;
         if(parameterNodes.(@type == "*").length() == parameterNodes.@type.length()) {
            this.createDummyInstance(node,type);
         }
         parameters = this.gatherMethodParameters(parameterNodes,parameterNames);
         var requiredParameters:uint = parameters.required;
         delete parameters.required;
         description.ctor = new ConstructorInjectionPoint(parameters,requiredParameters,injectParameters);
      }

      private function extractNodeParameters(param1:XMLList) : Dictionary {
         var _local5:XML = null;
         var _local6:String = null;
         var _local2:Dictionary = new Dictionary();
         var _local3:uint = param1.length();
         var _local4:int = 0;
         while(_local4 < _local3) {
            _local5 = param1[_local4];
            _local6 = _local5.@key;
            _local2[_local6] = !!_local2[_local6]?_local2[_local6] + "," + _local5.attribute("value"):_local5.attribute("value");
            _local4++;
         }
         return _local2;
      }

      private function addFieldInjectionPoints(param1:TypeDescription) : void {
         var node:XML = null;
         var mappingId:String = null;
         var propertyName:String = null;
         var injectParameters:Dictionary = null;
         var injectionPoint:PropertyInjectionPoint = null;
         var description:TypeDescription = param1;
         for each(node in this._currentFactoryXML.*.(name() == "variable" || name() == "accessor").metadata.(@name == "Inject")) {
            mappingId = node.parent().@type + "|" + node.arg.(@key == "name").attribute("value");
            propertyName = node.parent().@name;
            injectParameters = this.extractNodeParameters(node.arg);
            injectionPoint = new PropertyInjectionPoint(mappingId,propertyName,injectParameters.optional == "true",injectParameters);
            description.addInjectionPoint(injectionPoint);
         }
      }

      private function addMethodInjectionPoints(param1:TypeDescription) : void {
         var node:XML = null;
         var injectParameters:Dictionary = null;
         var parameterNames:Array = null;
         var parameters:Array = null;
         var requiredParameters:uint = 0;
         var injectionPoint:MethodInjectionPoint = null;
         var description:TypeDescription = param1;
         for each(node in this._currentFactoryXML.method.metadata.(@name == "Inject")) {
            injectParameters = this.extractNodeParameters(node.arg);
            parameterNames = (injectParameters.name || "").split(",");
            parameters = this.gatherMethodParameters(node.parent().parameter,parameterNames);
            requiredParameters = parameters.required;
            delete parameters.required;
            injectionPoint = new MethodInjectionPoint(node.parent().@name,parameters,requiredParameters,injectParameters.optional == "true",injectParameters);
            description.addInjectionPoint(injectionPoint);
         }
      }

      private function addPostConstructMethodPoints(param1:TypeDescription) : void {
         var _local2:Array = this.gatherOrderedInjectionPointsForTag(PostConstructInjectionPoint,"PostConstruct");
         var _local3:int = 0;
         var _local4:int = _local2.length;
         while(_local3 < _local4) {
            param1.addInjectionPoint(_local2[_local3]);
            _local3++;
         }
      }

      private function addPreDestroyMethodPoints(param1:TypeDescription) : void {
         var _local2:Array = this.gatherOrderedInjectionPointsForTag(PreDestroyInjectionPoint,"PreDestroy");
         if(!_local2.length) {
            return;
         }
         param1.preDestroyMethods = _local2[0];
         param1.preDestroyMethods.last = _local2[0];
         var _local3:int = 1;
         var _local4:int = _local2.length;
         while(_local3 < _local4) {
            param1.preDestroyMethods.last.next = _local2[_local3];
            param1.preDestroyMethods.last = _local2[_local3];
            _local3++;
         }
      }

      private function gatherMethodParameters(param1:XMLList, param2:Array) : Array {
         var _local4:uint = 0;
         var _local7:XML = null;
         var _local8:String = null;
         var _local9:String = null;
         var _local10:* = false;
         var _local3:uint = 0;
         _local4 = param1.length();
         var _local5:Array = new Array(_local4);
         var _local6:int = 0;
         while(_local6 < _local4) {
            _local7 = param1[_local6];
            _local8 = param2[_local6] || "";
            _local9 = _local7.@type;
            _local10 = _local7.@optional == "true";
            if(_local9 == "*") {
               if(!_local10) {
                  throw new InjectorError("Error in method definition of injectee \"" + this._currentFactoryXML.@type + "Required LOEBUILD_166e64f6c3677d0c513901242a3e702d can\'t have MsgType \"*\".");
               }
               _local9 = null;
            }
            if(!_local10) {
               _local3++;
            }
            _local5[_local6] = _local9 + "|" + _local8;
            _local6++;
         }
         _local5.required = _local3;
         return _local5;
      }

      private function gatherOrderedInjectionPointsForTag(param1:Class, param2:String) : Array {
         var node:XML = null;
         var injectParameters:Dictionary = null;
         var parameterNames:Array = null;
         var parameters:Array = null;
         var requiredParameters:uint = 0;
         var order:Number = NaN;
         var injectionPointType:Class = param1;
         var tag:String = param2;
         var injectionPoints:Array = [];
         for each(node in this._currentFactoryXML..metadata.(@name == tag)) {
            injectParameters = this.extractNodeParameters(node.arg);
            parameterNames = (injectParameters.name || "").split(",");
            parameters = this.gatherMethodParameters(node.parent().parameter,parameterNames);
            requiredParameters = parameters.required;
            delete parameters.required;
            order = parseInt(node.arg.(@key == "order").@value);
            injectionPoints.push(new injectionPointType(node.parent().@name,parameters,requiredParameters,!!isNaN(order)?int.MAX_VALUE:order));
         }
         if(injectionPoints.length > 0) {
            injectionPoints.sortOn("order",Array.NUMERIC);
         }
         return injectionPoints;
      }

      private function createDummyInstance(param1:XML, param2:Class) : void {
         var constructorNode:XML = param1;
         var clazz:Class = param2;
         try {
            switch(constructorNode.children().length()) {
               case 0:
                  new clazz();
                  break;
               case 1:
                  new clazz(null);
                  break;
               case 2:
                  new clazz(null,null);
                  break;
               case 3:
                  new clazz(null,null,null);
                  break;
               case 4:
                  new clazz(null,null,null,null);
                  break;
               case 5:
                  new clazz(null,null,null,null,null);
                  break;
               case 6:
                  new clazz(null,null,null,null,null,null);
                  break;
               case 7:
                  new clazz(null,null,null,null,null,null,null);
                  break;
               case 8:
                  new clazz(null,null,null,null,null,null,null,null);
                  break;
               case 9:
                  new clazz(null,null,null,null,null,null,null,null,null);
                  break;
               case 10:
                  new clazz(null,null,null,null,null,null,null,null,null,null);
            }
         }
         catch(error:Error) {
            trace("Exception caught while trying to create dummy instance for constructor " + "injection. It\'s almost certainly ok to ignore this exception, but you " + "might want to restructure your constructor to prevent errors from " + "happening. See the Swiftsuspenders documentation for more details.\n" + "The caught exception was:\n" + error);
         }
         constructorNode.setChildren(describeType(clazz).factory.constructor[0].children());
      }
   }
}
