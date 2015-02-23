Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33153 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbBWWkW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 Feb 2015 17:40:22 -0500
Received: by pdjz10 with SMTP id z10so28755119pdj.0
        for <fstests@vger.kernel.org>; Mon, 23 Feb 2015 14:40:22 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] xfstests: add missing files to gitignore
Date: Mon, 23 Feb 2015 14:40:18 -0800
Message-Id: <41e91b5074c647e53d611a3fac515c7efd7a2ac8.1424730934.git.osandov@osandov.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>
List-ID: <fstests@vger.kernel.org>

Several binaries show up in git status after running make in a fresh
clone, and so do files introduced by normal usage.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2c9d640..5dc4f69 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,9 @@
 .libs
 .ltdep
 
+/local.config
+/results
+
 # autoconf generated files
 /autom4te.cache
 /configure
@@ -35,10 +38,12 @@
 /src/bstat
 /src/bulkstat_unlink_test
 /src/bulkstat_unlink_test_modified
+/src/dbtest
 /src/devzero
 /src/dirperf
 /src/dirstress
 /src/dmiperf
+/src/e4compact
 /src/fault
 /src/feature
 /src/fiemap-tester
@@ -99,12 +104,14 @@
 /src/writemod
 /src/xfsctl
 /src/aio-dio-regress/aio-dio-extend-stat
+/src/aio-dio-regress/aio-dio-fcntl-race
 /src/aio-dio-regress/aio-dio-hole-filling-race
 /src/aio-dio-regress/aio-dio-invalidate-failure
 /src/aio-dio-regress/aio-dio-invalidate-readahead
 /src/aio-dio-regress/aio-dio-subblock-eof-read
 /src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
 /src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
+/src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiodio_sparse2
 /src/cloner
 /src/renameat2
-- 
2.3.0

