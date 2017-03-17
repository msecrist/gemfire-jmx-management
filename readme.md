# Using JMX Security
There is a pretty simple reference in the GemFire 8.2 reference guide that makes it easy to see how one would set up the JMX security for gfsh, JConsole, etc. This appears to work in GemFire 9 as well.

I believe based on references in the material that this is based on basic JMX security specified by Oracle.

[Oracle Jmx Monitoring and Managerment page](http://docs.oracle.com/javase/7/docs/technotes/guides/management/agent.html)

# Configuration
The main thing needed is a password file. Here is an example taken from the GemFire 8 reference guide. Let's call this one ```jmx-manager-file.txt```

```
#the gemfiremonitor user has password Abc!@#
#the gemfiremanager user has password 123Gh2!

gemfiremonitor Abc!@#
gemfiremanager 123Gh2!
```

There is also the notion of roles that can be leveraged as well. The role file maps the username defined in the password file above to roles or capabilities. Here is an example (file called ```jmx-access-file.txt```).

```
#the gemfiremonitor user has readonly access
#the gemfiremanager user has readwrite access

gemfiremonitor readonly
gemfiremanager readwrite
```

With these two files, you can now configure the locator (and thus the JMX manager). You need to set the appropriate properties (easily done in a properties file). Here is a locator.properties file:

```
log-level=config
mcast-port=0
jmx-manager-password-file=../jmx-manager-file.txt
jmx-manager-access-file=../jmx-access-file.txt
```

Last but not least, start the locator.

```
$ gfsh start locator --name=locator1 --properties-file=locator.properties
```

What you'll now find is that you cannot connect to the jmx manager unless you authenticate. You'll see something like the following:

```
gfsh>connect
Connecting to Locator at [host=localhost, port=10334] ..
Connecting to Manager at [host=172.20.6.235, port=1099] ..
Authentication failed! Credentials required. Please specify values for --user and --password
```

To properly connect, you need to provide username and password as:

```
gfsh>connect --user=gemfiremanager --password=123Gh2!
Connecting to Locator at [host=localhost, port=10334] ..
Connecting to Manager at [host=172.20.6.235, port=1099] ..
Successfully connected to: [host=172.20.6.235, port=1099]
```
