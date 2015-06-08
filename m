Received: from nebula-exfe-01.nebula.fi ([83.145.198.163]:26469 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752946AbbFHSkG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Jun 2015 14:40:06 -0400
Message-ID: <1433788464.28321.9.camel@ari-macbook>
Subject: [PATCH] common/punch, generic/273: Minor things for busybox support.
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 8 Jun 2015 21:34:24 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

These changes make it possible to run more of the tests on busybox.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 common/punch      | 4 ++--
 tests/generic/273 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/punch b/common/punch
index a75f4cf..7f268cd 100644
--- a/common/punch
+++ b/common/punch
@@ -203,7 +203,7 @@ _coalesce_extents()
 
 _filter_fiemap()
 {
-	awk --posix '
+	awk '
 		$3 ~ /hole/ {
 			print $1, $2, $3;
 			next;
@@ -223,7 +223,7 @@ _filter_fiemap()
 # it is an extent or a hole
 _filter_hole_fiemap()
 {
-	awk --posix '
+	awk '
 		$3 ~ /hole/ {
 			print $1, $2, $3; 
 			next;
diff --git a/tests/generic/273 b/tests/generic/273
index 1ceb6c4..f15fcf2 100755
--- a/tests/generic/273
+++ b/tests/generic/273
@@ -68,7 +68,7 @@ _file_create()
 
 	cd $SCRATCH_MNT/origin
 
-	_disksize=`$DF_PROG --block-size=1 $SCRATCH_DEV | tail -1 | awk '{ print $5 }'`
+	_disksize=`$DF_PROG -B 1 $SCRATCH_DEV | tail -1 | awk '{ print $5 }'`
 	_disksize=$(($_disksize / 3))
 	_num=$(($_disksize / $count / $threads / 4096))
 	_count=$count
-- 
1.9.1



