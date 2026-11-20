# Tango icons

Icons from the [Tango Desktop Project](http://tango.freedesktop.org/), which are
in the public domain. Use the freedesktop icon names, for example
`tango_icon "document-save"` or `tango_icon "folder", size: 22`.

- `16x16/` for inline text, lists and table rows.
- `22x22/` for toolbars, headings and the BBCode editor buttons.

Only a subset of the set is vendored: icons a forge is unlikely to need (weather,
printers, batteries, desktop preferences, office documents and so on) were left out.
If you need one that is missing, copy it in from the Tango release at both sizes.
Put it straight in the size folder (`16x16/folder.png`), not in a category folder
like `places/`, because `tango_icon` only looks one level down.
PNGs here go through Git LFS (see `.gitattributes`).
