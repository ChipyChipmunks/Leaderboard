Lists = new Mongo.Collection('Lists')

root = exports ? this

root.Lists = Lists

Lists.defaultName = ->
  nextLetter = "A"
  nextName = "List " + nextLetter
  while Lists.findOne(name: nextName)
    
    # not going to be too smart here, can go past Z
    nextLetter = String.fromCharCode(nextLetter.charCodeAt(0) + 1)
    nextName = "List " + nextLetter
  nextName