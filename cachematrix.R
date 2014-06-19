## These functions allow the inverse of a matrix to be calculated once and 
## cached for repeated use. To use:
##    cm <- makeCacheMatrix(sourceMatrix)
##    inv <- cacheSolve(cm)
##    ...
##    m <- cm$get()          # to get the source matrix
##    inv <- cacheSolve(cm)  # get the inverse as often as you'd like, free of charge
##    inv <- cm$getInverse() # technically safe but ill-advised since it may return NULL

## Create a special "matrix" that caches its inverse.
## Use in conjunction with cacheSolve to efficiently reuse inverse.
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setInverse <- function(y) inv <<- y
    getInverse <- function() inv
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}

## Calculate the inverse of the given special matrix, returning the cached
## value if it has already been calculated.
cacheSolve <- function(x, ...) {
    inverse <- x$getInverse()
    if (is.null(inverse)) {
        inverse = solve(x$get())
        x$setInverse(inverse)
    }
    inverse
}
