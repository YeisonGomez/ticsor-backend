import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { UsersService } from './users.service';
import { CONFIG } from '../../environment'

@Controller('user')
export class UsersController {

    constructor(private users: UsersService) { }

    @Post('update-movement')
    public async updateMovement (@Res() res: Response, @Body() body: any){
    	if( body != undefined && body.code != undefined){
    		if (body.movimiento == undefined || isNaN(body.movimiento) || body.movimiento < 0 || body.movimiento > 3){
    			body.movimiento = 0;
    		}
    		const query = await this.users.updateMovement(body.code, body.movimiento);
			res.status(HttpStatus.OK).json({ state: 'OK' });	
    	}else{
    		res.status(HttpStatus.BAD_REQUEST).json({ state: 'ERROR', description: 'GG'});
    	}      
    }

    @Post('get-all')
    public async getAll(@Res() res: Response, @Body() body: any){
    	if (body.key == CONFIG.CODE_PRIVATE) {
    		const query = await this.users.getAll();
    		res.status(HttpStatus.OK).json(query);
    	}else{
    		res.status(HttpStatus.UNAUTHORIZED).json({ state: 'ERROR', description: 'GG'});
    	}
    	
    }
}