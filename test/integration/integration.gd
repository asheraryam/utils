extends SceneTree

var values = {
    "put_u8": [1, 15, 25, 35, 45, 255],
    "put_u16": [51, 12, 61, 85, 254, 65535],
    "put_u32": [51, 12, 61, 85, 254, 4294967295],
    "put_u64": [51, 12, 61, 85, 254, 18446744073709551615],
    "put_8": [-128, 1, 15, 25, 35, 45, 127],
    "put_16": [-32768, 12, 61, 85, 254, 32767],
    "put_32": [-2147483648, 51, 12, 61, 85, 254, 2147483647],
    "put_64": [-9223372036854775807, 51, 12, 61, 85, 254, 9223372036854775807],
    "put_string": ["hello", "world", "from", "gd-com"],
    "put_float": [12.0, 12.5, 852,62],
    "put_double": [12.0, 12.5, 852,62],
    "put_var": [12.0, 12.5, 852,62]
}

var results = []

func _init():
    var params = OS.get_cmdline_args()
    var usedParams = params[2].replacen('-','')
    var wantedValues = values[usedParams]

    for i in wantedValues:
        var buffer = StreamPeerBuffer.new()

        match usedParams:
            "put_u8":
                buffer.put_u8(i)
            "put_u16":
                buffer.put_u16(i)
            "put_u32":
                buffer.put_u32(i)
            "put_u64":
                buffer.put_u64(i)
            "put_8":
                buffer.put_8(i)
            "put_16":
                buffer.put_16(i)
            "put_32":
                buffer.put_32(i)
            "put_64":
                buffer.put_64(i)
            "put_string":
                buffer.put_string(i)
            "put_float":
                buffer.put_float(i)
            "put_double":
                buffer.put_double(i)
            "put_var":
                buffer.put_var(i)


        results.push_front({
            "buffer": Array(buffer.get_data_array()),
            "value": i
        })
        #for j in buffer.get_data_array():
         #   print('%x' % [j])



    var jstr = JSON.print(results)
    print(jstr)
    quit()
