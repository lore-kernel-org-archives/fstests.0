Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbaJIIj2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Oct 2014 04:39:28 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/262: update filter to deal with long device name correctly
Date: Thu,  9 Oct 2014 16:38:51 +0800
Message-Id: <1412843931-10447-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

If the device name is too long, the output of xfs_quota -c "df" will be
broke into two lines as

Filesystem           1K-blocks       Used  Available  Use% Pathname
/dev/mapper/rhel_hp--dl388eg8--01-testlv2
                      15718400      32932   15685468    0% /mnt/testarea/scratch
/dev/mapper/rhel_hp--dl388eg8--01-testlv2
                        512000          0     512000    0% /mnt/testarea/scratch/test

and _filter_quota_rpt() couldn't catch the correct available number and
test will fail as

	[root@hp-dl388g8-01 xfstests]# diff -u tests/xfs/262.out /root/xfstests/results//xfs/262.out.bad
	--- tests/xfs/262.out   2014-10-08 20:16:19.000000000 +0800
	+++ /root/xfstests/results//xfs/262.out.bad  2014-10-09 14:29:38.795813323 +0800
	@@ -1,2 +1,4 @@
	 QA output created by 262
	 Silence is golden.
	+hard limit 0 bytes, expected 524288000
	+hard limit 0 bytes, expected 524288000

Update the filter so it could catch the correct value.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/262 | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/262 b/tests/xfs/262
index 6040f62..9d8b838 100755
--- a/tests/xfs/262
+++ b/tests/xfs/262
@@ -76,6 +76,8 @@ _require_scratch
 # both the "df" and the "report" output.  For "report", the line we're
 # interested in contains our project name in the first field.  For "df"
 # it contains our project directory in the last field.
+# But if the device name is too long, the "df" output is broke into two
+# lines, the fourth field is not correct, so take $(nf-2) of "df"
 _filter_quota_rpt() {
 	awk '
 	BEGIN {
@@ -96,9 +98,15 @@ _filter_quota_rpt() {
 		return result;
 	}
 	{
-		if ($1 !~ proj_name && $nf !~ proj_dir)
+		if ($1 =~ proj_name) {
+			# this is the "report" output
+			bsize = byte_size($4);
+		} else if ($nf =~ proj_dir) {
+			# this is the "df" output
+			bsize = byte_size($(nf-2));
+		} else {
 			next;
-		bsize = byte_size($4);
+		}
 		if (bsize != qlimit)
 			printf("hard limit %d bytes, expected %d\n",
 				bsize, qlimit);
-- 
1.8.3.1

