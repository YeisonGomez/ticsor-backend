import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';
import { Box } from '../../providers/box.provider';
import { UsersService } from '../users/users.service';

@Component()
export class BoxsService {

    constructor(
        private db: DatabaseService, private box: Box) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM casilla`))
    }

    public async getById(id: string){
        return await (this.db.query(`SELECT * FROM casilla WHERE id = ${id}`))
    }

    public async createBoxs(size) {
        let boxs = this.box.getListBox(size);
        let i = 0;
        while(i < boxs.length){
            let response = await this.createBox(boxs[i])
            if(response == 'ER_DUP_ENTRY'){
                return response;
            } else {
                i++;
            }
        }
        return 'OK';
    }

    public async createBox(name: string){
        return this.db.query(
            `INSERT INTO casilla (nombre) VALUES ('${name}')`
        ).then(data => {
            return data;
        })
        .catch(e => {
            return e.code;
        })
    }
}