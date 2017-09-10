import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';
import { User } from '../../providers/user.provider';

@Component()
export class UsersService {

    constructor(private db: DatabaseService, private user: User) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async updateMovement(code: number, movimiento: number){
    	return await (this.db.query(`UPDATE usuario SET movimiento='${movimiento}' where code=${code}`));
    }   

}