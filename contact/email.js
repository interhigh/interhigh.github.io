// Basic anti-email harvesting...
function sm(e) {
  // sends mail, used for onclick
  var m = 'l';
  m = 'ai' + m;
  m = m + 'to';
  m = 'm' + m;
  m = m + ':';
  window.location = m + e;
};

function dobf(e) {
  // Takes the first part before the symbol, and adds the last part
  a_sym = 32;
  d_sym = a_sym + 14;
  a_sym = a_sym * 2;
  a_sym = String.fromCharCode(a_sym);
  d_sym = String.fromCharCode(d_sym);

  b = ['cat', 'inter', 'dog', 'high', 'or']
  // Deobfuscates the email address
  return e + a_sym + b[1] + b[3] + d_sym + b[4] + 'g';
};

function gen_e(e) {
  // Generates the link given the prefix
  document.write('<a onclick="sm(dobf(\''+e+'\'));" href="#"><scr'+'ipt>document.write(dobf("'+e+'"));<'+'/script><'+'/a>');
};
