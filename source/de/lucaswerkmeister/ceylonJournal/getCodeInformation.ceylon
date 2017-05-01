// TODO eventually, this should use Java 9’s stack walking API
native ("jvm") [String, Integer, String, String] getCodeInformation() {
    assert (exists ste = GetStackTrace.stackTrace[3]);
    return [ste.fileName, ste.lineNumber, ste.className, ste.methodName];
}
