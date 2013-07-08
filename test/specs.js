var createElementWithImg, matchingUrls, nonMatchingUrls;

matchingUrls = ['http://i.mimibazar.cz/h/bc/i/45.gif'];

nonMatchingUrls = ['http://fczbkk.com/image.png'];

createElementWithImg = function(url) {
  var elm, imgNode;
  elm = document.createElement('div');
  imgNode = document.createElement('img');
  imgNode.setAttribute('src', url);
  elm.appendChild(imgNode);
  return elm;
};

describe('imgPathRe', function() {
  it('should exist', function() {
    expect(imgPathRe).toBeDefined();
  });
  return it('should match common URLs', function() {
    var url, _i, _len;
    for (_i = 0, _len = matchingUrls.length; _i < _len; _i++) {
      url = matchingUrls[_i];
      expect(url.match(imgPathRe)).toBeTruthy();
    }
  });
});

describe('default list of curses', function() {
  return it('should exist', function() {
    expect(defaultCurses).toBeDefined();
  });
});

describe('init() function', function() {
  return it('should exist', function() {
    expect(init).toBeDefined();
  });
});

describe('getRandomCurse() function', function() {
  it('should exist', function() {
    expect(getRandomCurse).toBeDefined();
  });
  it('should return random curse from default list when called without arg', function() {
    expect(defaultCurses).toContain(getRandomCurse());
  });
  return it('should return random curse from provided list', function() {
    var customCurses;
    customCurses = ['aaa', 'bbb', 'ccc'];
    expect(customCurses).toContain(getRandomCurse(customCurses));
  });
});

describe('replaceElm() function', function() {
  it('should exist', function() {
    expect(replaceElm).toBeDefined();
  });
  it('should not throw error if called without arguments', function() {
    expect(replaceElm).not.toThrow();
  });
  return it('should replace element with text', function() {
    var dummy, wrapper;
    wrapper = document.createElement('div');
    dummy = document.createElement('div');
    wrapper.appendChild(dummy);
    replaceElm(dummy, 'aaa');
    expect(wrapper.textContent).toBe('aaa');
  });
});

describe('isMatchingImg() function', function() {
  it('should exist', function() {
    expect(isMatchingImg).toBeDefined();
  });
  it('should block non-img elements', function() {
    var elm;
    elm = document.createElement('div');
    expect(isMatchingImg(elm)).toBe(NodeFilter.FILTER_SKIP);
  });
  it('should block img elements with wrong URL', function() {
    var elm, url, _i, _len;
    for (_i = 0, _len = nonMatchingUrls.length; _i < _len; _i++) {
      url = nonMatchingUrls[_i];
      elm = document.createElement('img');
      elm.setAttribute('src', url);
      expect(isMatchingImg(elm)).toBe(NodeFilter.FILTER_SKIP);
    }
  });
  return it('should pass img elements with correct URL', function() {
    var elm, url, _i, _len;
    for (_i = 0, _len = matchingUrls.length; _i < _len; _i++) {
      url = matchingUrls[_i];
      elm = document.createElement('img');
      elm.setAttribute('src', url);
      expect(isMatchingImg(elm)).toBe(NodeFilter.FILTER_ACCEPT);
    }
  });
});

describe('replaceEmoticons() function', function() {
  it('should exist', function() {
    expect(replaceEmoticons).toBeDefined();
  });
  it('should keep element without emoticons intact', function() {
    var elm, newContent, originalContent, url, _i, _len;
    for (_i = 0, _len = nonMatchingUrls.length; _i < _len; _i++) {
      url = nonMatchingUrls[_i];
      elm = createElementWithImg(url);
      originalContent = elm.innerHTML;
      replaceEmoticons(elm);
      newContent = elm.innerHTML;
      expect(originalContent).toBe(newContent);
    }
  });
  it('should replace elements with emoticons', function() {
    var elm, newContent, originalContent, url, _i, _len;
    for (_i = 0, _len = matchingUrls.length; _i < _len; _i++) {
      url = matchingUrls[_i];
      elm = createElementWithImg(url);
      originalContent = elm.innerHTML;
      replaceEmoticons(elm);
      newContent = elm.innerHTML;
      expect(originalContent).not.toBe(newContent);
    }
  });
});
