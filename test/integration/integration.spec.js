const { describe, it } = require('mocha')
const chai = require('chai')
const expect = chai.expect

const path = require('path')
const exec = require('child_process').execFileSync

const GdCom = require('../../src')

const GODOT_PATH = '/media/bmilhet/DATA/godot/Godot_v3.1.1-stable_linux_headless.64'

const executeGodotForType = (type) => {
  const result = exec(GODOT_PATH, ['--path', path.dirname(__filename), '--no-window', '--script', 'integration.gd', `--${type}`])
  return JSON.parse(result)
}

describe('gd-com binary serializer', () => {
  [
    'put_u8', 'put_u16', 'put_u32', 'put_u64',
    'put_8', 'put_16', 'put_32', 'put_64',
    'put_string',
    'put_float',
    'put_double',
    'put_var'
  ].map(i => {
    it(`should decode ${i}`, () => {
      const data = executeGodotForType(i)
      // transform put_u8 to put / get
      const removed = i.replace('put_', '')
      const methodName = removed.charAt(0).toUpperCase() + removed.slice(1)
      const putMethod = GdCom[`put${methodName}`]
      const getMethod = GdCom[`get${methodName}`]

      data.forEach((item) => {
        const buf = Buffer.from(item.buffer)

        expect(getMethod(buf).value).to.deep.equal(item.value)
        expect(putMethod(item.value)).to.deep.equal(buf)
      })
    })
  })
})
