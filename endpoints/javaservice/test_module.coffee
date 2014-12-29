module.exports = (router)->
  console.log("inside module")
  router.get "/results",(req,resp)->
    id = req.params.id
    console.log("GET: #{req.originalUrl}")

  router.post "/", (req,resp)->
    id= req.params.id
    console.log("POST: #{id}")
