function getObjectKeys(o, k) {
    const keys = k.split('.');
    let obj = o;
    for (let ikey of keys) {
        for (let [objKey, value] of Object.entries(obj)) {
            if(!keys.includes(objKey)) {
                continue;
            }
            obj = value;
        }
    }
    return obj;
}

module.exports = getObjectKeys;