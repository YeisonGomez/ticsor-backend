import { Module } from '@nestjs/common';
import { UserModule } from './users/users.module';
import { CourseModule } from './course/course.module';
import { TemaryModule } from './temary/temary.module';

@Module({
    modules: [UserModule, CourseModule, TemaryModule],
})
export class ApplicationModule {}