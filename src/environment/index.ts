import 'dotenv/config'

export const CONFIG = {
    PORT: Number(process.env.PORT) || 3312,
    JWT_SECRET: process.env.JWT_SECRET,
    DB: {
    	connectionLimit : 20,
		host: process.env.DBHOST || "191.102.85.226",
		port : process.env.DBPORT || 3306,
		user: process.env.DBUSER || "root",
		password: process.env.DBPASSWORD || "agc.UDLA_2*",
		database : process.env.DBNAME || "pbd_ticsor",
		mongodb: 'mongodb+srv://ticsor:ticsor@cluster0-uhvhk.mongodb.net/test?retryWrites=true'
	}
}
