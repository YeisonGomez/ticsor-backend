/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : ticsor

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2017-11-29 06:24:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for certificado
-- ----------------------------
DROP TABLE IF EXISTS `certificado`;
CREATE TABLE `certificado` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_nivel` int(20) NOT NULL,
  `fk_curso_usuario` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_certificado_nivel` (`fk_nivel`),
  KEY `fk_certificado_curso` (`fk_curso_usuario`),
  CONSTRAINT `fk_certificado_curso` FOREIGN KEY (`fk_curso_usuario`) REFERENCES `curso_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_certificado_nivel` FOREIGN KEY (`fk_nivel`) REFERENCES `nivel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of certificado
-- ----------------------------

-- ----------------------------
-- Table structure for curso
-- ----------------------------
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `estado` int(5) NOT NULL DEFAULT '0' COMMENT '0= inactivo, 1 = activo',
  `fk_nivel` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_nivel` (`fk_nivel`),
  CONSTRAINT `fk_curso_nivel` FOREIGN KEY (`fk_nivel`) REFERENCES `nivel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso
-- ----------------------------
INSERT INTO `curso` VALUES ('1', 'Lenguaje de Señas', '1', '1');

-- ----------------------------
-- Table structure for curso_usuario
-- ----------------------------
DROP TABLE IF EXISTS `curso_usuario`;
CREATE TABLE `curso_usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_curso` int(20) NOT NULL,
  `fk_usuario` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_usuario` (`fk_curso`),
  KEY `fk_usuario_curso` (`fk_usuario`),
  CONSTRAINT `fk_curso_usuario` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_curso` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso_usuario
-- ----------------------------
INSERT INTO `curso_usuario` VALUES ('1', '1', '4');
INSERT INTO `curso_usuario` VALUES ('2', '1', '5');

-- ----------------------------
-- Table structure for denuncia
-- ----------------------------
DROP TABLE IF EXISTS `denuncia`;
CREATE TABLE `denuncia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_usuario` int(20) NOT NULL,
  `fk_marcador` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_denuncia_usuario` (`fk_usuario`),
  KEY `fk_denuncia_marcador` (`fk_marcador`),
  CONSTRAINT `fk_denuncia_marcador` FOREIGN KEY (`fk_marcador`) REFERENCES `marcador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_denuncia_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denuncia
-- ----------------------------

-- ----------------------------
-- Table structure for evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE `evaluacion` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `fk_curso` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_evaluacion` (`fk_curso`),
  CONSTRAINT `fk_curso_evaluacion` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluacion
-- ----------------------------
INSERT INTO `evaluacion` VALUES ('1', 'Evaluación General', '1');

-- ----------------------------
-- Table structure for evaluacion_usuario
-- ----------------------------
DROP TABLE IF EXISTS `evaluacion_usuario`;
CREATE TABLE `evaluacion_usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nota` decimal(20,0) DEFAULT NULL,
  `fk_usuario` int(20) NOT NULL,
  `fk_evaluacion` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluacion_usuario` (`fk_evaluacion`),
  KEY `fk_usuario_evaluacion` (`fk_usuario`),
  CONSTRAINT `fk_evaluacion_usuario` FOREIGN KEY (`fk_evaluacion`) REFERENCES `evaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_evaluacion` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluacion_usuario
-- ----------------------------
INSERT INTO `evaluacion_usuario` VALUES ('2', '9', '5', '1');

-- ----------------------------
-- Table structure for marcador
-- ----------------------------
DROP TABLE IF EXISTS `marcador`;
CREATE TABLE `marcador` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `tipo` int(5) NOT NULL DEFAULT '1' COMMENT '0=publico, 1=oficial',
  `localizacion` varchar(255) DEFAULT NULL,
  `estado` enum('0','1','2','3') NOT NULL DEFAULT '1' COMMENT '0=solicitado, 1=aceptado, 2=rechazado, 3=denunciado',
  `fk_usuario` int(20) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marcador_usuario` (`fk_usuario`),
  CONSTRAINT `fk_marcador_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of marcador
-- ----------------------------
INSERT INTO `marcador` VALUES ('1', 'Primer piso', 'Cafetería de la Universidad de la Amazonia', '1', null, '1', null, 'primerpiso');
INSERT INTO `marcador` VALUES ('2', 'Segundo piso', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'segunndopiso');
INSERT INTO `marcador` VALUES ('3', 'Tercer piso', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'tercerpiso');
INSERT INTO `marcador` VALUES ('4', 'Naranja ', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'naranja');
INSERT INTO `marcador` VALUES ('5', 'Azul', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'azul');
INSERT INTO `marcador` VALUES ('6', 'Verde', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'verde');
INSERT INTO `marcador` VALUES ('7', 'Roja', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'roja');
INSERT INTO `marcador` VALUES ('8', 'Sala Virtual', 'Sección de la Biblioteca de la U.Amazonia en Señas', '1', null, '1', null, 'salavirtual');
INSERT INTO `marcador` VALUES ('9', 'El Ché', 'Cafetería de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'che');
INSERT INTO `marcador` VALUES ('10', 'Tertulia', 'Cafetería de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'tertulia');
INSERT INTO `marcador` VALUES ('11', 'Flor y café', 'Cafetería de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'florycafe');
INSERT INTO `marcador` VALUES ('12', 'Contaduría publica', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'contaduriapublica');
INSERT INTO `marcador` VALUES ('13', 'Departamento de pedagogía', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'dptopedagogia');
INSERT INTO `marcador` VALUES ('14', 'Administración de empresas', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'adminempresas');
INSERT INTO `marcador` VALUES ('15', 'Cafetería', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'cafeteria');
INSERT INTO `marcador` VALUES ('16', 'Derecho', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'derecho');
INSERT INTO `marcador` VALUES ('17', 'Tesorería', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'tesoreria');
INSERT INTO `marcador` VALUES ('18', 'Oficina asesora de planeación ', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'oficinaasesora');
INSERT INTO `marcador` VALUES ('19', 'Sala de juntas', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'saladejuntas');
INSERT INTO `marcador` VALUES ('20', 'Vicerrectoría administrativa', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'vicerrectoriaadmin');
INSERT INTO `marcador` VALUES ('21', 'Vicerrectoría de investigaciones y posgrados', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'viceinvespos');
INSERT INTO `marcador` VALUES ('22', 'Rectoría', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'rectoria');
INSERT INTO `marcador` VALUES ('23', 'Oficina asesora de relaciones internacionales', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'oficinaasesora');
INSERT INTO `marcador` VALUES ('24', 'Oficina de graduados', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'graduadosof');
INSERT INTO `marcador` VALUES ('25', 'Vicerrectoría académica', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'viceacademica');
INSERT INTO `marcador` VALUES ('26', 'Coordinación seguridad y salud en el trabajo', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'ocupacional');
INSERT INTO `marcador` VALUES ('27', 'Oficina asesora de control interno ', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'oficinaasecont');
INSERT INTO `marcador` VALUES ('28', 'Contabilidad', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'contabilidad');
INSERT INTO `marcador` VALUES ('29', 'Almacén', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'almacen');
INSERT INTO `marcador` VALUES ('30', 'Cuarto de comunicaciones ', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'cuartocomunicaciones');
INSERT INTO `marcador` VALUES ('31', 'Maestría en administración ', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'maestria');
INSERT INTO `marcador` VALUES ('32', 'Coordinación de posgrados', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'coordinacion');
INSERT INTO `marcador` VALUES ('33', 'Coordinación de aplicaciones  ', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'coordiapli');
INSERT INTO `marcador` VALUES ('34', 'Coordinación de investigación y desarrollo', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'cooooor');
INSERT INTO `marcador` VALUES ('35', 'Dirección de departamento se tecnología de la información y la comunicación', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'dirdtic');
INSERT INTO `marcador` VALUES ('36', 'Tecnología en salud ocupacional', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'tsocup');
INSERT INTO `marcador` VALUES ('37', 'Tecnología en desarrollo de software', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'tecdesdsf');
INSERT INTO `marcador` VALUES ('38', 'Administración financiera', 'Oficina de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'admifin');
INSERT INTO `marcador` VALUES ('39', 'Sala de cómputo 1 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala1');
INSERT INTO `marcador` VALUES ('40', 'Sala de cómputo 2 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala2');
INSERT INTO `marcador` VALUES ('41', 'Sala de cómputo 3 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala3');
INSERT INTO `marcador` VALUES ('42', 'Sala de cómputo 4 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala4');
INSERT INTO `marcador` VALUES ('43', 'Sala de cómputo 5 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala5');
INSERT INTO `marcador` VALUES ('44', 'Sala de cómputo 6 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala6');
INSERT INTO `marcador` VALUES ('45', 'Sala de cómputo 7 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala7');
INSERT INTO `marcador` VALUES ('46', 'Sala de cómputo 8 (Bloque 7)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala8');
INSERT INTO `marcador` VALUES ('47', 'Sala Putumayo (Bloque 2)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'sala9');
INSERT INTO `marcador` VALUES ('48', 'Sala Amazonas (Bloque 2, Segundo piso)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'amazonas');
INSERT INTO `marcador` VALUES ('49', 'Sala Caquetá (Bloque 3)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'caqueta');
INSERT INTO `marcador` VALUES ('50', 'Sala Virtual Biblioteca', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'vitualsal');
INSERT INTO `marcador` VALUES ('51', 'Sala Chairá   (Auditorio)', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'chira');
INSERT INTO `marcador` VALUES ('52', 'Sala Docentes', 'Sala de la Universidad de la Amazonia en Señas', '1', null, '1', null, 'docentesdala');

-- ----------------------------
-- Table structure for marcador_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `marcador_multimedia`;
CREATE TABLE `marcador_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_marcador` int(20) NOT NULL,
  `fk_multimedia` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marcador_multimedia` (`fk_marcador`),
  KEY `fk_multimedia_marcador` (`fk_multimedia`),
  CONSTRAINT `fk_marcador_multimedia` FOREIGN KEY (`fk_marcador`) REFERENCES `marcador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_multimedia_marcador` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of marcador_multimedia
-- ----------------------------
INSERT INTO `marcador_multimedia` VALUES ('1', '1', '88');
INSERT INTO `marcador_multimedia` VALUES ('2', '2', '89');
INSERT INTO `marcador_multimedia` VALUES ('3', '3', '90');
INSERT INTO `marcador_multimedia` VALUES ('4', '4', '91');
INSERT INTO `marcador_multimedia` VALUES ('5', '5', '92');
INSERT INTO `marcador_multimedia` VALUES ('6', '6', '93');
INSERT INTO `marcador_multimedia` VALUES ('7', '7', '94');
INSERT INTO `marcador_multimedia` VALUES ('8', '8', '96');
INSERT INTO `marcador_multimedia` VALUES ('9', '9', '97');
INSERT INTO `marcador_multimedia` VALUES ('10', '10', '98');
INSERT INTO `marcador_multimedia` VALUES ('11', '11', '99');
INSERT INTO `marcador_multimedia` VALUES ('12', '12', '100');
INSERT INTO `marcador_multimedia` VALUES ('13', '13', '101');
INSERT INTO `marcador_multimedia` VALUES ('14', '14', '102');
INSERT INTO `marcador_multimedia` VALUES ('15', '15', '103');
INSERT INTO `marcador_multimedia` VALUES ('16', '16', '104');
INSERT INTO `marcador_multimedia` VALUES ('17', '17', '105');
INSERT INTO `marcador_multimedia` VALUES ('18', '18', '106');
INSERT INTO `marcador_multimedia` VALUES ('19', '19', '107');
INSERT INTO `marcador_multimedia` VALUES ('20', '20', '108');
INSERT INTO `marcador_multimedia` VALUES ('21', '21', '109');
INSERT INTO `marcador_multimedia` VALUES ('22', '22', '110');
INSERT INTO `marcador_multimedia` VALUES ('23', '23', '111');
INSERT INTO `marcador_multimedia` VALUES ('24', '24', '112');
INSERT INTO `marcador_multimedia` VALUES ('25', '25', '113');
INSERT INTO `marcador_multimedia` VALUES ('26', '26', '114');
INSERT INTO `marcador_multimedia` VALUES ('27', '27', '115');
INSERT INTO `marcador_multimedia` VALUES ('28', '28', '116');
INSERT INTO `marcador_multimedia` VALUES ('29', '29', '117');
INSERT INTO `marcador_multimedia` VALUES ('30', '30', '118');
INSERT INTO `marcador_multimedia` VALUES ('31', '31', '119');
INSERT INTO `marcador_multimedia` VALUES ('32', '32', '120');
INSERT INTO `marcador_multimedia` VALUES ('33', '33', '121');
INSERT INTO `marcador_multimedia` VALUES ('34', '34', '122');
INSERT INTO `marcador_multimedia` VALUES ('35', '35', '123');
INSERT INTO `marcador_multimedia` VALUES ('36', '36', '124');
INSERT INTO `marcador_multimedia` VALUES ('37', '37', '125');
INSERT INTO `marcador_multimedia` VALUES ('38', '38', '126');
INSERT INTO `marcador_multimedia` VALUES ('39', '39', '127');
INSERT INTO `marcador_multimedia` VALUES ('40', '40', '128');
INSERT INTO `marcador_multimedia` VALUES ('41', '41', '129');
INSERT INTO `marcador_multimedia` VALUES ('42', '42', '130');
INSERT INTO `marcador_multimedia` VALUES ('43', '43', '131');
INSERT INTO `marcador_multimedia` VALUES ('44', '44', '132');
INSERT INTO `marcador_multimedia` VALUES ('45', '45', '133');
INSERT INTO `marcador_multimedia` VALUES ('46', '46', '134');
INSERT INTO `marcador_multimedia` VALUES ('47', '47', '135');
INSERT INTO `marcador_multimedia` VALUES ('48', '48', '136');
INSERT INTO `marcador_multimedia` VALUES ('49', '49', '137');
INSERT INTO `marcador_multimedia` VALUES ('50', '50', '138');
INSERT INTO `marcador_multimedia` VALUES ('51', '51', '139');
INSERT INTO `marcador_multimedia` VALUES ('52', '52', '140');

