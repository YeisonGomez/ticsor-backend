import 'dotenv/config'

export const CONFIG = {
    PORT: Number(process.env.PORT) || 3310,
    JWT_SECRET: process.env.JWT_SECRET,
    DB: {
    	connectionLimit : 20,
		host: process.env.DBHOST || "191.102.85.226",
		port : process.env.DBPORT || 3306,
		user: process.env.DBUSER || "user_ticsor",
		password: process.env.DBPASSWORD || "Usr.2017_UAtic*",
		database : process.env.DBNAME || "bd_ticsor"
	},
}
