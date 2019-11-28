extends SceneTree

var values = {
    "put_u8": [1, 15, 25, 35, 45, 255],
    "put_u16": [51, 12, 61, 85, 254, 65535],
    "put_u32": [51, 12, 61, 85, 254, 4294967295],
    "put_u64": [51, 12, 61, 85, 254, 18446744073709551615]
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


        results.push_front({
            "buffer": Array(buffer.get_data_array()),
            "value": i
        })
        #for j in buffer.get_data_array():
         #   print('%x' % [j])



    var jstr = JSON.print(results)
    print(jstr)
    quit()
