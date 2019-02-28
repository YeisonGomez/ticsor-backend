import * as mongoose from 'mongoose';

export const QRSchema = new mongoose.Schema({
  nombre: String,
  descripcion: String,
  tipo: String, // 0 = publico, 1 = oficial
  estado: String, // 0 = solicitado, 1 = aceptado, 2 = rechazado, 3 = denunciado
  fk_usuario: Number,
  code: String,
  images: Array
});