var defaultCurses, getRandomCurse, imgPathRe, init, isMatchingImg, replaceElm, replaceEmoticons;

imgPathRe = /^http:\/\/i\.mimibazar\.cz\/h\/bc\/i\/\d*\.gif|^http:\/\/img\.mimibazar\.sk\/h\/bs\/i\/\d*\.gif/i;

defaultCurses = 'kokot,piča,chuj,hovno,kunda,kurva,pyčo,čurák,jebať'.split(',');

getRandomCurse = function(curses) {
  if (curses == null) {
    curses = defaultCurses;
  }
  return curses[Math.floor(Math.random() * curses.length)];
};

replaceElm = function(elm, content) {
  var parentElm, replacement;
  if (content == null) {
    content = '';
  }
  if (elm && elm.parentNode) {
    replacement = document.createTextNode(content);
    parentElm = elm.parentNode;
    parentElm.insertBefore(replacement, elm);
    parentElm.removeChild(elm);
  }
};

isMatchingImg = function(node) {
  if (node.tagName.toLowerCase() === 'img') {
    if (node.getAttribute('src').match(imgPathRe)) {
      return NodeFilter.FILTER_ACCEPT;
    }
  }
  return NodeFilter.FILTER_SKIP;
};

replaceEmoticons = function(rootElm) {
  var elm, foundNodes, walker;
  if (rootElm == null) {
    rootElm = document.body;
  }
  walker = document.createTreeWalker(rootElm, NodeFilter.SHOW_ELEMENT, {
    acceptNode: isMatchingImg
  }, false);
  foundNodes = [];
  while (walker.nextNode()) {
    foundNodes.push(walker.currentNode);
  }
  while (elm = foundNodes.shift()) {
    replaceElm(elm, getRandomCurse());
  }
};

init = function() {
  var observer;
  observer = new WebKitMutationObserver(function(mutations) {
    var addedNode, i, mutation, _i, _len;
    for (i in mutations) {
      mutation = mutations[i];
      for (_i = 0, _len = mutation.length; _i < _len; _i++) {
        addedNode = mutation[_i];
        replaceEmoticons(addedNode);
      }
    }
  });
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
  return replaceEmoticons(document.body);
};

if (document.body) {
  init();
}
