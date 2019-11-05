Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C3C17461
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73E221D7C
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfKENT2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:19:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:51606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388753AbfKENT2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Nov 2019 08:19:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DCFDB512
        for <fstests@vger.kernel.org>; Tue,  5 Nov 2019 13:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 09F9F1E420F; Tue,  5 Nov 2019 14:19:26 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] generic/050: Fix test failure for filesystems without journal
Date:   Tue,  5 Nov 2019 14:19:21 +0100
Message-Id: <20191105131922.24848-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105131922.24848-1-jack@suse.cz>
References: <20191105131922.24848-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Filesystems without journal can happily mount unrecovered filesystem
read-only which confuses this test. Handle this by providing different
expected output for filesystems without journal.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc                                  | 33 +++++++++++++++++++++++-------
 tests/generic/050                          |  8 ++++++++
 tests/generic/050.cfg                      |  1 +
 tests/generic/{050.out => 050.out.default} |  0
 tests/generic/050.out.nojournal            | 22 ++++++++++++++++++++
 5 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 tests/generic/050.cfg
 rename tests/generic/{050.out => 050.out.default} (100%)
 create mode 100644 tests/generic/050.out.nojournal

diff --git a/common/rc b/common/rc
index e0b087c10e8f..881802b941ab 100644
--- a/common/rc
+++ b/common/rc
@@ -3143,7 +3143,7 @@ _require_norecovery()
 # It's possible that TEST_DEV and SCRATCH_DEV have different features (it'd be
 # odd, but possible) so check $TEST_DEV by default, but we can optionall pass
 # any dev we want.
-_require_metadata_journaling()
+_has_metadata_journaling()
 {
 	if [ -z $1 ]; then
 		local dev=$TEST_DEV
@@ -3153,26 +3153,37 @@ _require_metadata_journaling()
 
 	case "$FSTYP" in
 	ext2|vfat|msdos|udf)
-		_notrun "$FSTYP does not support metadata journaling"
+		echo "$FSTYP does not support metadata journaling"
+		return 1
 		;;
 	ext4)
 		# ext4 could be mkfs'd without a journal...
 		_require_dumpe2fs
-		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q has_journal || \
-			_notrun "$FSTYP on $dev not configured with metadata journaling"
+		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q has_journal || {
+			echo "$FSTYP on $dev not configured with metadata journaling"
+			return 1
+		}
 		# ext4 might not load a journal
-		_exclude_scratch_mount_option "noload"
+		if _normalize_mount_options | grep -qw "noload"; then
+			echo "mount option \"noload\" not allowed in this test"
+			return 1
+		fi
 		;;
 	overlay)
 		# metadata journaling check is based on base filesystem configurations
 		# and  because -overlay option saves those configurations to OVL_BASE_*,
 		# adding restore/override the configurations before/after the check.
 		if [ ! -z $OVL_BASE_FSTYP -a $OVL_BASE_FSTYP != "overlay" ]; then
+			local ret
+
 			_overlay_config_restore
-			_require_metadata_journaling
+			_has_metadata_journaling
+			ret=$?
 			_overlay_config_override
+			return $ret
 		else
-			_notrun "No metadata journaling support for legacy overlay setup"
+			echo "No metadata journaling support for legacy overlay setup"
+			return 1
 		fi
 		;;
 	*)
@@ -3181,6 +3192,14 @@ _require_metadata_journaling()
 	esac
 }
 
+_require_metadata_journaling()
+{
+	msg=$(_has_metadata_journaling $@)
+	if [ -n "$msg" ]; then
+		_notrun "$msg"
+	fi
+}
+
 _count_extents()
 {
 	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
diff --git a/tests/generic/050 b/tests/generic/050
index 91632d2d0010..a8d648e5eede 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -6,6 +6,7 @@
 #
 # Check out various mount/remount/unmount scenarious on a read-only blockdev.
 #
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -34,6 +35,13 @@ _require_scratch_shutdown
 _require_local_device $SCRATCH_DEV
 _require_norecovery
 
+# Select appropriate output file
+features=""
+if ! _has_metadata_journaling $SCRATCH_DEV >/dev/null; then
+	features="nojournal"
+fi
+_link_out_file "$features"
+
 _scratch_mkfs >/dev/null 2>&1
 
 filter_ro_mount() {
diff --git a/tests/generic/050.cfg b/tests/generic/050.cfg
new file mode 100644
index 000000000000..c76bd473873b
--- /dev/null
+++ b/tests/generic/050.cfg
@@ -0,0 +1 @@
+nojournal: nojournal
diff --git a/tests/generic/050.out b/tests/generic/050.out.default
similarity index 100%
rename from tests/generic/050.out
rename to tests/generic/050.out.default
diff --git a/tests/generic/050.out.nojournal b/tests/generic/050.out.nojournal
new file mode 100644
index 000000000000..c652c555aae4
--- /dev/null
+++ b/tests/generic/050.out.nojournal
@@ -0,0 +1,22 @@
+QA output created by 050
+setting device read-only
+mounting read-only block device:
+mount: device write-protected, mounting read-only
+touching file on read-only filesystem (should fail)
+touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
+unmounting read-only filesystem
+setting device read-write
+mounting read-write block device:
+touch files
+going down:
+unmounting shutdown filesystem:
+setting device read-only
+mounting filesystem that needs recovery on a read-only device:
+mount: device write-protected, mounting read-only
+unmounting read-only filesystem
+mounting filesystem with -o norecovery on a read-only device:
+mount: device write-protected, mounting read-only
+unmounting read-only filesystem
+setting device read-write
+mounting filesystem that needs recovery with -o ro:
+*** done
-- 
2.16.4

