import groovy.time.TimeCategory
import java.time.*
import java.time.format.*
import java.text.SimpleDateFormat
import hudson.FilePath

def formatDate(mydate, myFormatString =  "yyyy-MM-dd'T'HH:mm:ss") {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern(myFormatString)
    return mydate.format(formatter)
}

def addMinutes(mydate, minsAdd) {
    return mydate.plusMinutes(minsAdd)
}

def TimeNow() {
    LocalDateTime t = LocalDateTime.now()
    return t
}

def getPathSize(String myFilePath) {
    pt = getFilePath(myFilePath)
    return (double) pt.length()
}

def getFilePath(String filename) {
    String nodeName = env.NODE_NAME
    if (nodeName == 'master') {
            return new FilePath(new File(path))
        } else {
            return new FilePath(Jenkins.getInstanceOrNull().getComputer(nodeName).getChannel(), filename)
    }
}

// Return this module as Groovy object
return this
