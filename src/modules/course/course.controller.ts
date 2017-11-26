import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus, Request } from '@nestjs/common';
import { Response } from 'express';
import { CONFIG } from '../../environment'

import { CourseService } from './course.service';
import { User } from '../../models/user.model';

@Controller('course')
export class CourseController {

    constructor(private courseService: CourseService) { }

    @Get('get-all')
    public async getAll(@Res() res: Response, @Request() req){
		res.status(HttpStatus.OK).json(await this.courseService.getAll(req.correo));
    }
}