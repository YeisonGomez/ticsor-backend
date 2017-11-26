import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { UsersService } from './users.service';
import { User } from '../../models/user.model';
import Util from '../shared/util';

@Controller('user')
export class UsersController {

    constructor(private userService: UsersService) { }

    @Post('login')
    public async login (@Res() res: Response, @Body() body: User){
    	if( body != undefined){
            await this.userService.login(body.nombres, body.apellidos, body.correo, body.foto);
			res.status(HttpStatus.OK).json({ token: Util.token(body).token, state: 'OK' });	
    	}else{
    		res.status(HttpStatus.BAD_REQUEST).json({ state: 'ERROR', description: 'Payload incompleto.'});
    	}      
    }
}