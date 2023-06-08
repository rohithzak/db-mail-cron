import smtplib
import sys

arg1 = sys.argv[1]
arg2 = sys.argv[2]
arg3 = sys,argv[3]

sender = '<sender mail ID>'
receivers = [arg1]

message = """From: From person <from@fromdomain.com>
To: To person <to@todomain.com>
Subject: backup status {}

{}
""".format(arg2, arg3)

smtp = smtplib.SMTP('smtp.gmail.com', port='587')

smtp.ehlo() 
smtp.starttls()

smtp.login('<Sender mail id>', '<App password>')  


smtp.sendmail(sender, receivers, message)
              
smtp.quit() 

