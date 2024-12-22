import express from 'npm:express';
import path from 'npm:path';
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const port = 8080;

// Serve static files from the 'dev' directory
app.use(express.static(path.join(__dirname, 'dev')));
app.use(express.static(path.join(__dirname, 'assets')));

app.get('/', (_req: any, res: { sendFile: (arg0: any) => void; }) => {
  res.sendFile(path.join(__dirname, 'dev', 'htmlView.html'));
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});