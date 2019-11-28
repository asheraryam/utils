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
  it('should encore/decode uint 8', () => {
    // start godot server
    const data = executeGodotForType('put_u8')

    data.forEach((item) => {
      expect(GdCom.getU8(Buffer.from(item.buffer)).value).to.deep.equal(item.value)
      expect(GdCom.putU8(item.value)).to.deep.equal(Buffer.from(item.buffer))
    })
  })

  it('should encore/decode uint 16', () => {
    // start godot server
    const data = executeGodotForType('put_u16')

    data.forEach((item) => {
      const buf = Buffer.from(item.buffer)
      console.log({
        ...item,
        buf
      })

      expect(GdCom.getU16(buf).value).to.deep.equal(item.value)
      expect(GdCom.putU16(item.value)).to.deep.equal(buf)
    })
  })
})
