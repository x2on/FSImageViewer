#!/bin/sh

/usr/local/bin/appledoc \
--project-name FSImageViewer \
--project-company "Felix Schulze" \
--company-id de.felixschulze \
--output ./documentation \
--no-create-docset \
--no-repeat-first-par \
--logformat xcode \
--warn-empty-description \
--warn-undocumented-object \
--no-warn-undocumented-member \
--keep-undocumented-members \
--keep-undocumented-objects \
--ignore "*.m" \
--ignore "LoadableCategory.h" \
--verbose 4 \
FSImageViewer/