import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [UsersService],
    controllers: [UsersController],
    modules: [SharedModule]
})
export class UserModule { }