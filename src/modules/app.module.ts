import { Module } from '@nestjs/common';
import { UserModule } from './users/users.module';
import { CourseModule } from './course/course.module';

@Module({
    modules: [UserModule, CourseModule],
})
export class ApplicationModule {}