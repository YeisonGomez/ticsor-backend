import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class TemaryService {

    constructor(private db: DatabaseService) {
    }

    public async getAll(email) {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async startGameUsers(){
        return await (this.db.query(`UPDATE usuario SET movimiento='0', movio=0, estado='1', vida = 0`));
    }

}