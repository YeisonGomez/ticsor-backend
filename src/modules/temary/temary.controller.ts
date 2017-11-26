import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus, Request } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { TemaryService } from './temary.service';
import Util from '../shared/util';

@Controller('user')
export class TemaryController {

    constructor(private temaryService: TemaryService) { }

    @Get('get-all')
    public async getAll (@Res() res: Response, @Request() req){
        await this.temaryService.getAll(req.correo);
		res.status(HttpStatus.OK).json({ state: 'OK' });	
    }
}