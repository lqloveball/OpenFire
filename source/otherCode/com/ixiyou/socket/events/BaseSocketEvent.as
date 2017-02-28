﻿package com.ixiyou.socket.events
{
	import flash.events.*;  
  
    public class BaseSocketEvent extends Event {  
          
        public static const SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;  
        public static const IO_ERROR:String = IOErrorEvent.IO_ERROR;  
        public static const DECODE_ERROR:String = "decode_error";  
		//接收到消息
        public static const RECEIVED:String = "received";  
        public static const SENDING:String = "sending";  
		
        public static const CLOSE:String = Event.CLOSE;  
        public static const CONNECT:String = Event.CONNECT;  
       
        private var _data:Object;  
          
        public function BaseSocketEvent(type:String, data:Object = null) {  
            super(type, true);  
            this._data = data;            
        }  
          
        public function get data():Object {  
            return _data;  
        }  
          
        override public function toString():String {  
            return formatToString("BaseSocketEvent", "type", "bubbles", "cancelable", "data");  
        }  
          
        override public function clone():Event {  
            return new BaseSocketEvent(type, data);  
        }  
    }  
}