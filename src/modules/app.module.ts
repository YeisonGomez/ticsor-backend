import { Module } from '@nestjs/common';
import { EmployeeModule } from './employee/employee.module';

@Module({
    modules: [EmployeeModule],
})
export class ApplicationModule {}