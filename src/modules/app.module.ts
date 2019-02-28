import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { CONFIG } from '../environment'
import { UserModule } from './users/users.module';
import { CourseModule } from './course/course.module';
import { TemaryModule } from './temary/temary.module';
import { EvaluateModule } from './evaluate/evaluate.module';
import { QrModule } from './qr/qr.module';

@Module({
    imports: [
        MongooseModule.forRoot(CONFIG.DB.mongodb),
        UserModule, 
        CourseModule, 
        TemaryModule, 
        QrModule, 
        EvaluateModule],
})
export class ApplicationModule {}