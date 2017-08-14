import 'dotenv/config'

export const CONFIG = {
    PORT: Number(process.env.PORT) || 3300,
    JWT_SECRET: process.env.JWT_SECRET,
    DB: {
		host: process.env.DBHOST || "localhost",
		port : process.env.DBPORT || 3306,
		user: process.env.DBUSER || "root",
		password: process.env.DBPASSWORD || "root",
		database : process.env.DBNAME || "mydb"
	}
}
