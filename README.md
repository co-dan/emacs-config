My simple emacs configuration.

Requires:

- MELPA
- [Better defaults](https://github.com/technomancy/better-defaults)
- [Alect themes](https://github.com/alezost/alect-themes)
- Packages for specific tasks: like RefTeX, AuCTeX, markdown-mode, magit,
  haskell-mode, ProofGeneral
  
Here is how it looks (I haven't tweaked the colors yet)

![](https://files.app.net/vmz2wG7Q.png)

*Usually I don't open Magit, markdown and org files at the same time,
 that's just for showing off*

Package installation:

```elisp
(package-install 'markdown-mode)
(package-install 'ido-vertical-mode)
(package-install 'ido-ubiquitous)
(package-install 'smex)
(package-install 'window-number)
(package-install 'auctex)
(package-install 'flycheck)
```
