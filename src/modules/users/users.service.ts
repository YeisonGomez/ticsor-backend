import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';
import { BoxsService } from '../boxs/boxs.service';
import { ScoreService } from '../score/score.service';

@Component()
export class UsersService {

    constructor(private db: DatabaseService, private scoreService: ScoreService) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async startGameUsers(){
        return await (this.db.query(`UPDATE usuario SET movimiento='0', movio=0, estado='1', vida = 0`));
    }

    public async updateMovement(code: number, movimiento: number){
    	return await (this.db.query(`UPDATE usuario SET movimiento='${movimiento}', movio='1' where code=${code} AND estado = '1'`));
    }   

    public async updateColor(userId: number, color: number){
    	return await (this.db.query(`UPDATE usuario SET team='${color}' where id=${userId}`));
    }

    public async updateState(userId: number, state: number){
        return await (this.db.query(`UPDATE usuario SET estado='${state}' where id=${userId}`));
    }

    public async restartTurn(userId: number, vida: number){
        return await (this.db.query(`update usuario SET movimiento = '0', vida = ${vida}, movio = 0 where id = ${userId}`));
    }

    public async killUserTableByBox(fk_user: number, box: string){
        return await (this.db.query(`UPDATE casilla SET fk_usuario=null where nombre='${box}'`));
    }

    public async killUserTable(fk_user: number){
        return await (this.db.query(`UPDATE casilla SET fk_usuario=null where fk_usuario='${fk_user}'`));
    }

    public async killUser(fk_muerto: number, fk_asesino: number, casilla: string){
        /*Anotarle un puntaje 
        Cambiar el estado del usuario a muerto
        Eliminarlo del tablero
        Verificar si lleva 5 muertes
            Eliminarlo del tablero y marcarlo como ganador*/
        await this.scoreService.insertScore(fk_muerto, fk_asesino, casilla);
        await this.updateState(fk_muerto, 0);
        await this.killUserTableByBox(fk_muerto, casilla);
        console.log("Se elimino del tablero a: " + fk_muerto + " en la casilla: " + casilla);
        let score = await this.scoreService.totalScoreUser(fk_asesino);
        if(score == 5){
            await this.killUserTable(fk_asesino);
            await this.updateState(fk_asesino, 2);
        }
    }

    public async suicideUser(userId){
        await this.updateState(userId, 0);
        await this.killUserTable(userId);
    }

}