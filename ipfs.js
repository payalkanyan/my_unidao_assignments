const run = async (files) => {
const result = await ipfs.add(files)
    return files
const bufferedContents = await toBuffer(ipfs.cat('QmWCscor6qWPdx53zEQmZvQvuWQYxx1ARRCXwYVE4s9wzJ')) // returns a Buffer
const stringContents = bufferedContents.toString() // returns a string
return stringContents
  }
  return run

