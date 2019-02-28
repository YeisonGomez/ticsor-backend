import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    providers: [UsersService],
    controllers: [UsersController],
    imports: [SharedModule]
})
export class UserModule { }