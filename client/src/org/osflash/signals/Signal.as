package org.osflash.signals
{

/**
 * Allows the valueClasses to be set in MXML, e.g.
 * <LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9:Signal id="nameChanged">{[String, uint]}</LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9:Signal>
 */
[DefaultProperty("valueClasses")]

/**
 * Signal dispatches LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 to multiple listeners.
 * It is inspired by C# LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 and delegates, and by
 * <a target="_top" href="http://en.wikipedia.org/wiki/Signals_and_slots">LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9 and slots</a>
 * in Qt.
 * A Signal adds event dispatching functionality through composition and interfaces,
 * rather than inheriting from a dispatcher.
 * <br/><br/>
 * Project home: <a target="_top" href="http://github.com/robertpenner/as3-signals/">http://github.com/robertpenner/as3-signals/</a>
 */
public class Signal extends OnceSignal implements ISignal
{
   /**
    * Creates a Signal instance to dispatch value LOEBUILD_5891da2d64975cae48d175d1e001f5da.
    * @param	valueClasses Any number of class references that enable type checks in dispatch().
    * For example, new Signal(String, uint)
    * would allow: signal.dispatch("the Answer", 42)
    * but not: signal.dispatch(true, 42.5)
    * nor: signal.dispatch()
    *
    * NOTE: In AS3, subclasses cannot call super.apply(null, valueClasses),
    * but this constructor has logic to support super(valueClasses).
    */
   public function Signal(...valueClasses)
   {
      // Cannot use super.apply(null, valueClasses), so allow the subclass to call super(valueClasses).
      valueClasses = (valueClasses.length == 1 && valueClasses[0] is Array) ? valueClasses[0]:valueClasses;

      super(valueClasses);
   }

   /**
    * @inheritDoc
    * @throws flash.errors.IllegalOperationError <code>IllegalOperationError</code>: You cannot addOnce() then add() the same listener without removing the relationship first.
    * @throws ArgumentError <code>ArgumentError</code>: Given listener is <code>null</code>.
    */
   public function add(listener:Function):ISlot
   {
      return registerListener(listener);
   }
}
}