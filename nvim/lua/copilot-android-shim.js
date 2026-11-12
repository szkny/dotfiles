const Module = require("node:module");

const originalLoad = Module._load;
// Android has no bundled native watcher; open-buffer changes still arrive over LSP.
const watcher = {
  writeSnapshot: async () => "",
  getEventsSince: async () => [],
  subscribe: async () => {},
  unsubscribe: async () => {},
};

Module._load = function (request, parent, isMain) {
  if (
    process.platform === "android" &&
    typeof request === "string" &&
    /[\\/]compiled[\\/]android[\\/]arm64[\\/]watcher\.node$/.test(request)
  ) {
    return watcher;
  }

  return originalLoad.call(this, request, parent, isMain);
};
