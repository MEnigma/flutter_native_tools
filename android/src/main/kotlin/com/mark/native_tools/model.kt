package com.mark.native_tools

class ResponseResult(isOkey: Boolean, message: String) {
    var isOkey: Boolean = isOkey
    var message: String = message

    fun toMap(): Map<*, *> {
        return mapOf("isOkey" to isOkey, "message" to message)
    }


}