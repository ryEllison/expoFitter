// Modules to control application life and create native browser window
const { app, BrowserWindow } = require('electron');
const path = require('path');
const child = require('child_process');
const port = '9191';
const WINDOWS = 'win32';

// Default app path and executable path
let appPath = path.join(app.getAppPath(), 'app.R');
let execPath = 'RScript';

// Adjust paths for Windows
if (process.platform === WINDOWS) {
  appPath = appPath.replace(/\\/g, '\\\\');
  execPath = path.join(app.getAppPath(), 'r_portable_win', 'bin', 'RScript.exe');
} else {
  console.log('This application is only configured for Windows.');
  throw new Error('This application is only configured for Windows.');
}

// Spawn child process to run the Shiny app
const childProcess = child.spawn(execPath, ['-e', `shiny::runApp(file.path('${appPath}'), port=${port})`]);

// Log output and errors from the child process
childProcess.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

childProcess.stderr.on('data', (data) => {
  console.log(`stderr: ${data}`);
});

// Keep a global reference of the window object
let mainWindow;

function createWindow() {
  console.log('Creating main window');
  
  // Loading screen window
  let loading = new BrowserWindow({ show: false, frame: false });
  loading.loadURL('data:text/html;charset=utf-8;base64,PGh0bWw+DQo8c3R5bGU+DQpib2R5ew0KICBwYWRkaW5nOiAxZW07DQogIGNvbG9yOiAjNzc3Ow0KICB0ZXh0LWFsaWduOiBjZW50ZXI7DQogIGZvbnQtZmFtaWx5OiAiR2lsbCBzYW5zIiwgc2Fucy1zZXJpZjsNCiAgd2lkdGg6IDgwJTsNCiAgbWFyZ2luOiAwIGF1dG87DQp9DQpoMXsNCiAgbWFyZ2luOiAxZW0gMDsNCiAgYm9yZGVyLWJvdHRvbTogMXB4IGRhc2hlZDsNCiAgcGFkZGluZy1ib3R0b206IDFlbTsNCiAgZm9udC13ZWlnaHQ6IGxpZ2h0ZXI7DQp9DQpwew0KICBmb250LXN0eWxlOiBpdGFsaWM7DQp9DQoubG9hZGVyew0KICBtYXJnaW46IDAgMCAyZW07DQogIGhlaWdodDogMTAwcHg7DQogIHdpZHRoOiAyMCU7DQogIHRleHQtYWxpZ246IGNlbnRlcjsNCiAgcGFkZGluZzogMWVtOw0KICBtYXJnaW46IDAgYXV0byAxZW07DQogIGRpc3BsYXk6IGlubGluZS1ibG9jazsNCiAgdmVydGljYWwtYWxpZ246IHRvcDsNCn0NCg==');

  loading.once('show', () => {
    console.log('Loading screen displayed');
    mainWindow = new BrowserWindow({ webPreferences: { nodeIntegration: false }, show: false, width: 800, height: 600 });

    mainWindow.webContents.once('dom-ready', () => {
      console.log('Main window DOM ready');
      setTimeout(() => {
        mainWindow.show();
        loading.hide();
        loading.close();
      }, 2000);
    });

    mainWindow.loadURL(`http://127.0.0.1:${port}`);

    mainWindow.on('closed', () => {
      console.log('Main window closed');
      cleanUpApplication();
    });
  });

  loading.show();
}

// Clean up child processes and quit the app
function cleanUpApplication() {
  app.quit();
  if (childProcess) {
    childProcess.kill();
  }
}

// Event handler when Electron is ready to create windows
app.on('ready', createWindow);

// Quit the app when all windows are closed
app.on('window-all-closed', function () {
  cleanUpApplication();
});

// Re-create window if the app is re-activated (for macOS behavior, though not needed here)
app.on('activate', function () {
  if (mainWindow === null) createWindow();
});
