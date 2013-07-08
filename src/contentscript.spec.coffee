matchingUrls = [
  'http://i.mimibazar.cz/h/bc/i/45.gif'
  'http://img.mimibazar.sk/h/bs/i/88.gif'
]

nonMatchingUrls = [
  'http://fczbkk.com/image.png'
]

createElementWithImg = (url) ->
  elm = document.createElement 'div'
  imgNode = document.createElement 'img'
  imgNode.setAttribute 'src', url
  elm.appendChild imgNode
  elm

describe 'imgPathRe', ->
  
  it 'should exist', ->
    expect(imgPathRe).toBeDefined()
    return

  it 'should match common URLs', ->
    for url in matchingUrls
      expect(url.match imgPathRe).toBeTruthy()
    return

describe 'default list of curses', ->
  
  it 'should exist', ->
    expect(defaultCurses).toBeDefined()
    return

describe 'init() function', ->
  
  it 'should exist', ->
    expect(init).toBeDefined()
    return

describe 'getRandomCurse() function', ->
  
  it 'should exist', ->
    expect(getRandomCurse).toBeDefined()
    return

  it 'should return random curse from default list when called without arg', ->
    expect(defaultCurses).toContain(getRandomCurse())
    return

  it 'should return random curse from provided list', ->
    customCurses = ['aaa', 'bbb', 'ccc']
    expect(customCurses).toContain(getRandomCurse customCurses)
    return

describe 'replaceElm() function', ->
  
  it 'should exist', ->
    expect(replaceElm).toBeDefined()
    return

  it 'should not throw error if called without arguments', ->
    expect(replaceElm).not.toThrow()
    return

  it 'should replace element with text', ->
    wrapper = document.createElement 'div'
    dummy = document.createElement 'div'
    wrapper.appendChild dummy
    replaceElm dummy, 'aaa'
    expect(wrapper.textContent).toBe('aaa')
    return

describe 'isMatchingImg() function', ->
  
  it 'should exist', ->
    expect(isMatchingImg).toBeDefined()
    return

  it 'should block non-img elements', ->
    elm = document.createElement 'div'
    expect(isMatchingImg elm).toBe(NodeFilter.FILTER_SKIP)
    return

  it 'should block img elements with wrong URL', ->
    for url in nonMatchingUrls
      elm = document.createElement 'img'
      elm.setAttribute 'src', url
      expect(isMatchingImg elm).toBe(NodeFilter.FILTER_SKIP)
    return

  it 'should pass img elements with correct URL', ->
    for url in matchingUrls
      elm = document.createElement 'img'
      elm.setAttribute 'src', url
      expect(isMatchingImg elm).toBe(NodeFilter.FILTER_ACCEPT)
    return

describe 'replaceEmoticons() function', ->
  
  it 'should exist', ->
    expect(replaceEmoticons).toBeDefined()
    return

  it 'should keep element without emoticons intact', ->
    for url in nonMatchingUrls
      elm = createElementWithImg url
      originalContent = elm.innerHTML
      replaceEmoticons elm
      newContent = elm.innerHTML
      expect(originalContent).toBe(newContent)
    return

  it 'should replace elements with emoticons', ->
    for url in matchingUrls
      elm = createElementWithImg url
      originalContent = elm.innerHTML
      replaceEmoticons elm
      newContent = elm.innerHTML
      expect(originalContent).not.toBe(newContent)
    return

  return
  

