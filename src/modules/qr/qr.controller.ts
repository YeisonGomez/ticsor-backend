import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus, Request } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { QrService } from './qr.service';
import Util from '../shared/util';

@Controller('qr')
export class QrController {

    constructor(private qrService: QrService) { }

    @Get('get-qr/:qr_code')
    public async getByCode (@Res() res: Response, @Request() req, @Param('qr_code') code){
		res.status(HttpStatus.OK).json({ result: await this.qrService.getByCode(code), state: 'OK' });	
    }

    @Post('response')
    public async response(@Res() res: Response, @Body() body){
		res.status(HttpStatus.OK).json({ result: await this.qrService.response(body.temary_id, body.email, body.response), state: 'OK' });	
    }
}