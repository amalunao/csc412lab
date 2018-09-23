import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String?
}

struct AlphanumericCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
			if character >= 'a' && character <= 'z' {
				unicode -= 0x20
			}
            let shiftedUnicode = unicode + shiftBy
			if shiftedUnicode > 'Z'.unicodeScalars.first!.value {
				let offset = shiftedUnicode - 'Z'.unicodeScalars.first!.value - 1
				if offset < 10{
					shiftedUnicode = '0'.unicodeScalars.first!.value + offset
				}
				else{
					shiftedUnicode = 'A'.unicodeScalars.first!.value + (offset/10)
				}
			}
			else if shiftedUnicode < 'A'.unicodeScalars.first!.value && shiftedUnicode > '9'.unicodeScalars.first!.value{
				let offset = shiftedUnicode - '9'.unicodeScalars.first!.value - 1
				shiftedUnicode = 'A'.unicodeScalars.first!.value + offset
			}
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
}
