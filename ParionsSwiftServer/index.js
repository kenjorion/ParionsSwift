import { createServer } from "http";
import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import SocketIO from "./socketio";
// Firebase
import {FirebaseAuth} from "./config";

// Routes

const app = express();
const server = createServer(app);
const PORT = process.env.PORT || 8080;

// Database
const db = FirebaseAuth.firestore();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set("db", db);

if (process.env.NODE_ENV === "production") {
	app.use(express.static("client/build"));
	app.get("*", (req, res) => {
		res.sendFile(path.resolve(__dirname, "client", "build", "index.html"));
	});
}

server.listen(PORT, err => {
	if (err) throw err;
	SocketIO.start(server);
	console.log(`Server started and listening the port ${PORT} !`);
});