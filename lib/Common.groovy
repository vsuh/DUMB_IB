import groovy.time.TimeCategory
import java.time.*
import java.time.format.*
import java.text.SimpleDateFormat


def formatDate(mydate, myFormatString =  "yyyy-MM-dd'T'HH:mm:ss"){
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern(myFormatString)
    return mydate.format(formatter)
}

def addMinutes(mydate, minsAdd) {
    return mydate.plusMinutes(minsAdd)
}

def TimeNow(){
    LocalDateTime t = LocalDateTime.now()
    return t
}


// Return this module as Groovy object 
return this