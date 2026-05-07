;;; keepachangelog.el --- Simplifies keeping a CHANGELOG.md  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Tamas K Papp

;; Author: Tamas Papp <tkpapp@gmail.com>
;; Keywords: convenience
;; Version: 0.1.2
;; Package-Requires: ((emacs "29.1"))
;; URL: https://github.com/tpapp/keepachangelog
;;
;;; License:
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Commentary:
;; Simple templates to keep a changelog.

;;; Code:

(defun changelog-open ()
  "Find a `CHANGELOG.md' file in one of the parent directories, starting with the directory of the current file."
  (interactive)
  (let* ((this-fn (or (buffer-file-name) default-directory))
         (changelog-fn "CHANGELOG.md")
         (changelog-dir (locate-dominating-file this-fn changelog-fn)))
    (if changelog-dir
        (find-file (concat changelog-dir changelog-fn))
      (error "Could not find a %s in the parent directories of %s" changelog-fn this-fn))))

(defun changelog-insert-header ()
  "Insert a header for a changelog at the beginning of the buffer.

Follows the guidelines at URL `https://keepachangelog.com/en/1.1.0/'."
  (interactive)
  (goto-char (point-min))
  (insert "# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
"))

(defun changelog-insert-unreleased ()
  "Insert a template for an `[Unreleased]' sub-heading at the point, with all relevant sub-sub headings.

Follows the guidelines at URL `https://keepachangelog.com/en/1.1.0/'."
  (interactive)
  (save-excursion
    (insert "
## Unreleased

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
")))

(defun changelog--setup-keys ()
  (let ((buffer-fn (buffer-file-name)))
    (when (and buffer-fn (string= (file-name-nondirectory buffer-fn) "CHANGELOG.md"))
      (keymap-local-set "C-c C-e C-a" (lambda ()
                                        (interactive)
                                        (changelog-insert-header)
                                        (changelog-insert-unreleased)))
      (keymap-local-set "C-c C-e C-u" 'changelog-insert-unreleased))))

(keymap-global-set "C-c C-l C-o" 'changelog-open)

(add-hook 'find-file-hook 'changelog--setup-keys)

(provide 'keepachangelog)
