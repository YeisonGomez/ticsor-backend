import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus, Request } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { TemaryService } from './temary.service';
import Util from '../shared/util';

@Controller('temary')
export class TemaryController {

    constructor(private temaryService: TemaryService) { }

    @Get('get-all/:course')
    public async getAll (@Res() res: Response, @Request() req, @Param('course') course){
		res.status(HttpStatus.OK).json({ result: await this.temaryService.getAll(course, req.correo), state: 'OK' });	
    }

    @Get('get-content/:temary')
    public async getContent(@Res() res: Response, @Param('temary') temary){
		res.status(HttpStatus.OK).json({ result: await this.temaryService.getContent(temary), state: 'OK' });	
    }

    @Get('get-question/:temary')
    public async getQuestion(@Res() res: Response, @Param('temary') temary){
		res.status(HttpStatus.OK).json({ result: await this.temaryService.getQuestion(temary), state: 'OK' });	
    }

    @Post('response')
    public async response(@Res() res: Response, @Body() body){
		res.status(HttpStatus.OK).json({ result: await this.temaryService.response(body.temary_id, body.email, body.response), state: 'OK' });	
    }
}