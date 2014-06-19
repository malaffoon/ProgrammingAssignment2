library('RUnit')

source('cachematrix.R')
printTextProtocol(runTestSuite(defineTestSuite("cachematrix", file.path("."), "^runit.cachematrix.R$")))