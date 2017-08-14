import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { EmployeeService } from './employee.service';

@Controller('employee')
export class EmployeeController {

    constructor(private employee: EmployeeService) { }

    @Get()
    public async getAll( @Res() res: Response) {
        const employees = await this.employee.getAll();
        res.status(HttpStatus.OK).json(employees);
    }

    @Get('/:id')
    public async getById( @Res() res, @Param('id') id) {
        const employee = await this.employee.getById(id);
        res.status(HttpStatus.OK).json(employee);
    }

    @Post()
    public async create( @Res() res: Response, @Body() employee) {
        const newEmployee = await this.employee.create(employee);
        res.status(HttpStatus.CREATED).json(newEmployee);
    }

    @Put(':id')
    public async update( @Res() res: Response, @Param('id') id: string, @Body() employee) {
        const employeeUpdated = await this.employee.update(id, employee);
        res.status(HttpStatus.OK).send(employeeUpdated);
    }

    @Delete(':id')
    public async delete( @Res() res: Response, @Param('id') id: string) {
        const employeeDeleted = await this.employee.delete(id);
        res.status(HttpStatus.OK).send(employeeDeleted);
    }
}