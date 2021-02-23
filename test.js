const expect = require('chai').expect;
let returnValue = require('./nestedKey.js');

describe('Default Test cases', () => {
    it('should return a', () => {
        expect(returnValue({x:{y:{z:"a"}}} , "x/y/z")).to.equal("a");
    });

    it('should return d', () => {
        expect(returnValue({a:{b:{c: "d"}}} , "a/b/c")).to.equal("d");
    });
});

describe('Check Arrays', () => {
    it('should return array ["a","b","c"]', () => {
        expect(returnValue({x:{y:{z:["a","b","c"]}}} , "x/y/z")).deep.equal(["a","b","c"]);
    });
});

describe('Check Objects', () => {
    it('should return Object {a: b}', () => {
        expect(returnValue({x:{y:{z:{a: "b"}}}} , "x/y/z")).deep.equal({a:"b"});
    });
});