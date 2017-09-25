import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';

import { Box } from '../../providers/box.provider';
import { BoxsService } from './boxs.service';
import { UsersService } from '../users/users.service';
import { CONFIG } from '../../environment'

@Controller('box')
export class BoxsController {

    constructor(private boxs: BoxsService, private userService: UsersService, private box: Box) { }

    @Get()
    public async getAll( @Res() res: Response) {
        let boxs = await this.boxs.getAll();
        res.status(HttpStatus.OK).json(boxs);
    }

    @Get('/:id')
    public async getById( @Res() res, @Param('id') id) {
        let boxs = await this.boxs.getById(id);
        res.status(HttpStatus.OK).json(boxs);
    }

    @Post('/get-table')
    public async getTablePublic( @Res() res: Response, @Body() body) {
        let newboxs = await this.boxs.createBoxs(body.size);
        res.status(HttpStatus.CREATED).json(newboxs);
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
            let users = await this.userService.getAll();
            res.status(HttpStatus.OK).json(await this.boxs.startGame(users));
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
        }
    }

    @Post('update-table')
    public async updateTable(@Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {
            let users = await this.boxs.getUserAndBox();
            let boxEnd = await this.boxs.getEndBox();
            let usersOrder = await this.boxs.orderUsersFromMovement(users, boxEnd[0].nombre.substring(1, boxEnd[0].nombre.length)); //Ningun jugador debe estar en la columna 10
            for (var i = 0; i < usersOrder.length; ++i) {
                if(usersOrder[i].estado == '1'){
                    if(usersOrder[i].movio == 0){
                        usersOrder[i].movimiento = 0;
                    }

                    let new_position = this.box.nextPosition(usersOrder[i].casilla_nombre, usersOrder[i].movimiento, boxEnd[0].nombre.substring(0, 2));
                    let userExistNewPosition = await this.boxs.existUserBox(new_position);
                    if((usersOrder[i].movimiento == 2 || usersOrder[i].movimiento == 3) && userExistNewPosition[0]){
                        //this.scoreService.insertScore(userExistNewPosition[0].fk_usuario, );
                        this.userService.killUser(userExistNewPosition[0].fk_usuario, usersOrder[i].id, usersOrder[i].casilla_nombre);
                    }
                }
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
            res.status(HttpStatus.OK).json("hola");
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
        }
    }
}