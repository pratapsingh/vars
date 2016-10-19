def cmd1="/usr/bin/python /opt/scripts/Instance_Creation/get_security_group.py $Select_Region $Select_Account $VPC_ID"
    def b = new StringBuffer()
    def proc = cmd1.execute()
    proc.consumeProcessErrorStream(b)
    return proc.text.tokenize('\r\n')
