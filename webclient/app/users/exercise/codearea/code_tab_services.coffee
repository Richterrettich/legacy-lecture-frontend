codeTabServices = angular.module("interactiveLecture.codeTabServices",[])

class CodeTab
  constructor:(@language,@id)->
    @active = true
    @focus = true
    @editing = false
    @title = "Neue Datei"
    @content = ""
    @errors = []
    @tabController = {}
    @aceOption =
      mode: @language,
      onLoad: (_ace) =>
        @editor=_ace
        _ace.focus()

  clearAnnotations: ()->
    @editor.getSession().clearAnnotations()

  addError:(err)->
    if err?
      @errors.push(err)
      @editor.getSession().setAnnotations(@errors)
    else
      @errors = []
      @editor.getSession().clearAnnotations()

  setOnChangeListener:(callback)->
    @aceOption.onChange = callback

  clear:()->
    @content = ""
    @title = "Neue Datei"

  setTabController:(controller)->
    controller.setTab(@)
    @tabController = controller



class CodeTabs
  constructor:()->
    #TODO  id logik anpassen
    @id = 0
    @tabs = {}

  addTab:(language)->
    t = new CodeTab(language,@id)
    @tabs[@id++] =t
    return t

  removeTab:(tabId)->
    delete @tabs[tabId]

  clearAnnotations:()->
    angular.forEach @tabs,(tab)->
      tab.clearAnnotations()

  addAnnotation:(tabId,err)->
    #TODO Uncaught TypeError: Cannot read property 'addError' of undefined
    @tabs[tabId].addError(err)

  clearTab:(tabId)->
    @tabs[tabId].clear()



  removeAllTabs:()->
    @tabs = {}


codeTabServices.service("tabListService",[CodeTabs])
