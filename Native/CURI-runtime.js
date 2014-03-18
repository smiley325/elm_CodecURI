Elm.Native.CodecURI = {};
Elm.Native.CodecURI.make = function(elm) {

  elm.Native = elm.Native || {};
  elm.Native.CodecURI = elm.Native.CodecURI || {};
  if (elm.Native.CodecURI.values) return elm.Native.CodecURI.values;

  var JS = Elm.JavaScript.make(elm);

  function encodeURIFromString( uri) {
    return JS.toString( encodeURI( JS.fromString( uri)))
  }

  function encodeURIComponentFromString( uri) {
    return JS.toString( encodeURIComponent( JS.fromString( uri)))
  }

  function decodeURIFromString( uri) {
    return JS.toString( decodeURI( JS.fromString( uri)))
  }
  
  function decodeURIComponentFromString( uri) {
    return JS.toString( decodeURIComponent( JS.fromString( uri)))
  }
  
  return elm.Native.CodecURI.values = 
    {encodeURI:encodeURIFromString, 
     encodeURIComponent:encodeURIComponentFromString,
     decodeURI:decodeURIFromString, 
     decodeURIComponent:decodeURIComponentFromString,
    };
};
// --------------------------------------------------------------------

Elm.Native.CharExtra = {};
Elm.Native.CharExtra.make = function(elm) {

  elm.Native = elm.Native || {};
  elm.Native.CharExtra = elm.Native.CharExtra || {};
  if (elm.Native.CharExtra.values) return elm.Native.CharExtra.values;

  var JS = Elm.JavaScript.make(elm);
  
  var chr = function( i) {
    var x = new String( String.fromCharCode(i)) ;
    x.isChar = true;
    return x ;} ;
    
  var ord = function( c) {return c.charCodeAt(0) ;} ;

  return elm.Native.CharExtra.values = 
    {chr: chr, 
     ord: ord,
    };
};