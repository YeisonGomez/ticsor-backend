import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { BoxsService } from './boxs.service';
import { CONFIG } from '../../environment'

@Controller('box')
export class BoxsController {

    constructor(private boxs: BoxsService) { }

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

    @Post()
    public async startGame( @Res() res: Response, @Body() body) {
        if (body.key == CONFIG.CODE_PRIVATE) {

            res.status(HttpStatus.OK).json(query);
        }else{
            res.status(HttpStatus.UNAUTHORIZED).json("MK que inventa, ya parece Zanoni Alfredo Salas Tobon");
        }
    }

    @Delete(':id')
    public async delete( @Res() res: Response, @Param('id') id: string) {
        /*const boxsDeleted = await this.boxs.delete(id);
        res.status(HttpStatus.OK).send(boxsDeleted);*/
    }
}