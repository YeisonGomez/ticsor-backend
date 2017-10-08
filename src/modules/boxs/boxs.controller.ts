import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';

import { Box } from '../../providers/box.provider';
import { BoxsService } from './boxs.service';
import { UsersService } from '../users/users.service';
import { ScoreService } from '../score/score.service';
import { CONFIG } from '../../environment'

@Controller('box')
export class BoxsController {

    private turno: number = 0;
    private copy_turno: number = 0;
    private maximoVida: number = 5;

    constructor(private boxs: BoxsService, private userService: UsersService, private box: Box, private scoreService: ScoreService) {
    }

    @Get('/:id')
    public async getById( @Res() res, @Param('id') id) {
        let boxs = await this.boxs.getById(id);
        res.status(HttpStatus.OK).json(boxs);
    }

    @Get('/table/get-table')
    public async getTable( @Res() res: Response) {
        let interval = setInterval((function(self) {         
            return async function() {   
                if(self.turno > self.copy_turno){
                    self.copy_turno++;
                    clearInterval(interval);
                    res.status(HttpStatus.CREATED).json({ turno: self.turno, tablero: await self.boxs.getTablePublic() });
                    //res.json(self.turno);
                } else if(self.turno == -1){
                    res.json({ turno: self.turno });
                }
            }
         })(this), 300);
    }

    @Post('/table/get-table-private')
    public async getTablePrivate( @Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {
            res.status(HttpStatus.CREATED).json({ turno: this.turno, tablero: await this.boxs.getAllPrivate() });
        } else {
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
        }
    }

    @Post()
    public async create( @Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {
            let newboxs = await this.boxs.createBoxs(body.size);
            res.status(HttpStatus.CREATED).json(newboxs);
        } else {
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
        }
    }

    @Post('start-game')
    public async startGame(@Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {
            this.turno = 0;
            this.copy_turno = 0;
            let users = await this.userService.getAll();
            res.status(HttpStatus.OK).json(await this.boxs.startGame(users));
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
        }
    }

    @Post('update-table')
    public async updateTable(@Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE && this.turno != -1) {
            this.turno++;
            let users = await this.boxs.getUserAndBox();
            let boxEnd = await this.boxs.getEndBox();
            let usersOrder = await this.boxs.orderUsersFromMovement(users, boxEnd[0].nombre.substring(1, boxEnd[0].nombre.length)); //Ningun jugador debe estar en la columna 10
            for (var i = 0; i < usersOrder.length; ++i) {
                if(usersOrder[i].estado == '1'){
                    if(usersOrder[i].movio == 0){
                        console.log("El usuario " + usersOrder[i].id + " no solicito moverse");
                        usersOrder[i].movimiento = 0;
                    }

                    let new_position = this.box.nextPosition(usersOrder[i].casilla_nombre, usersOrder[i].movimiento, boxEnd[0].nombre.substring(0, 2), usersOrder[i].team);
                    let userExistNewPosition = await this.boxs.existUserBox(new_position);

                    if((usersOrder[i].movimiento == 2 || usersOrder[i].movimiento == 3) && userExistNewPosition[0]){
                        //Movimiento diagonar y hay alguien
                        await this.userService.killUser(userExistNewPosition[0].fk_usuario, usersOrder[i].id, new_position);
                        let j = this.box.findUserById(usersOrder, userExistNewPosition[0].fk_usuario);
                        usersOrder[j].estado = '0';
                    } else if((usersOrder[i].movimiento == 2 || usersOrder[i].movimiento == 3) && !userExistNewPosition[0]){
                        console.log("El usuario " + usersOrder[i].id + " no puede asesinar en la posición " + new_position);
                        usersOrder[i].movimiento = 0;
                    } else if(usersOrder[i].movimiento == 1){
                        let position_frente = this.box.nextPosition(usersOrder[i].casilla_nombre, 1, boxEnd[0].nombre.substring(0, 2), usersOrder[i].team);
                        let exist = await this.boxs.existUserBox(position_frente)
                        if(exist[0]){
                            usersOrder[i].movimiento = 0;
                            console.log("El usuario " + usersOrder[i].id + " no puede mover al frente");
                        }
                    }

                    if(usersOrder[i].vida == this.maximoVida && usersOrder[i].movimiento == 0){
                        await this.userService.suicideUser(usersOrder[i].id);
                        console.log("El usuario " + usersOrder[i].id + " murio por limite de estarse quieto");
                    } else {   
                        if(this.box.validateFinish(new_position, (usersOrder[i].team == 0)? 'white': 'black', boxEnd[0].nombre)){
                            this.turno = -1;
                            res.status(HttpStatus.OK).json({ state: 'GAME_OVER'});
                        } else {
                            if(usersOrder[i].movimiento != 0){
                                console.log("El usuario " + usersOrder[i].id + " a la posicion " + new_position);
                                await this.boxs.killUserTable(usersOrder[i].id, usersOrder[i].casilla_nombre);
                                await this.boxs.newPosition(usersOrder[i].id, new_position);
                            } else {
                                console.log("El usuario " + usersOrder[i].id + " no hace nada");
                            }
                            this.userService.restartTurn(usersOrder[i].id, (usersOrder[i].movimiento == 0)? (usersOrder[i].vida + 1) : 0);
                        }
                    }
                } else {
                    console.log("El usuario " + usersOrder[i].id + " esta muerto");
                }
                console.log("========================");
            }
            let users_all = await this.boxs.getAllPrivate();
            if(this.boxs.validUsersLifes(users_all)){
                this.turno = -1;
                res.status(HttpStatus.OK).json({ turno: this.turno, tablero: users_all });
            } else {
                res.status(HttpStatus.OK).json({ turno: this.turno, tablero: users_all });
            }
            /*
            if el usuario esta jugando
                Verificar si movio
                    Tomarlo como 0

                Obtener el nuevo movimiento
  
                Verificar si mueve diagonal y hay alguien en la diagonal
                    Anotarle un puntaje 
                    Cambiar el estado del usuario a muerto
                    Eliminarlo del tablero
                    Verificar si lleva 5 muertes
                        Eliminarlo del tablero y marcarlo como ganador
                Si no hay nadie en la diagonal 
                    Tomar el movimiento como 0
                Si mueve al frente
                     Verificar si hay alguien al frente
                        Tomarlo como 0
                
                Verificar si la vida esta en 4 y el movimiento es 0
                    Actualizar el estado a muerto
                    Eliminarlo del tablero
                Si es menor a 4  
                    Verificar si llego al final
                        Acabar el juego
                    Si no gano
                        Si el movimiento fue 0 aumentar la vida
                        Actualizar la posicion antigual en null
                        Actualizar la nueva posicion del jugador y el mover a 0
            Retornar la tabla 
            */
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GAME OVER'});
        }
    }
}


