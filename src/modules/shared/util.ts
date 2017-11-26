import * as jwt from 'jsonwebtoken';

class Util{

	public token(user){
		return {
	      token: jwt.sign({
	      	id: user.id,
	        correo: user.correo,
	        nombres: user.nombres,
	        apellidos: user.apellidos,
	        foto: user.foto,
	        exp: Math.round(new Date().getTime() / 1000) + 604800 // 1 week
	      }, 'ticsor')
	    }
	}
}

export default new Util()