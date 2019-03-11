import { Injectable } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Injectable()
export class UsersService {

    constructor(private db: DatabaseService) {
    }
    
    public async login(nombres: string, apellidos: string, correo: string, foto: string) {
        return await (this.db.query(`CALL procedimiento_inicio_sesion('${ nombres }', '${ apellidos }', '${ correo }', '${ foto }')`))
    }

    public async getAll() {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async startGameUsers(){
        return await (this.db.query(`UPDATE usuario SET movimiento='0', movio=0, estado='1', vida = 0`));
    }

}