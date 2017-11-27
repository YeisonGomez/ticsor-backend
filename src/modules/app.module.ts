import { Module } from '@nestjs/common';
import { UserModule } from './users/users.module';
import { CourseModule } from './course/course.module';
import { TemaryModule } from './temary/temary.module';
import { QrModule } from './qr/qr.module';

@Module({
    modules: [UserModule, CourseModule, TemaryModule, QrModule],
})
export class ApplicationModule {}