Received: from nebula-exfe-01.nebula.fi ([83.145.198.163]:52690 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751763AbbHYKMk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 25 Aug 2015 06:12:40 -0400
Message-ID: <1440497203.29614.1.camel@ari-macbook>
Subject: [PATCH] busybox compat: use stat -c instead of stat --format
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 25 Aug 2015 13:06:43 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/040 |    4 ++--
 tests/generic/041 |    2 +-
 tests/generic/104 |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/040 b/tests/generic/040
index c841fbc..b44a433 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -122,9 +122,9 @@ _mount_flakey
 # The fstests framework automatically calls fsck after a test is run, so we
 # don't need to call fsck explicitly here.
 
-echo "Link count before rm foo_link_*: $(stat --format=%h $SCRATCH_MNT/foo)"
+echo "Link count before rm foo_link_*: $(stat -c %h $SCRATCH_MNT/foo)"
 rm -f $SCRATCH_MNT/foo_link_*
-echo "Link count after rm foo_link_*: $(stat --format=%h $SCRATCH_MNT/foo)"
+echo "Link count after rm foo_link_*: $(stat -c %h $SCRATCH_MNT/foo)"
 cat $SCRATCH_MNT/foo
 
 status=0
diff --git a/tests/generic/041 b/tests/generic/041
index f38b662..50fb26f 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -116,7 +116,7 @@ _mount_flakey
 # the hard links and read the file's data. This is just to verify we don't
 # get stale file handle errors (due to dangling directory index entries that
 # point to inodes that no longer exist).
-echo "Link count: $(stat --format=%h $SCRATCH_MNT/foo)"
+echo "Link count: $(stat -c %h $SCRATCH_MNT/foo)"
 [ -f $SCRATCH_MNT/foo ] || echo "Link foo is missing"
 for ((i = 1; i <= 3003; i++)); do
 	name=foo_link_`printf "%04d" $i`
diff --git a/tests/generic/104 b/tests/generic/104
index eeb7363..fef3583 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -81,8 +81,8 @@ _load_flakey_table $FLAKEY_ALLOW_WRITES
 _mount_flakey
 
 # Now verify both our files have a link count of 2.
-echo "Link count for file foo: $(stat --format=%h $SCRATCH_MNT/testdir/foo)"
-echo "Link count for file bar: $(stat --format=%h $SCRATCH_MNT/testdir/bar)"
+echo "Link count for file foo: $(stat -c %h $SCRATCH_MNT/testdir/foo)"
+echo "Link count for file bar: $(stat -c %h $SCRATCH_MNT/testdir/bar)"
 
 # We should be able to remove all the links of our files in testdir, and after
 # that the parent directory should become empty and therefore possible to
-- 
1.7.10.4


