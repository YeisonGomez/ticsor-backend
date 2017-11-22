import { Module } from '@nestjs/common';
import { UserModule } from './users/users.module';

@Module({
    modules: [UserModule],
})
export class ApplicationModule {}