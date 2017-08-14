import { Module } from '@nestjs/common';
import { EmployeeController } from './employee.controller';
import { EmployeeService } from './employee.service';
import { SharedModule } from './../shared/shared.module';

@Module({
    components: [EmployeeService],
    controllers: [EmployeeController],
    modules: [SharedModule]
})
export class EmployeeModule { }