import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus, Request } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { EvaluateService } from './evaluate.service';
import Util from '../shared/util';

@Controller('evaluate')
export class EvaluateController {

    constructor(private evaluateService: EvaluateService) { }

    @Get('get-all/:courseId')
    public async getAll (@Res() res: Response, @Request() req, @Param('courseId') courseId){
		res.status(HttpStatus.OK).json({ result: await this.evaluateService.getAll(courseId), state: 'OK' });	
    }

    @Get('get-question/:evaluateId')
    public async getQuestion (@Res() res: Response, @Request() req, @Param('evaluateId') evaluateId){
		res.status(HttpStatus.OK).json({ result: await this.evaluateService.getQuestion(evaluateId), state: 'OK' });	
    }

    @Post('response')
    public async response (@Res() res: Response, @Request() req, @Body() body){
		res.status(HttpStatus.OK).json({ result: await this.evaluateService.response(body.evaluateId, body.email, body.response), state: 'OK' });	
    }

    @Get('get-user-evaluate')
    public async getUserEvaluate(@Res() res: Response, @Request() req){
        res.status(HttpStatus.OK).json({ result: await this.evaluateService.getUserEvaluate(req.correo), state: 'OK' });    
    }
}