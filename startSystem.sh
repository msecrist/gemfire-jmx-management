# Start locator, pointint to the locator properties file containing
# security elements
gfsh start locator --name=locator1 --properties-file=locator.properties


# Start server 
gfsh start server --name=server1 --locators=localhost[10334] --server-port=0
