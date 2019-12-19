# TODO add support for Facebook

imgPathRe = ///
    ^//i\.mimibazar\.cz/h/bc/i/\d*\.gif
  | ^//img\.mimibazar\.sk/h/bs/i/\d*\.gif
///i

defaultCurses = 'kokot,piča,chuj,hovno,kunda,kurva,pyčo,čurák,jebať'.split ','

getRandomCurse = (curses = defaultCurses) ->
  curses[Math.floor(Math.random() * curses.length)]

replaceElm = (elm, content = '') ->
  if elm and elm.parentNode
    replacement = document.createTextNode content
    parentElm = elm.parentNode
    parentElm.insertBefore replacement, elm
    parentElm.removeChild elm
  return
  
isMatchingImg = (node) ->
  if node.tagName.toLowerCase() is 'img'
    if node.getAttribute('src').match imgPathRe
      return NodeFilter.FILTER_ACCEPT
  NodeFilter.FILTER_SKIP

replaceEmoticons = (rootElm = document.body) ->
  
  walker = document.createTreeWalker(
    rootElm
    NodeFilter.SHOW_ELEMENT
    {acceptNode: isMatchingImg}
    false
  )

  # It looks silly to go through found nodes twice. But since we replace the
  # found nodes (thus removing them from document), that would trigger the
  # node check recursively.
  foundNodes = []
  foundNodes.push walker.currentNode while walker.nextNode()
  replaceElm elm, getRandomCurse() while elm = foundNodes.shift()
  
  return

init = ->
  observer = new WebKitMutationObserver (mutations) ->
    for i, mutation of mutations
      replaceEmoticons addedNode for addedNode in mutation
    return

  observer.observe document.body, {childList : true, subtree : true}
  replaceEmoticons document.body

if document.body then init()
