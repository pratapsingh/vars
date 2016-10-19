def cmd1="/usr/bin/python /opt/scripts/Instance_Creation/get_zone.py $Select_Region $Select_Account"
    def b = new StringBuffer()
    def proc = cmd1.execute()
    proc.consumeProcessErrorStream(b)
    return proc.text.tokenize('\r\n')
