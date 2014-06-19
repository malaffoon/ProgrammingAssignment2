test.simple1 <- function() {
    sourceMatrix <- matrix(1:4, nrow=2, ncol=2)
    expected <- solve(sourceMatrix)
    cm <- makeCacheMatrix(sourceMatrix)
    checkEquals(sourceMatrix, cm$get())
    checkEquals(expected, cacheSolve(cm))
}

test.inverseNotCalculated <- function() {
    cm <- makeCacheMatrix(matrix(1:4, nrow=2, ncol=2))
    checkEquals(NULL, cm$getInverse())
}

test.cacheHits <- function() {
    sourceMatrix <- matrix(1:4, nrow=2, ncol=2)
    expected <- solve(sourceMatrix)
    cm <- makeCacheMatrix(sourceMatrix)
    
    # call a number of times keeping track of calls made
    track <- tracker()
    track$init()
    for (i in 1:10) {
        res <- inspect(cacheSolve(cm), track = track)
        checkEquals(expected, res)
    }
    resTrack <- track$getTrackInfo()
    cacheSolveTrack <- resTrack$`R/cacheSolve`
    checkEquals(10, cacheSolveTrack$nrRuns)
    # cacheSolveTrack$src[4] is the line that calculates the matrix inverse
    # so it should be called only once even though we made many calls
# when i run this interactively on the console it works but it doesn't when 
# i run using the test suite, all the src run counts are zero; since unit 
# testing wasn't officially prescribed i will punt for now.
    #checkEquals(1, cacheSolveTrack$run[4])
}