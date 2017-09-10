import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { BoxsService } from './boxs.service';
import { UsersService } from '../users/users.service';
import { CONFIG } from '../../environment'

@Controller('box')
export class BoxsController {

    constructor(private boxs: BoxsService, private userService: UsersService) { }

    @Get()
    public async getAll( @Res() res: Response) {
        const boxs = await this.boxs.getAll();
        res.status(HttpStatus.OK).json(boxs);
    }

    @Get('/:id')
    public async getById( @Res() res, @Param('id') id) {
        const boxs = await this.boxs.getById(id);
        res.status(HttpStatus.OK).json(boxs);
    }

    @Post()
    public async create( @Res() res: Response, @Body() boxs) {
        const newboxs = await this.boxs.createBoxs(boxs.size);
        res.status(HttpStatus.CREATED).json(newboxs);
    }

    @Post('start-game')
    public async startGame(@Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {
            const users = await this.userService.getAll();
            res.status(HttpStatus.OK).json(await this.boxs.startGame(users));
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json("MK que inventa, ya parece Zanoni Alfredo Salas Tobon");
        }
    }
}