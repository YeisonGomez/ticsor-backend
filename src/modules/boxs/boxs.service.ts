import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

import { UsersService } from '../users/users.service';
import { Box } from '../../providers/box.provider';


@Component()
export class BoxsService {

    constructor(
        private db: DatabaseService, private box: Box, private userService: UsersService) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM casilla`))
    }

    public async getById(id: string){
        return await (this.db.query(`SELECT * FROM casilla WHERE id = ${id}`))
    }

    public async startGame(users: any){
        let boxEnd = await this.getEndBox();
        boxEnd = boxEnd[0].nombre;
        let boxPositions = this.box.getPositionInitial(boxEnd.toString());
        if(boxPositions.white.length != users.length){
            return { state: 'ERROR', description: `Hacen falta ${ ((boxPositions.white.length * 2) - users.length) } usuarios` };
        }
        let j = 0;
        for (var i = 0; i < boxPositions.white.length; ++i) {
            //white
            j = Math.floor((Math.random() * users.length));
            await this.updateUserBox(boxPositions.white[i], users[j].id);
            await this.userService.updateColor(users[j].id, 0);
            users.splice(j, 1);
            //black
            j = Math.floor((Math.random() * users.length));
            await this.updateUserBox(boxPositions.black[i], users[j].id);
            await this.userService.updateColor(users[j].id, 1);
            users.splice(j, 1);
        }
        return { state: 'OK' };
    }

    public async updateUserBox(boxName: string, fk_user: number){
        console.log(boxName);
        console.log(fk_user);
        return await (this.db.query(`UPDATE box SET fk_usuario='${fk_user}' where nombre=${boxName}`));
    }

    public async getEndBox(){
        return await (this.db.query(`select nombre from casilla where id = (select max(id) from casilla)`))
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