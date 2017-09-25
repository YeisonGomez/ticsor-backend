import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { ScoreService } from './score.service';
import { CONFIG } from '../../environment'

@Controller('score')
export class ScoreController {

    constructor(private score: ScoreService) { }
}