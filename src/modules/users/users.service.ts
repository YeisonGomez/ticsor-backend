import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';
import { ScoreService } from '../score/score.service';
import { BoxsService } from '../boxs/boxs.service';

@Component()
export class UsersService {

    constructor(private db: DatabaseService, private boxService: BoxsService) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async updateMovement(code: number, movimiento: number){
    	return await (this.db.query(`UPDATE usuario SET movimiento='${movimiento}', movio='1' where code=${code}`));
    }   

    public async updateColor(userId: number, color: number){
    	return await (this.db.query(`UPDATE usuario SET team='${color}' where id=${userId}`));
    }

    public async updateState(userId: number, state: number){
        return await (this.db.query(`UPDATE usuario SET estado='${state}' where id=${userId}`));
    }

    public async killUser(fk_muerto: number, fk_asesino: number, casilla: string){
        /*Anotarle un puntaje 
        Cambiar el estado del usuario a muerto
        Eliminarlo del tablero
        Verificar si lleva 5 muertes
            Eliminarlo del tablero y marcarlo como ganador*/
        /*await this.scoreService.insertScore(fk_muerto, fk_asesino, casilla);
        this.updateState(fk_muerto, 0);
        this.boxService.killUserTable(fk_muerto, casilla);*/
        //console.log(await this.scoreService.totalScoreUser(2));
    }

}