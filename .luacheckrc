local f = assert(loadfile("../engine/.luacheckrc"))
setfenv(f, getfenv())()
