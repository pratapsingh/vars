if (Select_Region != "None"){
    def cmd1="/bin/bash /opt/scripts/Instance_Creation/get_vpc.sh $Select_Region $Select_Account"
    def b = new StringBuffer()
    def proc = cmd1.execute()
    proc.consumeProcessErrorStream(b)
    return proc.text.tokenize('\r\n')
}
