testString = 'public class Hugo
{
}'


getClassName = (code)->
  /(.*?)(?=[\n\r\s]+extends|implements|\{)/.exec(code.replace(/((public)(\s|$)*)?(class|interface|@interface|enum)(\s|$)*/, ''))[0]

###newString = testString.replace(/public (class|interface|@interface|enum)/, '')
console.log(newString)

match = /(.*?)(?=extends|implements|$|\{)/.exec(newString)[0]
#result = match[0].split /class/[1]

###
console.log(getClassName(testString))