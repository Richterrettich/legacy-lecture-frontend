class Hugo
  constructor:()->
    @blubb=()->
      console.log("blubb")
  foobar:()->
    console.log("baz")



a = new Hugo()
a.blubb()

a.blubb = ()->
  console.log("foo")
a.blubb()
a.foobar()
a.foobar=()->
  console.log("hurts")
a.foobar()