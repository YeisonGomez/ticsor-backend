import 'dotenv/config'

export const CONFIG = {
    PORT: Number(process.env.PORT) || 3310,
    JWT_SECRET: process.env.JWT_SECRET,
    DB: {
    	connectionLimit : 20,
		host: process.env.DBHOST || "localhost",
		port : process.env.DBPORT || 3306,
		user: process.env.DBUSER || "root",
		password: process.env.DBPASSWORD || "persian13",
		database : process.env.DBNAME || "hangers_chess"
	},
	//CODE_PRIVATE: "hangers_chess_hulk_cool_123_code_123_@34123123213756435324555&"
	CODE_PRIVATE: "321"
}
