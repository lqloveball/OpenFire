/**
JSON.encode(object);
JSON.decode(string);1
*/
(function() {
    var hasOwn = Object.prototype.hasOwnProperty;
    var escapeable = /["\\\x00-\x1f\x7f-\x9f]/g;
    var meta = {
        '\b': '\\b',
        '\t': '\\t',
        '\n': '\\n',
        '\f': '\\f',
        '\r': '\\r',
        '"': '\\"',
        '\\': '\\\\'
    };
    function quoteString(string) {
        if (string.match(escapeable)) {
            return '"' + string.replace(escapeable, 
            function(a) {
                var c = meta[a];
                if (typeof c === 'string') {
                    return c
                };
                c = a.charCodeAt();
                return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16)
            }) + '"'
        };
        return '"' + string + '"'
    };
    JSON = {
        encode: function(obj) {
            if (obj === null) {
                return 'null'
            };
            var type = typeof obj;
            if (type === 'undefined') {
                return undefined
            };
            if (type === 'number' || type === 'boolean') {
                return '' + obj
            };
            if (type === 'string') {
                return quoteString(obj)
            };
            if (type === 'object') {
                if (obj.constructor === Date) {
                    var month = obj.getUTCMonth() + 1,
                    day = obj.getUTCDate(),
                    year = obj.getUTCFullYear(),
                    hours = obj.getUTCHours(),
                    minutes = obj.getUTCMinutes(),
                    seconds = obj.getUTCSeconds(),
                    milli = obj.getUTCMilliseconds();
                    if (month < 10) {
                        month = '0' + month
                    };
                    if (day < 10) {
                        day = '0' + day
                    };
                    if (hours < 10) {
                        hours = '0' + hours
                    };
                    if (minutes < 10) {
                        minutes = '0' + minutes
                    };
                    if (seconds < 10) {
                        seconds = '0' + seconds
                    };
                    if (milli < 100) {
                        milli = '0' + milli
                    };
                    if (milli < 10) {
                        milli = '0' + milli
                    };
                    return '"' + year + '-' + month + '-' + day + 'T' + hours + ':' + minutes + ':' + seconds + '.' + milli + 'Z"'
                };
                if (obj.constructor === Array) {
                    var ret = [];
                    for (var i = 0; i < obj.length; i++) {
                        ret.push(JSON.encode(obj[i]) || 'null')
                    };
                    return '[' + ret.join(',') + ']'
                };
                var name,
                val,
                pairs = [];
                for (var k in obj) {
                    if (!hasOwn.call(obj, k)) {
                        continue
                    };
                    type = typeof k;
                    if (type === 'number') {
                        name = '"' + k + '"'
                    } else if (type === 'string') {
                        name = quoteString(k)
                    } else {
                        continue
                    };
                    type = typeof obj[k];
                    if (type === 'function' || type === 'undefined') {
                        continue
                    };
                    val = JSON.encode(obj[k]);
                    pairs.push(name + ':' + val)
                };
                return '{' + pairs.join(',') + '}'
            }
        },
        decode: function(src) {
            if (src != null && src != '' && src != undefined) {
                return eval('(' + src + ')')
            };
            return null
        },
        toString: function() {
            return '[class JSON]'
        }
    }
})();