-- ----------------------------
-- Table structure for multimedia
-- ----------------------------
DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE `multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `tipo` int(5) NOT NULL DEFAULT '0' COMMENT '0=imagen, 1=video',
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multimedia
-- ----------------------------
INSERT INTO `multimedia` VALUES ('28', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/A.mp4', '1', 'A');
INSERT INTO `multimedia` VALUES ('29', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/B.mp4', '1', 'B');
INSERT INTO `multimedia` VALUES ('30', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/C.mp4', '1', 'C');
INSERT INTO `multimedia` VALUES ('31', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/D.mp4', '1', 'D');
INSERT INTO `multimedia` VALUES ('32', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/E.mp4', '1', 'E');
INSERT INTO `multimedia` VALUES ('33', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/F.mp4', '1', 'F');
INSERT INTO `multimedia` VALUES ('34', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/G.mp4', '1', 'G');
INSERT INTO `multimedia` VALUES ('35', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/H.mp4', '1', 'H');
INSERT INTO `multimedia` VALUES ('36', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/I.mp4', '1', 'I');
INSERT INTO `multimedia` VALUES ('37', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/J.mp4', '1', 'J');
INSERT INTO `multimedia` VALUES ('38', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/K.mp4', '1', 'K');
INSERT INTO `multimedia` VALUES ('39', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/L.mp4', '1', 'L');
INSERT INTO `multimedia` VALUES ('40', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/M.mp4', '1', 'M');
INSERT INTO `multimedia` VALUES ('41', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/N.mp4', '1', 'N');
INSERT INTO `multimedia` VALUES ('42', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Ñ.mp4', '1', 'Ñ');
INSERT INTO `multimedia` VALUES ('43', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/O.mp4', '1', 'O');
INSERT INTO `multimedia` VALUES ('44', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/P.mp4', '1', 'P');
INSERT INTO `multimedia` VALUES ('45', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Q.mp4', '1', 'Q');
INSERT INTO `multimedia` VALUES ('46', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/R.mp4', '1', 'R');
INSERT INTO `multimedia` VALUES ('47', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/S.mp4', '1', 'S');
INSERT INTO `multimedia` VALUES ('48', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/T.mp4', '1', 'T');
INSERT INTO `multimedia` VALUES ('49', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/U.mp4', '1', 'U');
INSERT INTO `multimedia` VALUES ('50', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/V.mp4', '1', 'V');
INSERT INTO `multimedia` VALUES ('51', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/W.mp4', '1', 'W');
INSERT INTO `multimedia` VALUES ('52', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/X.mp4', '1', 'X');
INSERT INTO `multimedia` VALUES ('53', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Y.mp4', '1', 'Y');
INSERT INTO `multimedia` VALUES ('54', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Z.mp4', '1', 'Z');
INSERT INTO `multimedia` VALUES ('55', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/1.mp4', '1', '1');
INSERT INTO `multimedia` VALUES ('56', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/2.mp4', '1', '2');
INSERT INTO `multimedia` VALUES ('57', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/3.mp4', '1', '3');
INSERT INTO `multimedia` VALUES ('58', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/4.mp4', '1', '4');
INSERT INTO `multimedia` VALUES ('59', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/5.mp4', '1', '5');
INSERT INTO `multimedia` VALUES ('60', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/6.mp4', '1', '6');
INSERT INTO `multimedia` VALUES ('61', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/7.mp4', '1', '7');
INSERT INTO `multimedia` VALUES ('62', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/8.mp4', '1', '8');
INSERT INTO `multimedia` VALUES ('63', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/9.mp4', '1', '9');
INSERT INTO `multimedia` VALUES ('64', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/10.mp4', '1', '10');
INSERT INTO `multimedia` VALUES ('65', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/11.mp4', '1', '11');
INSERT INTO `multimedia` VALUES ('66', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/12.mp4', '1', '12');
INSERT INTO `multimedia` VALUES ('67', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/13.mp4', '1', '13');
INSERT INTO `multimedia` VALUES ('68', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/14.mp4', '1', '14');
INSERT INTO `multimedia` VALUES ('69', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/15.mp4', '1', '15');
INSERT INTO `multimedia` VALUES ('70', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/16.mp4', '1', '16');
INSERT INTO `multimedia` VALUES ('71', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/17.mp4', '1', '17');
INSERT INTO `multimedia` VALUES ('72', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/18.mp4', '1', '18');
INSERT INTO `multimedia` VALUES ('73', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/19.mp4', '1', '19');
INSERT INTO `multimedia` VALUES ('74', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/20.mp4', '1', '20');
INSERT INTO `multimedia` VALUES ('75', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/30.mp4', '1', '30');
INSERT INTO `multimedia` VALUES ('76', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/40.mp4', '1', '40');
INSERT INTO `multimedia` VALUES ('77', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/50.mp4', '1', '50');
INSERT INTO `multimedia` VALUES ('78', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/60.mp4', '1', '60');
INSERT INTO `multimedia` VALUES ('79', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/70.mp4', '1', '70');
INSERT INTO `multimedia` VALUES ('80', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/80.mp4', '1', '80');
INSERT INTO `multimedia` VALUES ('81', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/90.mp4', '1', '90');
INSERT INTO `multimedia` VALUES ('82', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/100.mp4', '1', '100');
INSERT INTO `multimedia` VALUES ('83', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/1.mp4', '1', 'Laboratorio de Matemáticas (Bloque 7)');
INSERT INTO `multimedia` VALUES ('84', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/2.mp4', '1', 'Laboratorio de Control Biológico (Bloque 7)');
INSERT INTO `multimedia` VALUES ('85', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/3.mp4', '1', 'Laboratorio de Física (Bloque 6)');
INSERT INTO `multimedia` VALUES ('86', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/4.mp4', '1', 'Laboratorio de Inglés (Bloque 4)');
INSERT INTO `multimedia` VALUES ('87', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/5.mp4', '1', 'Laboratorios de Biología y Química (Bloque 5)');
INSERT INTO `multimedia` VALUES ('88', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/1.mp4', '1', 'Primer piso');
INSERT INTO `multimedia` VALUES ('89', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/2.mp4', '1', 'Segundo piso');
INSERT INTO `multimedia` VALUES ('90', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/3.mp4', '1', 'Tercer piso');
INSERT INTO `multimedia` VALUES ('91', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/4.mp4', '1', 'Naranja ');
INSERT INTO `multimedia` VALUES ('92', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/5.mp4', '1', 'Azul');
INSERT INTO `multimedia` VALUES ('93', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/6.mp4', '1', 'Verde');
INSERT INTO `multimedia` VALUES ('94', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/7.mp4', '1', 'Roja');
INSERT INTO `multimedia` VALUES ('96', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/8.mp4', '1', 'Sala Virtual');
INSERT INTO `multimedia` VALUES ('97', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Cafeteria/1.mp4', '1', 'El Ché');
INSERT INTO `multimedia` VALUES ('98', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Cafeteria/2.mp4', '1', 'Tertulia');
INSERT INTO `multimedia` VALUES ('99', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Cafeteria/3.mp4', '1', 'Flor y café');
INSERT INTO `multimedia` VALUES ('100', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/1.mp4', '1', 'Contaduría publica');
INSERT INTO `multimedia` VALUES ('101', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/2.mp4', '1', 'Departamento de pedagogía');
INSERT INTO `multimedia` VALUES ('102', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/3.mp4', '1', 'Administración de empresas');
INSERT INTO `multimedia` VALUES ('103', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/4.mp4', '1', 'Cafetería');
INSERT INTO `multimedia` VALUES ('104', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/5.mp4', '1', 'Derecho');
INSERT INTO `multimedia` VALUES ('105', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/6.mp4', '1', 'Tesorería');
INSERT INTO `multimedia` VALUES ('106', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/7.mp4', '1', 'Oficina asesora de planeación ');
INSERT INTO `multimedia` VALUES ('107', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/8.mp4', '1', 'Sala de juntas');
INSERT INTO `multimedia` VALUES ('108', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/9.mp4', '1', 'Vicerrectoría administrativa');
INSERT INTO `multimedia` VALUES ('109', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/10.mp4', '1', 'Vicerrectoría de investigaciones y posgrados');
INSERT INTO `multimedia` VALUES ('110', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/11.mp4', '1', 'Rectoría');
INSERT INTO `multimedia` VALUES ('111', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/12.mp4', '1', 'Oficina asesora de relaciones internacionales');
INSERT INTO `multimedia` VALUES ('112', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/13.mp4', '1', 'Oficina de graduados');
INSERT INTO `multimedia` VALUES ('113', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/14.mp4', '1', 'Vicerrectoría académica');
INSERT INTO `multimedia` VALUES ('114', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/15.mp4', '1', 'Coordinación seguridad y salud en el trabajo');
INSERT INTO `multimedia` VALUES ('115', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/16.mp4', '1', 'Oficina asesora de control interno ');
INSERT INTO `multimedia` VALUES ('116', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/17.mp4', '1', 'Contabilidad');
INSERT INTO `multimedia` VALUES ('117', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/18.mp4', '1', 'Almacén');
INSERT INTO `multimedia` VALUES ('118', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/19.mp4', '1', 'Cuarto de comunicaciones ');
INSERT INTO `multimedia` VALUES ('119', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/20.mp4', '1', 'Maestría en administración ');
INSERT INTO `multimedia` VALUES ('120', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/21.mp4', '1', 'Coordinación de posgrados');
INSERT INTO `multimedia` VALUES ('121', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/22.mp4', '1', 'Coordinación de aplicaciones  ');
INSERT INTO `multimedia` VALUES ('122', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/23.mp4', '1', 'Coordinación de investigación y desarrollo');
INSERT INTO `multimedia` VALUES ('123', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/24.mp4', '1', 'Dirección de departamento se tecnología de la información y la comunicación');
INSERT INTO `multimedia` VALUES ('124', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/25.mp4', '1', 'Tecnología en salud ocupacional');
INSERT INTO `multimedia` VALUES ('125', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/26.mp4', '1', 'Tecnología en desarrollo de software');
INSERT INTO `multimedia` VALUES ('126', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/27.mp4', '1', 'Administración financiera');
INSERT INTO `multimedia` VALUES ('127', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/1.mp4', '1', 'Sala de cómputo 1 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('128', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/2.mp4', '1', 'Sala de cómputo 2 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('129', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/3.mp4', '1', 'Sala de cómputo 3 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('130', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/4.mp4', '1', 'Sala de cómputo 4 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('131', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/5.mp4', '1', 'Sala de cómputo 5 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('132', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/6.mp4', '1', 'Sala de cómputo 6 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('133', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/7.mp4', '1', 'Sala de cómputo 7 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('134', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/8.mp4', '1', 'Sala de cómputo 8 (Bloque 7)');
INSERT INTO `multimedia` VALUES ('135', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/9.mp4', '1', 'Sala Putumayo (Bloque 2)');
INSERT INTO `multimedia` VALUES ('136', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/10.mp4', '1', 'Sala Amazonas (Bloque 2, Segundo piso)');
INSERT INTO `multimedia` VALUES ('137', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/11.mp4', '1', 'Sala Caquetá (Bloque 3)');
INSERT INTO `multimedia` VALUES ('138', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/12.mp4', '1', 'Sala Virtual Biblioteca');
INSERT INTO `multimedia` VALUES ('139', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/13.mp4', '1', 'Sala Chairá   (Auditorio)');
INSERT INTO `multimedia` VALUES ('140', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/14.mp4', '1', 'Sala Docentes');

-- ----------------------------
-- Table structure for nivel
-- ----------------------------
DROP TABLE IF EXISTS `nivel`;
CREATE TABLE `nivel` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nivel
-- ----------------------------
INSERT INTO `nivel` VALUES ('1', 'Principiante');
INSERT INTO `nivel` VALUES ('2', 'Básico');
INSERT INTO `nivel` VALUES ('3', 'Avanzado');
INSERT INTO `nivel` VALUES ('4', 'Intermedio');

-- ----------------------------
-- Table structure for pregunta
-- ----------------------------
DROP TABLE IF EXISTS `pregunta`;
CREATE TABLE `pregunta` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(200) NOT NULL,
  `estado` int(20) NOT NULL DEFAULT '0' COMMENT '0=inactivo, 1=activo',
  `fk_temario` int(20) DEFAULT NULL,
  `fk_evaluacion` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pregunta_temario` (`fk_temario`),
  KEY `fk_pregunta_evaluacion` (`fk_evaluacion`),
  CONSTRAINT `fk_pregunta_evaluacion` FOREIGN KEY (`fk_evaluacion`) REFERENCES `evaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pregunta_temario` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pregunta
