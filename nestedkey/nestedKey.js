function getObjectKeys(o, k) {
    const keys = k.split('/');
    let obj = o;
    for(let i =0; i < keys.length ; i++) {
        obj = obj[keys[i]]
    }
    return obj;
}

module.exports = getObjectKeys;