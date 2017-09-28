Received: from mx1.redhat.com ([209.132.183.28]:44416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdI1Hl5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 03:41:57 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v6 2/4] gitignore: sort src/ binaries name
Date: Thu, 28 Sep 2017 15:41:38 +0800
Message-Id: <1506584500-867-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506584500-867-1-git-send-email-xzhou@redhat.com>
References: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .gitignore | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/.gitignore b/.gitignore
index 63928b4..73ab533 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,19 @@
 
 # src/ binaries
 /src/af_unix
+/src/aio-dio-regress/aio-dio-cycle-write
+/src/aio-dio-regress/aio-dio-eof-race
+/src/aio-dio-regress/aio-dio-extend-stat
+/src/aio-dio-regress/aio-dio-fcntl-race
+/src/aio-dio-regress/aio-dio-hole-filling-race
+/src/aio-dio-regress/aio-dio-invalidate-failure
+/src/aio-dio-regress/aio-dio-invalidate-readahead
+/src/aio-dio-regress/aio-dio-subblock-eof-read
+/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
+/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
+/src/aio-dio-regress/aio-last-ref-held-by-io
+/src/aio-dio-regress/aiocp
+/src/aio-dio-regress/aiodio_sparse2
 /src/alloc
 /src/append_reader
 /src/append_writer
@@ -56,10 +69,12 @@
 /src/bstat
 /src/bulkstat_unlink_test
 /src/bulkstat_unlink_test_modified
+/src/cloner
 /src/dbtest
 /src/devzero
 /src/dio-interleaved
 /src/dio-invalidate-cache
+/src/dirhash_collide
 /src/dirperf
 /src/dirstress
 /src/dmiperf
@@ -76,7 +91,6 @@
 /src/fsync-tester
 /src/ftrunc
 /src/genhashnames
-/src/dirhash_collide
 /src/getdevicesize
 /src/getpagesize
 /src/godown
@@ -85,6 +99,7 @@
 /src/itrash
 /src/listxattr
 /src/locktest
+/src/log-writes/replay-log
 /src/loggen
 /src/looptest
 /src/lstat64
@@ -98,11 +113,11 @@
 /src/permname
 /src/preallo_rw_pattern_reader
 /src/preallo_rw_pattern_writer
+/src/punch-alternating
 /src/pwrite_mmap_blocked
 /src/randholes
-/src/t_readdir_1
-/src/t_readdir_2
 /src/rename
+/src/renameat2
 /src/resvtest
 /src/runas
 /src/seek_copy_test
@@ -118,8 +133,15 @@
 /src/t_getcwd
 /src/t_holes
 /src/t_immutable
+/src/t_mmap_cow_race
+/src/t_mmap_dio
+/src/t_mmap_fallocate
+/src/t_mmap_stale_pmd
 /src/t_mmap_writev
 /src/t_mtab
+/src/t_readdir_1
+/src/t_readdir_2
+/src/t_rename_overwrite
 /src/t_stripealign
 /src/t_truncate_cmtime
 /src/t_truncate_self
@@ -133,28 +155,6 @@
 /src/writemod
 /src/writev_on_pagefault
 /src/xfsctl
-/src/aio-dio-regress/aio-dio-cycle-write
-/src/aio-dio-regress/aio-dio-extend-stat
-/src/aio-dio-regress/aio-dio-fcntl-race
-/src/aio-dio-regress/aio-dio-hole-filling-race
-/src/aio-dio-regress/aio-dio-invalidate-failure
-/src/aio-dio-regress/aio-dio-invalidate-readahead
-/src/aio-dio-regress/aio-dio-subblock-eof-read
-/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
-/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
-/src/aio-dio-regress/aio-last-ref-held-by-io
-/src/aio-dio-regress/aiocp
-/src/aio-dio-regress/aiodio_sparse2
-/src/aio-dio-regress/aio-dio-eof-race
-/src/punch-alternating
-/src/cloner
-/src/renameat2
-/src/t_rename_overwrite
-/src/t_mmap_dio
-/src/t_mmap_stale_pmd
-/src/t_mmap_cow_race
-/src/t_mmap_fallocate
-/src/log-writes/replay-log
 
 # dmapi/ binaries
 /dmapi/src/common/cmd/read_invis
-- 
1.8.3.1