-- ----------------------------
INSERT INTO `pregunta` VALUES ('1', '¿Cuál de las siguientes imágenes es la letra A en señas?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('2', '¿Cuál de las siguientes imágenes es la letra B en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('3', '¿Cuál de las siguientes imágenes es la letra C en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('4', '¿Cuál de las siguientes imágenes es la letra D en señas?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('5', '¿Cuál de las siguientes imágenes es la letra E en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('6', '¿Cuál de las siguientes imágenes es la letra F en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('7', '¿Cuál de las siguientes imágenes es la letra G en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('8', '¿Cuál de las siguientes imágenes es la letra H en señas?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('9', '¿Cuál de las siguientes imágenes es la letra I en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('10', '¿Cuál de las siguientes imágenes es la letra J en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('11', '¿Cuál de las siguientes imágenes es la letra K en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('12', '¿Cuál de las siguientes imágenes es la letra L en señas?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('13', '¿Cuál de las siguientes imágenes es la letra M en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('14', '¿Cuál de las siguientes imágenes es la letra Ñ en señas?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('15', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('16', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('17', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('18', '¿A qué letra corresponde la imagen?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('19', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('20', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('21', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('22', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('23', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('24', '¿A qué letra corresponde la imagen?', '1', '1', '1');
INSERT INTO `pregunta` VALUES ('25', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('26', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('27', '¿A qué letra corresponde la imagen?', '1', '1', null);
INSERT INTO `pregunta` VALUES ('28', '¿Cuál de las siguientes imágenes es número 1 en señas?', '1', '2', '1');
INSERT INTO `pregunta` VALUES ('29', '¿Cuál de las siguientes imágenes es número 2 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('30', '¿Cuál de las siguientes imágenes es número 3 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('31', '¿Cuál de las siguientes imágenes es número 4 en señas?', '1', '2', '1');
INSERT INTO `pregunta` VALUES ('32', '¿Cuál de las siguientes imágenes es número 5 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('33', '¿Cuál de las siguientes imágenes es número 6 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('34', '¿Cuál de las siguientes imágenes es número 7 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('35', '¿Cuál de las siguientes imágenes es número 8 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('36', '¿Cuál de las siguientes imágenes es número 9 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('37', '¿Cuál de las siguientes imágenes es número 10 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('38', '¿Cuál de las siguientes imágenes es número 11 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('39', '¿Cuál de las siguientes imágenes es número 12 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('40', '¿Cuál de las siguientes imágenes es número 13 en señas?', '1', '2', '1');
INSERT INTO `pregunta` VALUES ('41', '¿Cuál de las siguientes imágenes es número 14 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('42', '¿Cuál de las siguientes imágenes es número 15 en señas?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('43', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('44', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('45', '¿A qué número corresponde la imagen?', '1', '2', '1');
INSERT INTO `pregunta` VALUES ('46', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('47', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('48', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('49', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('50', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('51', '¿A qué número corresponde la imagen?', '1', '2', '1');
INSERT INTO `pregunta` VALUES ('52', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('53', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('54', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('55', '¿A qué número corresponde la imagen?', '1', '2', null);
INSERT INTO `pregunta` VALUES ('56', '¿A qué laboratorio corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('57', '¿A qué laboratorio corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('58', '¿A qué laboratorio corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('59', '¿Cuál es el Laboratorio de Inglés (Bloque 4) en señas?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('60', '¿Cuál es el Laboratorios de Biología y Química (Bloque 5) en señas?', '1', '3', '1');
INSERT INTO `pregunta` VALUES ('61', '¿A qué secciones de la biblioteca corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('62', '¿A qué secciones de la biblioteca corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('63', '¿A qué secciones de la biblioteca corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('64', '¿A qué secciones de la biblioteca corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('65', '¿A qué secciones de la biblioteca corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('66', '¿Cuál es la seccion \"Verde\" de la biblioteca en señas?', '1', '3', '1');
INSERT INTO `pregunta` VALUES ('67', '¿Cuál es la seccion \"Roja\" de la biblioteca en señas?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('68', '¿Cuál es la seccion \"Sala Virtual\" de la biblioteca en señas?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('69', '¿A qué Cafetería corresponde la imagen?', '1', '3', null);
INSERT INTO `pregunta` VALUES ('70', '¿A qué Cafetería corresponde la imagen?', '1', '4', null);
INSERT INTO `pregunta` VALUES ('71', '¿A qué Cafetería corresponde la imagen?', '1', '4', '1');
INSERT INTO `pregunta` VALUES ('72', '¿A qué Oficina corresponde la imagen?', '1', '4', null);
INSERT INTO `pregunta` VALUES ('73', '¿A qué Oficina corresponde la imagen?', '1', '4', null);
INSERT INTO `pregunta` VALUES ('74', '¿A qué Oficina corresponde la imagen?', '1', '4', null);
INSERT INTO `pregunta` VALUES ('75', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('76', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('77', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('78', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('79', '¿A qué Oficina corresponde la imagen?', '1', '5', '1');
INSERT INTO `pregunta` VALUES ('80', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('81', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('82', '¿A qué Oficina corresponde la imagen?', '1', '5', null);
INSERT INTO `pregunta` VALUES ('83', '¿A qué Oficina corresponde la imagen?', '1', '6', '1');
INSERT INTO `pregunta` VALUES ('84', '¿A qué Oficina corresponde la imagen?', '1', '6', null);
INSERT INTO `pregunta` VALUES ('85', '¿A qué Oficina corresponde la imagen?', '1', '6', null);
INSERT INTO `pregunta` VALUES ('86', '¿A qué Oficina corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('87', '¿A qué Oficina corresponde la imagen?', '1', '7', '1');
INSERT INTO `pregunta` VALUES ('88', '¿A qué Oficina corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('89', '¿A qué Oficina corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('90', '¿A qué Oficina corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('91', '¿A qué Oficina corresponde la imagen?', '1', '7', '1');
INSERT INTO `pregunta` VALUES ('92', '¿Oficina de Coordinación de posgrados en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('93', '¿Oficina de Coordinación de aplicaciones en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('94', '¿Oficina de Coordinación de investigación y desarrollo en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('95', '¿Oficina de Dirección de departamento se tecnología de la información y la comunicación en señas?', '1', '7', '1');
INSERT INTO `pregunta` VALUES ('96', '¿Oficina de Tecnología en salud ocupacional en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('97', '¿Oficina de Tecnología en desarrollo de software en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('98', '¿Oficina de Administración financiera en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('99', '¿Cuál es la Sala de Cómputo 1 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('100', '¿Cuál es la Sala de Cómputo 2 bloque 7 en señas?', '1', '7', '1');
INSERT INTO `pregunta` VALUES ('101', '¿Cuál es la Sala de Cómputo 3 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('102', '¿Cuál es la Sala de Cómputo 4 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('103', '¿Cuál es la Sala de Cómputo 5 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('104', '¿Cuál es la Sala de Cómputo 6 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('105', '¿Cuál es la Sala de Cómputo 7 bloque 7 en señas?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('106', '¿A qué sala corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('107', '¿A qué sala corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('108', '¿A qué sala corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('109', '¿A qué sala corresponde la imagen?', '1', '7', '1');
INSERT INTO `pregunta` VALUES ('110', '¿A qué sala corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('111', '¿A qué sala corresponde la imagen?', '1', '7', null);
INSERT INTO `pregunta` VALUES ('112', '¿A qué sala corresponde la imagen?', '1', '7', '1');

-- ----------------------------
-- Table structure for pregunta_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `pregunta_multimedia`;
CREATE TABLE `pregunta_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_pregunta` int(20) NOT NULL,
  `fk_multimedia` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pregunta_multimedia` (`fk_pregunta`),
  KEY `fk_multimedia_pregunta` (`fk_multimedia`),
  CONSTRAINT `fk_multimedia_pregunta` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pregunta_multimedia` FOREIGN KEY (`fk_pregunta`) REFERENCES `pregunta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pregunta_multimedia
-- ----------------------------
INSERT INTO `pregunta_multimedia` VALUES ('1', '15', '42');
INSERT INTO `pregunta_multimedia` VALUES ('2', '16', '43');
INSERT INTO `pregunta_multimedia` VALUES ('3', '17', '44');
INSERT INTO `pregunta_multimedia` VALUES ('4', '18', '45');
INSERT INTO `pregunta_multimedia` VALUES ('5', '19', '46');
INSERT INTO `pregunta_multimedia` VALUES ('6', '20', '47');
INSERT INTO `pregunta_multimedia` VALUES ('7', '21', '48');
INSERT INTO `pregunta_multimedia` VALUES ('8', '22', '49');
INSERT INTO `pregunta_multimedia` VALUES ('9', '23', '50');
INSERT INTO `pregunta_multimedia` VALUES ('10', '24', '51');
INSERT INTO `pregunta_multimedia` VALUES ('11', '25', '52');
INSERT INTO `pregunta_multimedia` VALUES ('12', '26', '53');
INSERT INTO `pregunta_multimedia` VALUES ('13', '27', '54');
INSERT INTO `pregunta_multimedia` VALUES ('14', '43', '70');
INSERT INTO `pregunta_multimedia` VALUES ('15', '44', '71');
INSERT INTO `pregunta_multimedia` VALUES ('16', '45', '72');
INSERT INTO `pregunta_multimedia` VALUES ('17', '46', '73');
INSERT INTO `pregunta_multimedia` VALUES ('18', '47', '74');
INSERT INTO `pregunta_multimedia` VALUES ('19', '48', '75');
INSERT INTO `pregunta_multimedia` VALUES ('20', '49', '76');
INSERT INTO `pregunta_multimedia` VALUES ('21', '50', '77');
INSERT INTO `pregunta_multimedia` VALUES ('22', '51', '78');
INSERT INTO `pregunta_multimedia` VALUES ('23', '52', '79');
INSERT INTO `pregunta_multimedia` VALUES ('24', '53', '80');
INSERT INTO `pregunta_multimedia` VALUES ('25', '54', '81');
INSERT INTO `pregunta_multimedia` VALUES ('26', '55', '82');
INSERT INTO `pregunta_multimedia` VALUES ('27', '56', '83');
INSERT INTO `pregunta_multimedia` VALUES ('28', '57', '84');
INSERT INTO `pregunta_multimedia` VALUES ('29', '58', '85');
INSERT INTO `pregunta_multimedia` VALUES ('30', '61', '88');
INSERT INTO `pregunta_multimedia` VALUES ('31', '62', '89');
INSERT INTO `pregunta_multimedia` VALUES ('32', '63', '90');
INSERT INTO `pregunta_multimedia` VALUES ('33', '64', '91');
INSERT INTO `pregunta_multimedia` VALUES ('34', '65', '92');
INSERT INTO `pregunta_multimedia` VALUES ('35', '69', '97');
INSERT INTO `pregunta_multimedia` VALUES ('36', '70', '98');
INSERT INTO `pregunta_multimedia` VALUES ('37', '71', '99');
INSERT INTO `pregunta_multimedia` VALUES ('38', '72', '100');
INSERT INTO `pregunta_multimedia` VALUES ('39', '73', '101');
INSERT INTO `pregunta_multimedia` VALUES ('40', '74', '102');
INSERT INTO `pregunta_multimedia` VALUES ('41', '75', '103');
INSERT INTO `pregunta_multimedia` VALUES ('42', '76', '104');
INSERT INTO `pregunta_multimedia` VALUES ('43', '77', '105');
INSERT INTO `pregunta_multimedia` VALUES ('44', '78', '106');
INSERT INTO `pregunta_multimedia` VALUES ('45', '79', '107');
INSERT INTO `pregunta_multimedia` VALUES ('46', '80', '108');
INSERT INTO `pregunta_multimedia` VALUES ('47', '81', '109');
INSERT INTO `pregunta_multimedia` VALUES ('48', '82', '110');
INSERT INTO `pregunta_multimedia` VALUES ('49', '83', '111');
INSERT INTO `pregunta_multimedia` VALUES ('50', '84', '112');
INSERT INTO `pregunta_multimedia` VALUES ('51', '85', '113');
INSERT INTO `pregunta_multimedia` VALUES ('52', '86', '114');
INSERT INTO `pregunta_multimedia` VALUES ('53', '87', '115');
INSERT INTO `pregunta_multimedia` VALUES ('54', '88', '116');
INSERT INTO `pregunta_multimedia` VALUES ('55', '89', '117');
INSERT INTO `pregunta_multimedia` VALUES ('56', '90', '118');
INSERT INTO `pregunta_multimedia` VALUES ('57', '91', '119');
INSERT INTO `pregunta_multimedia` VALUES ('58', '106', '134');
INSERT INTO `pregunta_multimedia` VALUES ('59', '107', '135');
INSERT INTO `pregunta_multimedia` VALUES ('60', '108', '136');
INSERT INTO `pregunta_multimedia` VALUES ('61', '109', '137');
INSERT INTO `pregunta_multimedia` VALUES ('62', '110', '138');
INSERT INTO `pregunta_multimedia` VALUES ('63', '111', '139');
INSERT INTO `pregunta_multimedia` VALUES ('64', '112', '140');

-- ----------------------------
-- Table structure for respuesta
-- ----------------------------
DROP TABLE IF EXISTS `respuesta`;
CREATE TABLE `respuesta` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `contenido` varchar(80) DEFAULT NULL,
  `fk_pregunta` int(20) NOT NULL,
  `correcta` int(20) NOT NULL DEFAULT '0' COMMENT '0=Incorrecta, 1=correcta',
  `fk_multimedia` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_respuesta_pregunta` (`fk_pregunta`),
  KEY `fk_respuesta_multimedia` (`fk_multimedia`),
  CONSTRAINT `fk_respuesta_multimedia` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_respuesta_pregunta` FOREIGN KEY (`fk_pregunta`) REFERENCES `pregunta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuesta
-- ----------------------------
INSERT INTO `respuesta` VALUES ('159', '', '1', '0', '41');
INSERT INTO `respuesta` VALUES ('160', '', '1', '1', '28');
INSERT INTO `respuesta` VALUES ('161', '', '1', '0', '31');
INSERT INTO `respuesta` VALUES ('162', '', '1', '0', '46');
INSERT INTO `respuesta` VALUES ('163', '', '2', '0', '39');
INSERT INTO `respuesta` VALUES ('164', '', '2', '0', '48');
INSERT INTO `respuesta` VALUES ('165', '', '2', '1', '29');
INSERT INTO `respuesta` VALUES ('166', '', '2', '0', '42');
INSERT INTO `respuesta` VALUES ('167', '', '3', '0', '51');
INSERT INTO `respuesta` VALUES ('168', '', '3', '1', '30');
INSERT INTO `respuesta` VALUES ('169', '', '3', '0', '40');
INSERT INTO `respuesta` VALUES ('170', '', '3', '0', '36');
INSERT INTO `respuesta` VALUES ('171', '', '4', '0', '53');
INSERT INTO `respuesta` VALUES ('172', '', '4', '1', '31');
INSERT INTO `respuesta` VALUES ('173', '', '4', '0', '41');
INSERT INTO `respuesta` VALUES ('174', '', '4', '0', '48');
INSERT INTO `respuesta` VALUES ('175', '', '5', '0', '35');
INSERT INTO `respuesta` VALUES ('176', '', '5', '1', '32');
INSERT INTO `respuesta` VALUES ('177', '', '5', '0', '34');
INSERT INTO `respuesta` VALUES ('178', '', '5', '0', '31');
INSERT INTO `respuesta` VALUES ('179', '', '6', '0', '45');
INSERT INTO `respuesta` VALUES ('180', '', '6', '1', '33');
INSERT INTO `respuesta` VALUES ('181', '', '6', '0', '28');
INSERT INTO `respuesta` VALUES ('182', '', '6', '0', '37');
INSERT INTO `respuesta` VALUES ('183', '', '7', '1', '34');
INSERT INTO `respuesta` VALUES ('184', '', '7', '0', '47');
INSERT INTO `respuesta` VALUES ('185', '', '7', '0', '40');
INSERT INTO `respuesta` VALUES ('186', '', '7', '0', '50');
INSERT INTO `respuesta` VALUES ('187', '', '8', '1', '35');
INSERT INTO `respuesta` VALUES ('188', '', '8', '0', '35');
INSERT INTO `respuesta` VALUES ('189', '', '8', '0', '45');
INSERT INTO `respuesta` VALUES ('190', '', '8', '0', '35');
INSERT INTO `respuesta` VALUES ('191', '', '9', '0', '43');
INSERT INTO `respuesta` VALUES ('192', '', '9', '0', '35');
INSERT INTO `respuesta` VALUES ('193', '', '9', '1', '36');
INSERT INTO `respuesta` VALUES ('194', '', '9', '0', '34');
INSERT INTO `respuesta` VALUES ('195', '', '10', '0', '35');
INSERT INTO `respuesta` VALUES ('196', '', '10', '1', '37');
INSERT INTO `respuesta` VALUES ('197', '', '10', '0', '29');
INSERT INTO `respuesta` VALUES ('198', '', '10', '0', '44');
INSERT INTO `respuesta` VALUES ('199', '', '11', '1', '38');
INSERT INTO `respuesta` VALUES ('200', '', '11', '0', '49');
INSERT INTO `respuesta` VALUES ('201', '', '11', '0', '42');
INSERT INTO `respuesta` VALUES ('202', '', '11', '0', '36');
INSERT INTO `respuesta` VALUES ('203', '', '12', '1', '39');
INSERT INTO `respuesta` VALUES ('204', '', '12', '0', '33');
INSERT INTO `respuesta` VALUES ('205', '', '12', '0', '31');
INSERT INTO `respuesta` VALUES ('206', '', '12', '0', '42');
INSERT INTO `respuesta` VALUES ('207', '', '13', '0', '49');
INSERT INTO `respuesta` VALUES ('208', '', '13', '0', '39');
INSERT INTO `respuesta` VALUES ('209', '', '13', '1', '40');
INSERT INTO `respuesta` VALUES ('210', '', '13', '0', '37');
INSERT INTO `respuesta` VALUES ('211', '', '14', '1', '41');
INSERT INTO `respuesta` VALUES ('212', '', '14', '0', '45');
INSERT INTO `respuesta` VALUES ('213', '', '14', '0', '34');
INSERT INTO `respuesta` VALUES ('214', '', '14', '0', '39');
INSERT INTO `respuesta` VALUES ('215', 'Ñ', '15', '1', null);
INSERT INTO `respuesta` VALUES ('216', 'V ', '15', '0', null);
INSERT INTO `respuesta` VALUES ('217', 'X ', '15', '0', null);
INSERT INTO `respuesta` VALUES ('218', 'Z ', '15', '0', null);
INSERT INTO `respuesta` VALUES ('219', 'H ', '16', '0', null);
INSERT INTO `respuesta` VALUES ('220', 'O ', '16', '1', null);
INSERT INTO `respuesta` VALUES ('221', 'T ', '16', '0', null);
INSERT INTO `respuesta` VALUES ('222', 'U ', '16', '0', null);
INSERT INTO `respuesta` VALUES ('223', 'D ', '17', '0', null);
INSERT INTO `respuesta` VALUES ('224', 'P ', '17', '1', null);
INSERT INTO `respuesta` VALUES ('225', 'K ', '17', '0', null);
INSERT INTO `respuesta` VALUES ('226', 'F ', '17', '0', null);
INSERT INTO `respuesta` VALUES ('227', 'L ', '18', '0', null);
INSERT INTO `respuesta` VALUES ('228', 'Q ', '18', '1', null);
INSERT INTO `respuesta` VALUES ('229', 'J ', '18', '0', null);
INSERT INTO `respuesta` VALUES ('230', 'I ', '18', '0', null);
INSERT INTO `respuesta` VALUES ('231', 'I ', '19', '0', null);
INSERT INTO `respuesta` VALUES ('232', 'X ', '19', '0', null);
INSERT INTO `respuesta` VALUES ('233', 'R ', '19', '1', null);
INSERT INTO `respuesta` VALUES ('234', 'P ', '19', '0', null);
INSERT INTO `respuesta` VALUES ('235', 'O ', '20', '0', null);
INSERT INTO `respuesta` VALUES ('236', 'S ', '20', '1', null);
INSERT INTO `respuesta` VALUES ('237', 'B ', '20', '0', null);
INSERT INTO `respuesta` VALUES ('238', 'Q ', '20', '0', null);
INSERT INTO `respuesta` VALUES ('239', 'W ', '21', '0', null);
INSERT INTO `respuesta` VALUES ('240', 'T ', '21', '1', null);
INSERT INTO `respuesta` VALUES ('241', 'M ', '21', '0', null);
INSERT INTO `respuesta` VALUES ('242', 'O ', '21', '0', null);
INSERT INTO `respuesta` VALUES ('243', 'R ', '22', '0', null);
INSERT INTO `respuesta` VALUES ('244', 'H ', '22', '0', null);
INSERT INTO `respuesta` VALUES ('245', 'U ', '22', '1', null);
INSERT INTO `respuesta` VALUES ('246', 'A ', '22', '0', null);
INSERT INTO `respuesta` VALUES ('247', 'R ', '23', '0', null);
INSERT INTO `respuesta` VALUES ('248', 'V ', '23', '1', null);
INSERT INTO `respuesta` VALUES ('249', 'D ', '23', '0', null);
INSERT INTO `respuesta` VALUES ('250', 'R ', '23', '0', null);
INSERT INTO `respuesta` VALUES ('251', 'S ', '24', '0', null);
INSERT INTO `respuesta` VALUES ('252', 'J ', '24', '0', null);
INSERT INTO `respuesta` VALUES ('253', 'W ', '24', '1', null);
INSERT INTO `respuesta` VALUES ('254', 'A', '24', '0', null);
INSERT INTO `respuesta` VALUES ('255', 'Z ', '25', '0', null);
INSERT INTO `respuesta` VALUES ('256', 'X ', '25', '1', null);
INSERT INTO `respuesta` VALUES ('257', 'D ', '25', '0', null);
INSERT INTO `respuesta` VALUES ('258', 'Ñ', '25', '0', null);
INSERT INTO `respuesta` VALUES ('259', 'O ', '26', '0', null);
INSERT INTO `respuesta` VALUES ('260', 'S ', '26', '0', null);
INSERT INTO `respuesta` VALUES ('261', 'Y ', '26', '1', null);
INSERT INTO `respuesta` VALUES ('262', 'A ', '26', '0', null);
INSERT INTO `respuesta` VALUES ('263', 'S ', '27', '0', null);
INSERT INTO `respuesta` VALUES ('264', 'Z ', '27', '1', null);
INSERT INTO `respuesta` VALUES ('265', 'B ', '27', '0', null);
INSERT INTO `respuesta` VALUES ('266', 'P ', '27', '0', null);
INSERT INTO `respuesta` VALUES ('267', '', '28', '0', '71');
INSERT INTO `respuesta` VALUES ('268', '', '28', '1', '55');
INSERT INTO `respuesta` VALUES ('269', '', '28', '0', '67');
INSERT INTO `respuesta` VALUES ('270', '', '28', '0', '64');
INSERT INTO `respuesta` VALUES ('271', '', '29', '0', '61');
INSERT INTO `respuesta` VALUES ('272', '', '29', '0', '72');
INSERT INTO `respuesta` VALUES ('273', '', '29', '1', '56');
INSERT INTO `respuesta` VALUES ('274', '', '29', '0', '59');
INSERT INTO `respuesta` VALUES ('275', '', '30', '1', '57');
INSERT INTO `respuesta` VALUES ('276', '', '30', '0', '68');
INSERT INTO `respuesta` VALUES ('277', '', '30', '0', '70');
INSERT INTO `respuesta` VALUES ('278', '', '30', '0', '67');
INSERT INTO `respuesta` VALUES ('279', '', '31', '0', '61');
INSERT INTO `respuesta` VALUES ('280', '', '31', '1', '58');
INSERT INTO `respuesta` VALUES ('281', '', '31', '0', '65');
INSERT INTO `respuesta` VALUES ('282', '', '31', '0', '57');
INSERT INTO `respuesta` VALUES ('283', '', '32', '0', '75');
INSERT INTO `respuesta` VALUES ('284', '', '32', '0', '58');
INSERT INTO `respuesta` VALUES ('285', '', '32', '1', '59');
INSERT INTO `respuesta` VALUES ('286', '', '32', '0', '56');
INSERT INTO `respuesta` VALUES ('287', '', '33', '0', '76');
INSERT INTO `respuesta` VALUES ('288', '', '33', '1', '60');
INSERT INTO `respuesta` VALUES ('289', '', '33', '0', '75');
INSERT INTO `respuesta` VALUES ('290', '', '33', '0', '57');
INSERT INTO `respuesta` VALUES ('291', '', '34', '0', '78');
INSERT INTO `respuesta` VALUES ('292', '', '34', '0', '55');
INSERT INTO `respuesta` VALUES ('293', '', '34', '1', '61');
INSERT INTO `respuesta` VALUES ('294', '', '34', '0', '80');
INSERT INTO `respuesta` VALUES ('295', '', '35', '0', '57');
INSERT INTO `respuesta` VALUES ('296', '', '35', '0', '55');
INSERT INTO `respuesta` VALUES ('297', '', '35', '1', '62');
INSERT INTO `respuesta` VALUES ('298', '', '35', '0', '67');
INSERT INTO `respuesta` VALUES ('299', '', '36', '0', '68');
INSERT INTO `respuesta` VALUES ('300', '', '36', '1', '63');
INSERT INTO `respuesta` VALUES ('301', '', '36', '0', '62');
INSERT INTO `respuesta` VALUES ('302', '', '36', '0', '65');
INSERT INTO `respuesta` VALUES ('303', '', '37', '0', '80');
INSERT INTO `respuesta` VALUES ('304', '', '37', '1', '64');
INSERT INTO `respuesta` VALUES ('305', '', '37', '0', '69');
INSERT INTO `respuesta` VALUES ('306', '', '37', '0', '82');
INSERT INTO `respuesta` VALUES ('307', '', '38', '0', '74');
INSERT INTO `respuesta` VALUES ('308', '', '38', '1', '65');
INSERT INTO `respuesta` VALUES ('309', '', '38', '0', '58');
INSERT INTO `respuesta` VALUES ('310', '', '38', '0', '60');
INSERT INTO `respuesta` VALUES ('311', '', '39', '1', '66');
INSERT INTO `respuesta` VALUES ('312', '', '39', '0', '65');
INSERT INTO `respuesta` VALUES ('313', '', '39', '0', '75');
INSERT INTO `respuesta` VALUES ('314', '', '39', '0', '58');
INSERT INTO `respuesta` VALUES ('315', '', '40', '0', '58');
INSERT INTO `respuesta` VALUES ('316', '', '40', '1', '67');
INSERT INTO `respuesta` VALUES ('317', '', '40', '0', '65');
INSERT INTO `respuesta` VALUES ('318', '', '40', '0', '69');
INSERT INTO `respuesta` VALUES ('319', '', '41', '0', '65');
INSERT INTO `respuesta` VALUES ('320', '', '41', '0', '59');
INSERT INTO `respuesta` VALUES ('321', '', '41', '1', '68');
INSERT INTO `respuesta` VALUES ('322', '', '41', '0', '72');
INSERT INTO `respuesta` VALUES ('323', '', '42', '1', '69');
INSERT INTO `respuesta` VALUES ('324', '', '42', '0', '78');
INSERT INTO `respuesta` VALUES ('325', '', '42', '0', '79');
INSERT INTO `respuesta` VALUES ('326', '', '42', '0', '76');
INSERT INTO `respuesta` VALUES ('327', '11', '43', '0', null);
INSERT INTO `respuesta` VALUES ('328', '16', '43', '1', null);
INSERT INTO `respuesta` VALUES ('329', '4', '43', '0', null);
INSERT INTO `respuesta` VALUES ('330', '2', '43', '0', null);
INSERT INTO `respuesta` VALUES ('331', '17', '44', '1', null);
INSERT INTO `respuesta` VALUES ('332', '2', '44', '0', null);
INSERT INTO `respuesta` VALUES ('333', '11', '44', '0', null);
INSERT INTO `respuesta` VALUES ('334', '40', '44', '0', null);
INSERT INTO `respuesta` VALUES ('335', '18', '45', '1', null);
INSERT INTO `respuesta` VALUES ('336', '17', '45', '0', null);
INSERT INTO `respuesta` VALUES ('337', '12', '45', '0', null);
INSERT INTO `respuesta` VALUES ('338', '7', '45', '0', null);
INSERT INTO `respuesta` VALUES ('339', '20', '46', '0', null);
INSERT INTO `respuesta` VALUES ('340', '50', '46', '0', null);
INSERT INTO `respuesta` VALUES ('341', '19', '46', '1', null);
INSERT INTO `respuesta` VALUES ('342', '2', '46', '0', null);
INSERT INTO `respuesta` VALUES ('343', '50', '47', '0', null);
INSERT INTO `respuesta` VALUES ('344', '4', '47', '0', null);
INSERT INTO `respuesta` VALUES ('345', '20', '47', '1', null);
INSERT INTO `respuesta` VALUES ('346', '9', '47', '0', null);
INSERT INTO `respuesta` VALUES ('347', '30', '48', '1', null);
INSERT INTO `respuesta` VALUES ('348', '40', '48', '0', null);
INSERT INTO `respuesta` VALUES ('349', '3', '48', '0', null);
INSERT INTO `respuesta` VALUES ('350', '11', '48', '0', null);
INSERT INTO `respuesta` VALUES ('351', '40', '49', '1', null);
INSERT INTO `respuesta` VALUES ('352', '5', '49', '0', null);
INSERT INTO `respuesta` VALUES ('353', '60', '49', '0', null);
INSERT INTO `respuesta` VALUES ('354', '5', '49', '0', null);
INSERT INTO `respuesta` VALUES ('355', '50', '50', '1', null);
INSERT INTO `respuesta` VALUES ('356', '60', '50', '0', null);
INSERT INTO `respuesta` VALUES ('357', '14', '50', '0', null);
INSERT INTO `respuesta` VALUES ('358', '20', '50', '0', null);
INSERT INTO `respuesta` VALUES ('359', '7', '51', '0', null);
INSERT INTO `respuesta` VALUES ('360', '18', '51', '0', null);
INSERT INTO `respuesta` VALUES ('361', '60', '51', '1', null);
INSERT INTO `respuesta` VALUES ('362', '90', '51', '0', null);
INSERT INTO `respuesta` VALUES ('363', '70', '52', '1', null);
INSERT INTO `respuesta` VALUES ('364', '50', '52', '0', null);
INSERT INTO `respuesta` VALUES ('365', '90', '52', '0', null);
INSERT INTO `respuesta` VALUES ('366', '16', '52', '0', null);
INSERT INTO `respuesta` VALUES ('367', '80', '53', '1', null);
INSERT INTO `respuesta` VALUES ('368', '17', '53', '0', null);
INSERT INTO `respuesta` VALUES ('369', '13', '53', '0', null);
INSERT INTO `respuesta` VALUES ('370', '9', '53', '0', null);
INSERT INTO `respuesta` VALUES ('371', '17', '54', '0', null);
INSERT INTO `respuesta` VALUES ('372', '90', '54', '1', null);
INSERT INTO `respuesta` VALUES ('373', '16', '54', '0', null);
INSERT INTO `respuesta` VALUES ('374', '12', '54', '0', null);
INSERT INTO `respuesta` VALUES ('375', '100', '55', '1', null);
INSERT INTO `respuesta` VALUES ('376', '2', '55', '0', null);
INSERT INTO `respuesta` VALUES ('377', '5', '55', '0', null);
INSERT INTO `respuesta` VALUES ('378', '12', '55', '0', null);
INSERT INTO `respuesta` VALUES ('379', '', '56', '0', '84');
INSERT INTO `respuesta` VALUES ('380', '', '56', '1', '83');
INSERT INTO `respuesta` VALUES ('381', '', '56', '0', '85');
INSERT INTO `respuesta` VALUES ('382', '', '57', '0', '87');
INSERT INTO `respuesta` VALUES ('383', '', '57', '0', '83');
INSERT INTO `respuesta` VALUES ('384', '', '57', '1', '84');
INSERT INTO `respuesta` VALUES ('385', '', '58', '0', '84');
INSERT INTO `respuesta` VALUES ('386', '', '58', '1', '85');
INSERT INTO `respuesta` VALUES ('387', '', '58', '0', '87');
INSERT INTO `respuesta` VALUES ('388', '', '59', '1', '86');
INSERT INTO `respuesta` VALUES ('389', '', '59', '0', '87');
INSERT INTO `respuesta` VALUES ('390', '', '59', '0', '85');
INSERT INTO `respuesta` VALUES ('391', '', '60', '0', '83');
INSERT INTO `respuesta` VALUES ('392', '', '60', '0', '84');
INSERT INTO `respuesta` VALUES ('393', '', '60', '1', '87');
INSERT INTO `respuesta` VALUES ('394', '', '61', '0', '93');
INSERT INTO `respuesta` VALUES ('395', '', '61', '1', '88');
INSERT INTO `respuesta` VALUES ('396', '', '61', '0', '92');
INSERT INTO `respuesta` VALUES ('397', '', '62', '1', '89');
INSERT INTO `respuesta` VALUES ('398', '', '62', '0', '88');
INSERT INTO `respuesta` VALUES ('399', '', '62', '0', '93');
INSERT INTO `respuesta` VALUES ('400', 'Primer piso ', '63', '0', null);
INSERT INTO `respuesta` VALUES ('401', 'Tercer piso ', '63', '1', null);
INSERT INTO `respuesta` VALUES ('402', 'Segundo piso ', '63', '0', null);
INSERT INTO `respuesta` VALUES ('403', 'Roja ', '64', '0', null);
INSERT INTO `respuesta` VALUES ('404', 'Primer piso ', '64', '0', null);
INSERT INTO `respuesta` VALUES ('405', 'Naranja  ', '64', '1', null);
INSERT INTO `respuesta` VALUES ('406', 'Tercer piso ', '65', '0', null);
INSERT INTO `respuesta` VALUES ('407', 'Azul ', '65', '1', null);
INSERT INTO `respuesta` VALUES ('408', 'Primer piso ', '65', '0', null);
INSERT INTO `respuesta` VALUES ('409', 'Verde ', '66', '1', null);
INSERT INTO `respuesta` VALUES ('410', 'Primer piso ', '66', '0', null);
INSERT INTO `respuesta` VALUES ('411', 'Roja ', '66', '0', null);
INSERT INTO `respuesta` VALUES ('412', 'Azul ', '67', '0', null);
INSERT INTO `respuesta` VALUES ('413', 'Primer piso ', '67', '0', null);
INSERT INTO `respuesta` VALUES ('414', 'Roja ', '67', '1', null);
INSERT INTO `respuesta` VALUES ('415', 'Sala Virtual ', '68', '1', null);
INSERT INTO `respuesta` VALUES ('416', 'Tercer piso ', '68', '0', null);
INSERT INTO `respuesta` VALUES ('417', 'Roja ', '68', '0', null);
INSERT INTO `respuesta` VALUES ('418', 'El Ché', '69', '1', null);
INSERT INTO `respuesta` VALUES ('419', 'Tertulia ', '69', '0', null);
INSERT INTO `respuesta` VALUES ('420', 'Flor y café', '69', '0', null);
INSERT INTO `respuesta` VALUES ('421', 'Flor y café', '70', '0', null);
INSERT INTO `respuesta` VALUES ('422', 'Contaduría publica ', '70', '0', null);
INSERT INTO `respuesta` VALUES ('423', 'Tertulia ', '70', '1', null);
INSERT INTO `respuesta` VALUES ('424', 'Tertulia ', '71', '0', null);
INSERT INTO `respuesta` VALUES ('425', 'Contaduría publica ', '71', '0', null);
INSERT INTO `respuesta` VALUES ('426', 'Flor y café', '71', '1', null);
INSERT INTO `respuesta` VALUES ('427', 'Contaduría publica ', '72', '1', null);
INSERT INTO `respuesta` VALUES ('428', 'Administración de empresas ', '72', '0', null);
INSERT INTO `respuesta` VALUES ('429', 'Departamento de pedagogía ', '72', '0', null);
INSERT INTO `respuesta` VALUES ('430', 'Derecho ', '72', '0', null);
INSERT INTO `respuesta` VALUES ('431', '', '73', '0', '106');
INSERT INTO `respuesta` VALUES ('432', '', '73', '1', '101');
INSERT INTO `respuesta` VALUES ('433', '', '73', '0', '122');
INSERT INTO `respuesta` VALUES ('434', '', '73', '0', '118');
INSERT INTO `respuesta` VALUES ('435', '', '74', '0', '104');
INSERT INTO `respuesta` VALUES ('436', '', '74', '0', '106');
INSERT INTO `respuesta` VALUES ('437', '', '74', '1', '102');
INSERT INTO `respuesta` VALUES ('438', '', '74', '0', '106');
INSERT INTO `respuesta` VALUES ('439', 'Rectoría ', '75', '0', null);
INSERT INTO `respuesta` VALUES ('440', 'Cafetería ', '75', '1', null);
INSERT INTO `respuesta` VALUES ('441', 'Derecho ', '75', '0', null);
INSERT INTO `respuesta` VALUES ('442', 'Oficina asesora de planeación  ', '75', '0', null);
INSERT INTO `respuesta` VALUES ('443', 'Departamento de pedagogía ', '76', '0', null);
INSERT INTO `respuesta` VALUES ('444', 'Cuarto de comunicaciones  ', '76', '0', null);
INSERT INTO `respuesta` VALUES ('445', 'Derecho ', '76', '1', null);
INSERT INTO `respuesta` VALUES ('446', 'Oficina asesora de planeación  ', '76', '0', null);
INSERT INTO `respuesta` VALUES ('447', 'Tesorería ', '77', '1', null);
INSERT INTO `respuesta` VALUES ('448', 'Departamento de pedagogía ', '77', '0', null);
INSERT INTO `respuesta` VALUES ('449', 'Tecnología en salud ocupacional ', '77', '0', null);
INSERT INTO `respuesta` VALUES ('450', 'Sala de juntas ', '77', '0', null);
INSERT INTO `respuesta` VALUES ('451', 'Oficina asesora de planeación  ', '78', '1', null);
INSERT INTO `respuesta` VALUES ('452', 'Tecnología en salud ocupacional ', '78', '0', null);
INSERT INTO `respuesta` VALUES ('453', 'Sala de cómputo 1 (Bloque 7) ', '78', '0', null);
INSERT INTO `respuesta` VALUES ('454', 'Derecho ', '78', '0', null);
INSERT INTO `respuesta` VALUES ('455', 'Sala de juntas ', '79', '1', null);
INSERT INTO `respuesta` VALUES ('456', 'Derecho ', '79', '0', null);
INSERT INTO `respuesta` VALUES ('457', 'Coordinación seguridad y salud en el trabajo ', '79', '0', null);
INSERT INTO `respuesta` VALUES ('458', 'Contabilidad ', '79', '0', null);
INSERT INTO `respuesta` VALUES ('459', '', '80', '0', '106');
INSERT INTO `respuesta` VALUES ('460', '', '80', '0', '105');
INSERT INTO `respuesta` VALUES ('461', '', '80', '1', '108');
INSERT INTO `respuesta` VALUES ('462', '', '80', '0', '125');
INSERT INTO `respuesta` VALUES ('463', '', '81', '0', '111');
INSERT INTO `respuesta` VALUES ('464', '', '81', '1', '109');
INSERT INTO `respuesta` VALUES ('465', '', '81', '0', '101');
INSERT INTO `respuesta` VALUES ('466', '', '81', '0', '116');
INSERT INTO `respuesta` VALUES ('467', '', '82', '0', '103');
INSERT INTO `respuesta` VALUES ('468', '', '82', '1', '110');
INSERT INTO `respuesta` VALUES ('469', '', '82', '0', '123');
INSERT INTO `respuesta` VALUES ('470', '', '82', '0', '107');
INSERT INTO `respuesta` VALUES ('471', 'Oficina asesora de relaciones internacionales ', '83', '1', null);
INSERT INTO `respuesta` VALUES ('472', 'Cuarto de comunicaciones  ', '83', '0', null);
INSERT INTO `respuesta` VALUES ('473', 'Administración de empresas ', '83', '0', null);
INSERT INTO `respuesta` VALUES ('474', 'Coordinación de posgrados ', '83', '0', null);
INSERT INTO `respuesta` VALUES ('475', 'Tecnología en desarrollo de software ', '84', '0', null);
INSERT INTO `respuesta` VALUES ('476', 'Oficina de graduados ', '84', '1', null);
INSERT INTO `respuesta` VALUES ('477', 'Oficina asesora de planeación  ', '84', '0', null);
INSERT INTO `respuesta` VALUES ('478', 'Administración de empresas ', '84', '0', null);
INSERT INTO `respuesta` VALUES ('479', 'Vicerrectoría académica ', '85', '1', null);
INSERT INTO `respuesta` VALUES ('480', 'Derecho ', '85', '0', null);
INSERT INTO `respuesta` VALUES ('481', 'Sala de juntas ', '85', '0', null);
INSERT INTO `respuesta` VALUES ('482', 'Coordinación seguridad y salud en el trabajo ', '85', '0', null);
INSERT INTO `respuesta` VALUES ('483', 'Coordinación seguridad y salud en el trabajo ', '86', '1', null);
INSERT INTO `respuesta` VALUES ('484', 'Coordinación de aplicaciones   ', '86', '0', null);
INSERT INTO `respuesta` VALUES ('485', 'Oficina asesora de control interno  ', '86', '0', null);
INSERT INTO `respuesta` VALUES ('486', 'Dirección de departamento se tecnología de la información y la comunicación ', '86', '0', null);
INSERT INTO `respuesta` VALUES ('487', 'Vicerrectoría académica ', '87', '0', null);
INSERT INTO `respuesta` VALUES ('488', 'Coordinación de investigación y desarrollo ', '87', '0', null);
INSERT INTO `respuesta` VALUES ('489', 'Oficina asesora de control interno  ', '87', '1', null);
INSERT INTO `respuesta` VALUES ('490', 'Cuarto de comunicaciones  ', '87', '0', null);
INSERT INTO `respuesta` VALUES ('491', 'Contabilidad ', '88', '1', null);
INSERT INTO `respuesta` VALUES ('492', 'Oficina asesora de control interno  ', '88', '0', null);
INSERT INTO `respuesta` VALUES ('493', 'Coordinación de aplicaciones   ', '88', '0', null);
INSERT INTO `respuesta` VALUES ('494', 'Almacén ', '88', '0', null);
INSERT INTO `respuesta` VALUES ('495', 'Almacén ', '89', '1', null);
INSERT INTO `respuesta` VALUES ('496', 'Oficina asesora de control interno  ', '89', '0', null);
INSERT INTO `respuesta` VALUES ('497', 'Oficina asesora de planeación  ', '89', '0', null);
INSERT INTO `respuesta` VALUES ('498', 'Oficina de graduados ', '89', '0', null);
INSERT INTO `respuesta` VALUES ('499', 'Vicerrectoría académica ', '90', '0', null);
INSERT INTO `respuesta` VALUES ('500', 'Cuarto de comunicaciones  ', '90', '1', null);
INSERT INTO `respuesta` VALUES ('501', 'Oficina de graduados ', '90', '0', null);
INSERT INTO `respuesta` VALUES ('502', 'Derecho ', '90', '0', null);
INSERT INTO `respuesta` VALUES ('503', 'Maestría en administración  ', '91', '1', null);
INSERT INTO `respuesta` VALUES ('504', 'Coordinación de investigación y desarrollo ', '91', '0', null);
INSERT INTO `respuesta` VALUES ('505', 'Derecho ', '91', '0', null);
INSERT INTO `respuesta` VALUES ('506', 'Oficina asesora de relaciones internacionales ', '91', '0', null);
INSERT INTO `respuesta` VALUES ('507', 'Coordinación de posgrados ', '92', '1', null);
INSERT INTO `respuesta` VALUES ('508', 'Oficina asesora de relaciones internacionales ', '92', '0', null);
INSERT INTO `respuesta` VALUES ('509', 'Vicerrectoría académica ', '92', '0', null);
INSERT INTO `respuesta` VALUES ('510', 'Oficina asesora de control interno  ', '92', '0', null);
INSERT INTO `respuesta` VALUES ('511', 'Sala de cómputo 1 (Bloque 7) ', '93', '0', null);
INSERT INTO `respuesta` VALUES ('512', 'Coordinación seguridad y salud en el trabajo ', '93', '0', null);
INSERT INTO `respuesta` VALUES ('513', 'Coordinación de aplicaciones   ', '93', '1', null);
INSERT INTO `respuesta` VALUES ('514', 'Oficina asesora de control interno  ', '93', '0', null);
INSERT INTO `respuesta` VALUES ('515', 'Vicerrectoría académica ', '94', '0', null);
INSERT INTO `respuesta` VALUES ('516', 'Sala de cómputo 1 (Bloque 7) ', '94', '0', null);
INSERT INTO `respuesta` VALUES ('517', 'Coordinación de investigación y desarrollo ', '94', '1', null);
INSERT INTO `respuesta` VALUES ('518', 'Administración de empresas ', '94', '0', null);
INSERT INTO `respuesta` VALUES ('519', 'Dirección de departamento se tecnología de la información y la comunicación ', '95', '1', null);
INSERT INTO `respuesta` VALUES ('520', 'Derecho ', '95', '0', null);
INSERT INTO `respuesta` VALUES ('521', 'Oficina asesora de control interno  ', '95', '0', null);
INSERT INTO `respuesta` VALUES ('522', 'Tecnología en salud ocupacional ', '95', '0', null);
INSERT INTO `respuesta` VALUES ('523', 'Coordinación de posgrados ', '96', '0', null);
INSERT INTO `respuesta` VALUES ('524', 'Vicerrectoría de investigaciones y posgrados ', '96', '0', null);
INSERT INTO `respuesta` VALUES ('525', 'Tecnología en salud ocupacional ', '96', '1', null);
INSERT INTO `respuesta` VALUES ('526', 'Sala de cómputo 1 (Bloque 7) ', '96', '0', null);
INSERT INTO `respuesta` VALUES ('527', 'Contabilidad ', '97', '0', null);
INSERT INTO `respuesta` VALUES ('528', 'Derecho ', '97', '0', null);
INSERT INTO `respuesta` VALUES ('529', 'Tecnología en desarrollo de software ', '97', '1', null);
INSERT INTO `respuesta` VALUES ('530', 'Contabilidad ', '97', '0', null);
INSERT INTO `respuesta` VALUES ('531', 'Tecnología en desarrollo de software ', '98', '0', null);
INSERT INTO `respuesta` VALUES ('532', 'Maestría en administración  ', '98', '0', null);
INSERT INTO `respuesta` VALUES ('533', 'Administración financiera ', '98', '1', null);
INSERT INTO `respuesta` VALUES ('534', 'Contabilidad ', '98', '0', null);
INSERT INTO `respuesta` VALUES ('535', 'Sala de cómputo 4 (Bloque 7) ', '99', '0', null);
INSERT INTO `respuesta` VALUES ('536', 'Sala de cómputo 1 (Bloque 7) ', '99', '1', null);
INSERT INTO `respuesta` VALUES ('537', 'Sala de cómputo 6 (Bloque 7) ', '99', '0', null);
INSERT INTO `respuesta` VALUES ('538', 'Sala de cómputo 5 (Bloque 7) ', '99', '0', null);
INSERT INTO `respuesta` VALUES ('539', 'Sala Chairá  (Auditorio) ', '100', '0', null);
INSERT INTO `respuesta` VALUES ('540', 'Sala de cómputo 8 (Bloque 7) ', '100', '0', null);
INSERT INTO `respuesta` VALUES ('541', 'Sala de cómputo 2 (Bloque 7) ', '100', '1', null);
INSERT INTO `respuesta` VALUES ('542', 'Sala Caquetá (Bloque 3) ', '100', '0', null);
INSERT INTO `respuesta` VALUES ('543', 'Sala de cómputo 3 (Bloque 7) ', '101', '1', null);
INSERT INTO `respuesta` VALUES ('544', 'Sala de cómputo 4 (Bloque 7) ', '101', '0', null);
INSERT INTO `respuesta` VALUES ('545', 'Sala de cómputo 5 (Bloque 7) ', '101', '0', null);
INSERT INTO `respuesta` VALUES ('546', 'Sala Chairá  (Auditorio) ', '101', '0', null);
INSERT INTO `respuesta` VALUES ('547', 'Sala Chairá  (Auditorio) ', '102', '0', null);
INSERT INTO `respuesta` VALUES ('548', 'Sala de cómputo 4 (Bloque 7) ', '102', '1', null);
INSERT INTO `respuesta` VALUES ('549', 'Sala de cómputo 7 (Bloque 7) ', '102', '0', null);
INSERT INTO `respuesta` VALUES ('550', 'Sala de cómputo 5 (Bloque 7) ', '102', '0', null);
INSERT INTO `respuesta` VALUES ('551', 'Sala de cómputo 5 (Bloque 7) ', '103', '1', null);
INSERT INTO `respuesta` VALUES ('552', 'Sala de cómputo 3 (Bloque 7) ', '103', '0', null);
INSERT INTO `respuesta` VALUES ('553', 'Sala de cómputo 6 (Bloque 7) ', '103', '0', null);
INSERT INTO `respuesta` VALUES ('554', 'Sala Amazonas (Bloque 2, Segundo piso) ', '103', '0', null);
INSERT INTO `respuesta` VALUES ('555', 'Sala de cómputo 6 (Bloque 7) ', '104', '1', null);
INSERT INTO `respuesta` VALUES ('556', 'Sala Caquetá (Bloque 3) ', '104', '0', null);
INSERT INTO `respuesta` VALUES ('557', 'Sala Chairá  (Auditorio) ', '104', '0', null);
INSERT INTO `respuesta` VALUES ('558', 'Sala de cómputo 4 (Bloque 7) ', '104', '0', null);
INSERT INTO `respuesta` VALUES ('559', 'Sala de cómputo 7 (Bloque 7) ', '105', '1', null);
INSERT INTO `respuesta` VALUES ('560', 'Sala Caquetá (Bloque 3) ', '105', '0', null);
INSERT INTO `respuesta` VALUES ('561', 'Sala Amazonas (Bloque 2, Segundo piso) ', '105', '0', null);
INSERT INTO `respuesta` VALUES ('562', 'Sala de cómputo 8 (Bloque 7) ', '105', '0', null);
INSERT INTO `respuesta` VALUES ('563', '', '106', '0', '129');
INSERT INTO `respuesta` VALUES ('564', '', '106', '0', '131');
INSERT INTO `respuesta` VALUES ('565', '', '106', '1', '134');
INSERT INTO `respuesta` VALUES ('566', '', '106', '0', '132');
INSERT INTO `respuesta` VALUES ('567', '', '107', '1', '135');
INSERT INTO `respuesta` VALUES ('568', '', '107', '0', '133');
INSERT INTO `respuesta` VALUES ('569', '', '107', '0', '137');
INSERT INTO `respuesta` VALUES ('570', '', '107', '0', '139');
INSERT INTO `respuesta` VALUES ('571', 'Sala Amazonas (Bloque 2, Segundo piso) ', '108', '1', null);
INSERT INTO `respuesta` VALUES ('572', 'Sala de cómputo 2 (Bloque 7) ', '108', '0', null);
INSERT INTO `respuesta` VALUES ('573', 'Sala Putumayo (Bloque 2) ', '108', '0', null);
INSERT INTO `respuesta` VALUES ('574', 'Sala Caquetá (Bloque 3) ', '108', '0', null);
INSERT INTO `respuesta` VALUES ('575', '', '109', '1', '137');
INSERT INTO `respuesta` VALUES ('576', '', '109', '0', '136');
INSERT INTO `respuesta` VALUES ('577', '', '109', '0', '133');
INSERT INTO `respuesta` VALUES ('578', '', '109', '0', '128');
INSERT INTO `respuesta` VALUES ('579', '', '110', '0', '128');
INSERT INTO `respuesta` VALUES ('580', '', '110', '1', '138');
INSERT INTO `respuesta` VALUES ('581', '', '110', '0', '133');
INSERT INTO `respuesta` VALUES ('582', '', '110', '0', '136');
INSERT INTO `respuesta` VALUES ('583', '', '111', '1', '139');
INSERT INTO `respuesta` VALUES ('584', '', '111', '0', '138');
INSERT INTO `respuesta` VALUES ('585', '', '111', '0', '136');
INSERT INTO `respuesta` VALUES ('586', '', '111', '0', '127');
INSERT INTO `respuesta` VALUES ('587', '', '112', '1', '140');
INSERT INTO `respuesta` VALUES ('588', '', '112', '0', '132');
INSERT INTO `respuesta` VALUES ('589', '', '112', '0', '133');
INSERT INTO `respuesta` VALUES ('590', '', '112', '0', '139');

-- ----------------------------
-- Table structure for respuesta_temario
-- ----------------------------
DROP TABLE IF EXISTS `respuesta_temario`;
CREATE TABLE `respuesta_temario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_curso_usuario` int(20) NOT NULL,
  `fk_temario` int(20) NOT NULL,
  `resultado` int(20) DEFAULT NULL COMMENT 'porcentaje',
  PRIMARY KEY (`id`),
  KEY `fk_res_temario_temario` (`fk_temario`),
  KEY `fk_res_temario_curso` (`fk_curso_usuario`),
  CONSTRAINT `fk_res_temario_curso` FOREIGN KEY (`fk_curso_usuario`) REFERENCES `curso_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_res_temario_temario` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuesta_temario
-- ----------------------------
INSERT INTO `respuesta_temario` VALUES ('1', '2', '1', '10');

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES ('1', 'Estudiante');
INSERT INTO `rol` VALUES ('2', 'Administrador');

-- ----------------------------
-- Table structure for temario
-- ----------------------------
DROP TABLE IF EXISTS `temario`;
CREATE TABLE `temario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `fk_curso` int(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_temario_curso` (`fk_curso`),
  CONSTRAINT `fk_temario_curso` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temario
-- ----------------------------
INSERT INTO `temario` VALUES ('1', 'Abecedario', '1', 'Abecedario en el lenguaje de Señas Colombiano', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/ABC.gif');
INSERT INTO `temario` VALUES ('2', 'Números', '1', 'Números en el lenguaje de Señas Colombiano', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/Numeros.png');
INSERT INTO `temario` VALUES ('3', 'Salas', '1', 'Salas de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/Salas.png');
INSERT INTO `temario` VALUES ('4', 'Laboratorios', '1', 'Laboratorios de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/Laborarotios.gif');
INSERT INTO `temario` VALUES ('5', 'Biblioteca', '1', 'Secciones de la Biblioteca de la U.Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/Biblioteca.png');
INSERT INTO `temario` VALUES ('6', 'Cafeterias', '1', 'Cafeterías de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Cafeteria/cafeteria.png');
INSERT INTO `temario` VALUES ('7', 'Oficinas', '1', 'Oficinas de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Oficinas/oficinas.png');

-- ----------------------------
-- Table structure for temario_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `temario_multimedia`;
CREATE TABLE `temario_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_temario` int(11) NOT NULL,
  `fk_multimedia` int(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_temario_multimedia` (`fk_temario`),
  KEY `fk_multimedia_temario` (`fk_multimedia`),
  CONSTRAINT `fk_multimedia_temario` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_temario_multimedia` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temario_multimedia
-- ----------------------------
INSERT INTO `temario_multimedia` VALUES ('1', '1', '28', 'Letra del Abecedario', 'A');
INSERT INTO `temario_multimedia` VALUES ('2', '1', '29', 'Letra del Abecedario', 'B');
INSERT INTO `temario_multimedia` VALUES ('3', '1', '30', 'Letra del Abecedario', 'C');
INSERT INTO `temario_multimedia` VALUES ('4', '1', '31', 'Letra del Abecedario', 'D');
INSERT INTO `temario_multimedia` VALUES ('5', '1', '32', 'Letra del Abecedario', 'E');
INSERT INTO `temario_multimedia` VALUES ('6', '1', '33', 'Letra del Abecedario', 'F');
INSERT INTO `temario_multimedia` VALUES ('7', '1', '34', 'Letra del Abecedario', 'G');
INSERT INTO `temario_multimedia` VALUES ('8', '1', '35', 'Letra del Abecedario', 'H');
INSERT INTO `temario_multimedia` VALUES ('9', '1', '36', 'Letra del Abecedario', 'I');
INSERT INTO `temario_multimedia` VALUES ('10', '1', '37', 'Letra del Abecedario', 'J');
INSERT INTO `temario_multimedia` VALUES ('11', '1', '38', 'Letra del Abecedario', 'K');
INSERT INTO `temario_multimedia` VALUES ('12', '1', '39', 'Letra del Abecedario', 'L');
INSERT INTO `temario_multimedia` VALUES ('13', '1', '40', 'Letra del Abecedario', 'M');
INSERT INTO `temario_multimedia` VALUES ('14', '1', '41', 'Letra del Abecedario', 'N');
INSERT INTO `temario_multimedia` VALUES ('15', '1', '42', 'Letra del Abecedario', 'Ñ');
INSERT INTO `temario_multimedia` VALUES ('16', '1', '43', 'Letra del Abecedario', 'O');
INSERT INTO `temario_multimedia` VALUES ('17', '1', '44', 'Letra del Abecedario', 'P');
INSERT INTO `temario_multimedia` VALUES ('18', '1', '45', 'Letra del Abecedario', 'Q');
INSERT INTO `temario_multimedia` VALUES ('19', '1', '46', 'Letra del Abecedario', 'R');
INSERT INTO `temario_multimedia` VALUES ('20', '1', '47', 'Letra del Abecedario', 'S');
INSERT INTO `temario_multimedia` VALUES ('21', '1', '48', 'Letra del Abecedario', 'T');
INSERT INTO `temario_multimedia` VALUES ('22', '1', '49', 'Letra del Abecedario', 'U');
INSERT INTO `temario_multimedia` VALUES ('23', '1', '50', 'Letra del Abecedario', 'V');
INSERT INTO `temario_multimedia` VALUES ('24', '1', '51', 'Letra del Abecedario', 'W');
INSERT INTO `temario_multimedia` VALUES ('25', '1', '52', 'Letra del Abecedario', 'X');
INSERT INTO `temario_multimedia` VALUES ('26', '1', '53', 'Letra del Abecedario', 'Y');
INSERT INTO `temario_multimedia` VALUES ('27', '1', '54', 'Letra del Abecedario', 'Z');
INSERT INTO `temario_multimedia` VALUES ('28', '2', '55', 'Número', '1');
INSERT INTO `temario_multimedia` VALUES ('29', '2', '56', 'Número', '2');
INSERT INTO `temario_multimedia` VALUES ('30', '2', '57', 'Número', '3');
INSERT INTO `temario_multimedia` VALUES ('31', '2', '58', 'Número', '4');
INSERT INTO `temario_multimedia` VALUES ('32', '2', '59', 'Número', '5');
INSERT INTO `temario_multimedia` VALUES ('33', '2', '60', 'Número', '6');
INSERT INTO `temario_multimedia` VALUES ('34', '2', '61', 'Número', '7');
INSERT INTO `temario_multimedia` VALUES ('35', '2', '62', 'Número', '8');
INSERT INTO `temario_multimedia` VALUES ('36', '2', '63', 'Número', '9');
INSERT INTO `temario_multimedia` VALUES ('37', '2', '64', 'Número', '10');
INSERT INTO `temario_multimedia` VALUES ('38', '2', '65', 'Número', '11');
INSERT INTO `temario_multimedia` VALUES ('39', '2', '66', 'Número', '12');
INSERT INTO `temario_multimedia` VALUES ('40', '2', '67', 'Número', '13');
INSERT INTO `temario_multimedia` VALUES ('41', '2', '68', 'Número', '14');
INSERT INTO `temario_multimedia` VALUES ('42', '2', '69', 'Número', '15');
INSERT INTO `temario_multimedia` VALUES ('43', '2', '70', 'Número', '16');
INSERT INTO `temario_multimedia` VALUES ('44', '2', '71', 'Número', '17');
INSERT INTO `temario_multimedia` VALUES ('45', '2', '72', 'Número', '18');
INSERT INTO `temario_multimedia` VALUES ('46', '2', '73', 'Número', '19');
INSERT INTO `temario_multimedia` VALUES ('47', '2', '74', 'Número', '20');
INSERT INTO `temario_multimedia` VALUES ('48', '2', '75', 'Número', '30');
INSERT INTO `temario_multimedia` VALUES ('49', '2', '76', 'Número', '40');
INSERT INTO `temario_multimedia` VALUES ('50', '2', '77', 'Número', '50');
INSERT INTO `temario_multimedia` VALUES ('51', '2', '78', 'Número', '60');
INSERT INTO `temario_multimedia` VALUES ('52', '2', '79', 'Número', '70');
INSERT INTO `temario_multimedia` VALUES ('53', '2', '80', 'Número', '80');
INSERT INTO `temario_multimedia` VALUES ('54', '2', '81', 'Número', '90');
INSERT INTO `temario_multimedia` VALUES ('55', '2', '82', 'Número', '100');
INSERT INTO `temario_multimedia` VALUES ('56', '4', '83', 'Bloque 7', 'Laboratorio de Matemáticas');
INSERT INTO `temario_multimedia` VALUES ('57', '4', '84', 'Bloque 7', 'Laboratorio de Control Biológico');
INSERT INTO `temario_multimedia` VALUES ('58', '4', '85', 'Bloque 6', 'Laboratorio de Física ');
INSERT INTO `temario_multimedia` VALUES ('59', '4', '86', 'Bloque 4', 'Laboratorio de Inglés');
INSERT INTO `temario_multimedia` VALUES ('60', '4', '87', 'Bloque 5', 'Laboratorios de Biología y Química');
INSERT INTO `temario_multimedia` VALUES ('61', '5', '88', 'Sección de la Biblioteca', 'Primer piso');
INSERT INTO `temario_multimedia` VALUES ('62', '5', '89', 'Sección de la Biblioteca', 'Segundo piso');
INSERT INTO `temario_multimedia` VALUES ('63', '5', '90', 'Sección de la Biblioteca', 'Tercer piso');
INSERT INTO `temario_multimedia` VALUES ('64', '5', '91', 'Sección de la Biblioteca', 'Naranja ');
INSERT INTO `temario_multimedia` VALUES ('65', '5', '92', 'Sección de la Biblioteca', 'Azul');
INSERT INTO `temario_multimedia` VALUES ('66', '5', '93', 'Sección de la Biblioteca', 'Verde');
INSERT INTO `temario_multimedia` VALUES ('67', '5', '94', 'Sección de la Biblioteca', 'Roja');
INSERT INTO `temario_multimedia` VALUES ('69', '5', '96', 'Sección de la Biblioteca', 'Sala Virtual');
INSERT INTO `temario_multimedia` VALUES ('70', '6', '97', 'Cafetería', 'El Ché');
INSERT INTO `temario_multimedia` VALUES ('71', '6', '98', 'Cafetería', 'Tertulia');
INSERT INTO `temario_multimedia` VALUES ('72', '6', '99', 'Cafetería', 'Flor y café');
INSERT INTO `temario_multimedia` VALUES ('73', '7', '100', 'Oficina Bloque Administrativo piso 1', 'Contaduría publica');
INSERT INTO `temario_multimedia` VALUES ('74', '7', '101', 'Oficina Bloque Administrativo piso 1', 'Departamento de pedagogía');
INSERT INTO `temario_multimedia` VALUES ('75', '7', '102', 'Oficina Bloque Administrativo piso 1', 'Administración de empresas');
INSERT INTO `temario_multimedia` VALUES ('76', '7', '103', 'Oficina Bloque Administrativo piso 1', 'Cafetería');
INSERT INTO `temario_multimedia` VALUES ('77', '7', '104', 'Oficina Bloque Administrativo piso 1', 'Derecho');
INSERT INTO `temario_multimedia` VALUES ('78', '7', '105', 'Oficina Bloque Administrativo piso 1', 'Tesorería');
INSERT INTO `temario_multimedia` VALUES ('79', '7', '106', 'Oficina Bloque Administrativo piso 2', 'Oficina asesora de planeación ');
INSERT INTO `temario_multimedia` VALUES ('80', '7', '107', 'Oficina Bloque Administrativo piso 2', 'Sala de juntas');
INSERT INTO `temario_multimedia` VALUES ('81', '7', '108', 'Oficina Bloque Administrativo piso 2', 'Vicerrectoría administrativa');
INSERT INTO `temario_multimedia` VALUES ('82', '7', '109', 'Oficina Bloque Administrativo piso 2', 'Vicerrectoría de investigaciones y posgrados');
INSERT INTO `temario_multimedia` VALUES ('83', '7', '110', 'Oficina Bloque Administrativo piso 2', 'Rectoría');
INSERT INTO `temario_multimedia` VALUES ('84', '7', '111', 'Oficina Bloque Administrativo piso 2', 'Oficina asesora de relaciones internacionales');
INSERT INTO `temario_multimedia` VALUES ('85', '7', '112', 'Oficina Bloque Administrativo piso 2', 'Oficina de graduados');
INSERT INTO `temario_multimedia` VALUES ('86', '7', '113', 'Oficina Bloque Administrativo piso 2', 'Vicerrectoría académica');
INSERT INTO `temario_multimedia` VALUES ('87', '7', '114', 'Oficina Bloque Administrativo piso 2', 'Coordinación seguridad y salud en el trabajo');
INSERT INTO `temario_multimedia` VALUES ('88', '7', '115', 'Oficina Bloque Administrativo piso 2', 'Oficina asesora de control interno ');
INSERT INTO `temario_multimedia` VALUES ('89', '7', '116', 'Oficina Bloque Administrativo piso 2', 'Contabilidad');
INSERT INTO `temario_multimedia` VALUES ('90', '7', '117', 'Oficina Bloque Administrativo piso 2', 'Almacén');
INSERT INTO `temario_multimedia` VALUES ('91', '7', '118', 'Oficina DTI', 'Cuarto de comunicaciones ');
INSERT INTO `temario_multimedia` VALUES ('92', '7', '119', 'Oficina DTI', 'Maestría en administración ');
INSERT INTO `temario_multimedia` VALUES ('93', '7', '120', 'Oficina DTI', 'Coordinación de posgrados');
INSERT INTO `temario_multimedia` VALUES ('94', '7', '121', 'Oficina DTI', 'Coordinación de aplicaciones  ');
INSERT INTO `temario_multimedia` VALUES ('95', '7', '122', 'Oficina DTI', 'Coordinación de investigación y desarrollo');
INSERT INTO `temario_multimedia` VALUES ('96', '7', '123', 'Oficina DTI', 'Dirección de departamento se tecnología de la información y la comunicación');
INSERT INTO `temario_multimedia` VALUES ('97', '7', '124', 'Oficina DTI', 'Tecnología en salud ocupacional');
INSERT INTO `temario_multimedia` VALUES ('98', '7', '125', 'Oficina DTI', 'Tecnología en desarrollo de software');
INSERT INTO `temario_multimedia` VALUES ('99', '7', '126', 'Oficina DTI', 'Administración financiera');
INSERT INTO `temario_multimedia` VALUES ('100', '3', '127', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 1');
INSERT INTO `temario_multimedia` VALUES ('101', '3', '128', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 2');
INSERT INTO `temario_multimedia` VALUES ('102', '3', '129', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 3');
INSERT INTO `temario_multimedia` VALUES ('103', '3', '130', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 4');
INSERT INTO `temario_multimedia` VALUES ('104', '3', '131', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 5');
INSERT INTO `temario_multimedia` VALUES ('105', '3', '132', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 6');
INSERT INTO `temario_multimedia` VALUES ('106', '3', '133', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 7');
INSERT INTO `temario_multimedia` VALUES ('107', '3', '134', 'Sala de Sistemas Bloque 7', 'Sala de cómputo 8');
INSERT INTO `temario_multimedia` VALUES ('108', '3', '135', 'Sala de Conferencias Bloque 2', 'Sala Putumayo');
INSERT INTO `temario_multimedia` VALUES ('109', '3', '136', 'Sala de Conferencias Bloque 2, 2do Piso', 'Sala Amazonas ');
INSERT INTO `temario_multimedia` VALUES ('110', '3', '137', 'Sala de Conferencias Bloque 3', 'Sala Caquetá');
INSERT INTO `temario_multimedia` VALUES ('111', '3', '138', 'Sala de Conferencias ', 'Sala Virtual Biblioteca');
INSERT INTO `temario_multimedia` VALUES ('112', '3', '139', 'Sala de Conferencias Auditorio', 'Sala Chairá   ');
INSERT INTO `temario_multimedia` VALUES ('113', '3', '140', 'Sala de Conferencias', 'Sala Docentes');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` int(5) NOT NULL DEFAULT '1' COMMENT '0 = inactivo, 1 = activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('2', 'Yeison', 'Gomez Rodriguez', 'yeisom40@gmail.com', 'https://avatars3.githubusercontent.com/u/14795272?s=460&v=4', '1');
INSERT INTO `usuario` VALUES ('3', 'LAURA MARCELA OSORIO SILVA', '', 'la.osorio@udla.edu.co', 'https://chaira.udla.edu.co/Chaira/view/public/Fotos/fotos.aspx?estudiante=1006408', '1');
INSERT INTO `usuario` VALUES ('4', 'LUIS ANDRES VELA TOVAR', '', 'lu.vela@udla.edu.co', 'https://chaira.udla.edu.co/Chaira/view/public/Fotos/fotos.aspx?estudiante=1009382', '1');
INSERT INTO `usuario` VALUES ('5', 'Yeison', 'Gomez Rodriguez', 'yei.gomez@udla.edu.co', 'https://avatars3.githubusercontent.com/u/14795272?s=460&v=4', '1');

-- ----------------------------
-- Table structure for usuario_rol
-- ----------------------------
DROP TABLE IF EXISTS `usuario_rol`;
CREATE TABLE `usuario_rol` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_usuario` int(20) NOT NULL,
  `fk_rol` int(20) NOT NULL,
  `tipo` int(5) NOT NULL DEFAULT '0' COMMENT '0 = natural, 1 = juridica',
  PRIMARY KEY (`id`),
  KEY `fk_usuario_rol` (`fk_usuario`),
  KEY `fk_rol_usuario` (`fk_rol`),
  CONSTRAINT `fk_rol_usuario` FOREIGN KEY (`fk_rol`) REFERENCES `rol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario_rol
-- ----------------------------
INSERT INTO `usuario_rol` VALUES ('2', '2', '1', '0');
INSERT INTO `usuario_rol` VALUES ('3', '3', '1', '0');
INSERT INTO `usuario_rol` VALUES ('4', '4', '1', '0');
INSERT INTO `usuario_rol` VALUES ('5', '5', '1', '0');

-- ----------------------------
-- Procedure structure for CALIFICATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `CALIFICATE`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CALIFICATE`(email varchar(50), temary_id varchar(50), resultado varchar(50))
BEGIN

  declare v_curso_usuario integer;
	declare v_exist_response integer;
	
	select 
	cu.id 
	into v_curso_usuario 
	from usuario u 
	inner join curso_usuario cu on cu.fk_usuario = u.id
	where u.correo = email;
	
	select id into v_exist_response from respuesta_temario where fk_curso_usuario = v_curso_usuario and fk_temario = temary_id;
	
	if v_exist_response is not null then
		update respuesta_temario
		set
		resultado = resultado
		where id = v_exist_response;
	else
		insert into respuesta_temario
		(fk_curso_usuario, fk_temario, resultado)
		values
		(v_curso_usuario, temary_id, resultado);
	end if;
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for CALIFICATE_FINISH
-- ----------------------------
DROP PROCEDURE IF EXISTS `CALIFICATE_FINISH`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CALIFICATE_FINISH`(email varchar(50), evaluate_id varchar(50), resultado varchar(50))
BEGIN
  declare v_user_id integer;
	declare v_exist_response integer;
	
	select 
	u.id 
	into v_user_id 
	from usuario u
	where u.correo = email;
	
	select id into v_exist_response from evaluacion_usuario where fk_usuario = v_user_id and fk_evaluacion = evaluate_id;
	
	if v_exist_response is not null then
		update evaluacion_usuario
		set
		nota = resultado
		where id = v_exist_response;
	else
		insert into evaluacion_usuario
		(fk_usuario, fk_evaluacion, nota)
		values
		(v_user_id, evaluate_id, resultado);
	end if;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for LOGIN_USER
-- ----------------------------
DROP PROCEDURE IF EXISTS `LOGIN_USER`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_USER`(p_nombres varchar(80), p_apellidos varchar(80), p_correo varchar(80), p_foto varchar(255))
BEGIN
	
  declare v_user_id integer;
	declare _id integer;
	declare _rol_estudiante integer;
	
	set _rol_estudiante = 1;
	
	select u.id 
	into v_user_id 
	from usuario u where u.correo = p_correo;
	
	if v_user_id is null then
		#Registrar usuario
		insert into usuario
		(nombres, apellidos, correo, foto)
		values
		(p_nombres, p_apellidos, p_correo, p_foto);
		
		set _id = LAST_INSERT_ID();
		
		insert into usuario_rol
		(fk_usuario, fk_rol)
		values
		(_id, _rol_estudiante);
		
		insert into curso_usuario
		(fk_curso, fk_usuario)
		values
		(1, _id);
	end if;

END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
