    def cmd1="/opt/scripts/Instance_Creation/get_subnet.sh $Select_Region $Select_Account $Availability_Zone $VPC_ID "
    def b = new StringBuffer()
    def proc = cmd1.execute()
    proc.consumeProcessErrorStream(b)
    return proc.text.tokenize('\r\n')
