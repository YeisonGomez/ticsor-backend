import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';
import { Score } from '../../providers/score.provider';

@Component()
export class ScoreService {

    constructor(private db: DatabaseService) {
    }
    
    public async getAll() {
        return await (this.db.query(`SELECT * FROM usuario`))
    }

    public async totalScoreUser(fk_user: number){
    	return (await (this.db.query(`select COUNT(*) as total from puntaje p where p.fk_asesino = ${fk_user} GROUP BY p.fk_asesino;`)))[0].total;
    }

    public async insertScore(fk_muerto: number, fk_asesino: number, casilla: string){
    	return await (this.db.query(`INSERT INTO puntaje (fk_muerto, fk_asesino, casilla) values (${fk_muerto}, ${fk_asesino}, '${casilla}')`));
    }   

}