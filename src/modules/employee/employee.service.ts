import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class EmployeeService {

    constructor(
        private db: DatabaseService) {
    }

    public async getAll() {
        return await (this.db.query(`SELECT * FROM Employee`))
    }

    public async getById(id: string){
        return await (this.db.query(`SELECT * FROM Employee WHERE id = ${id}`))
    }

    public async create(empoyee) {
    }

    public async update(id: string, employee) {
    }

    public async delete(id: string) {
    }
}