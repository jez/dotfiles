
import * as React from "/Applications/Oni.app/Contents/Resources/app/node_modules/react"
import * as Oni from "/Applications/Oni.app/Contents/Resources/app/node_modules/oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
  //add custom config here, such as
  'oni.useDefaultConfig': false,

  'ui.colorscheme': 'solarzied',

  'ui.animations.enabled': false,
  'ui.fontSmoothing': 'auto',
  'sidebar.enabled': false,
  'statusbar.enabled': false,
  'commandline.mode': false,
  'editor.fontFamily': 'Menlo for Powerline',
  'editor.fontSize': '14px',
  'editor.fontLigatures': false,
  'editor.fullScreenOnStart': true,
  'tabs.mode': 'native',
}
