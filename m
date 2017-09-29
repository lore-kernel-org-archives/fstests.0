Received: from mx1.redhat.com ([209.132.183.28]:38672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750891AbdI2CUV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 22:20:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8EA25D689
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 02:20:20 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 2/2] gitignore: sort src/ binaries name
Date: Fri, 29 Sep 2017 10:20:03 +0800
Message-Id: <1506651603-21876-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506651603-21876-1-git-send-email-xzhou@redhat.com>
References: <1506651603-21876-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .gitignore | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 63928b4..cfabcb3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,10 +56,12 @@
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
@@ -76,7 +78,6 @@
 /src/fsync-tester
 /src/ftrunc
 /src/genhashnames
-/src/dirhash_collide
 /src/getdevicesize
 /src/getpagesize
 /src/godown
@@ -98,11 +99,11 @@
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
@@ -118,8 +119,15 @@
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
@@ -134,6 +142,7 @@
 /src/writev_on_pagefault
 /src/xfsctl
 /src/aio-dio-regress/aio-dio-cycle-write
+/src/aio-dio-regress/aio-dio-eof-race
 /src/aio-dio-regress/aio-dio-extend-stat
 /src/aio-dio-regress/aio-dio-fcntl-race
 /src/aio-dio-regress/aio-dio-hole-filling-race
@@ -145,15 +154,6 @@
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
-/src/aio-dio-regress/aio-dio-eof-race
-/src/punch-alternating
-/src/cloner
-/src/renameat2
-/src/t_rename_overwrite
-/src/t_mmap_dio
-/src/t_mmap_stale_pmd
-/src/t_mmap_cow_race
-/src/t_mmap_fallocate
 /src/log-writes/replay-log
 
 # dmapi/ binaries
-- 
1.8.3.1

