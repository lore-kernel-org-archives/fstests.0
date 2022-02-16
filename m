Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30CC433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Feb 2022 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiBPTEB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiBPTEA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Feb 2022 14:04:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA613D575
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 11:03:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A56721F37D
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645038225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/0VYcbA4HLOSJl66eHG5EU3/z1nVBItuJsB+/8s/6FU=;
        b=nRXXT4hhYYgAJ4OIC2eDx5A70nl3EpeAca3J6wrlREEqQdoP+OyOqk+yD4dlIW/fnlHSht
        nBI0xKZT4BOZVVtFnXWPrsPpnh+rq83LvRkB1PTjMGnm2mMk900HrrS6ENaoyK5gulylmO
        qQ6sRRxoA/W82peXLF6KPv6hWioriGw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 914E513B49
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 19:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v3EvI5FKDWJqEwAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 19:03:45 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] btrfs: add support for capturing metadumps of corrupted fses
Date:   Wed, 16 Feb 2022 20:03:34 +0100
Message-Id: <20220216190334.25213-1-ailiop@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add the capability to capture btrfs metadumps when filesystem checks
fail, so that they can be used for further debugging. This is useful for
tests that _require_test and/or _require_scratch for which filesystem
checkers will run after a test completes and may occasionally pick up
inconsistencies.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 README        |  4 ++--
 common/btrfs  | 15 +++++++++++++++
 common/config |  1 +
 common/rc     |  3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/README b/README
index e9284b229eca..9f01aa10d61a 100644
--- a/README
+++ b/README
@@ -110,8 +110,8 @@ Preparing system for tests:
              - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload
                it between test invocations.  This assumes that the name of
                the module is the same as FSTYP.
-             - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS or ext*
-               filesystems if a filesystem check fails.
+             - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS, ext* or
+               btrfs filesystems if a filesystem check fails.
              - Set DUMP_COMPRESSOR to a compression program to compress
                metadumps of filesystems.  This program must accept '-f' and the
                name of a file to compress; and it must accept '-d -f -k' and
diff --git a/common/btrfs b/common/btrfs
index 5de926dd9bfa..32d02bf2b3ce 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -155,6 +155,11 @@ _check_btrfs_filesystem()
 	fi
 	rm -f $tmp.fsck
 
+	if [ $ok -eq 0 ] && [ "$DUMP_CORRUPT_FS" = "1" ]; then
+		local flatdev="$(basename "$device")"
+		_btrfs_metadump "$device" "$seqres.$flatdev.check.md" >>$seqres.full
+	fi
+
 	if [ $ok -eq 0 ]; then
 		echo "*** mount output ***"		>>$seqres.full
 		_mount					>>$seqres.full
@@ -496,3 +501,13 @@ _require_btrfs_support_sectorsize()
 	grep -wq $sectorsize /sys/fs/btrfs/features/supported_sectorsizes || \
 		_notrun "sectorsize $sectorsize is not supported"
 }
+
+_btrfs_metadump()
+{
+	local device="$1"
+	local dumpfile="$2"
+
+	test -n "$BTRFS_IMAGE_PROG" || _fail "btrfs-image not installed"
+	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
+	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
+}
diff --git a/common/config b/common/config
index 0566ab4a963e..121ba000279f 100644
--- a/common/config
+++ b/common/config
@@ -227,6 +227,7 @@ export ACCTON_PROG="$(type -P accton)"
 export E2IMAGE_PROG="$(type -P e2image)"
 export BLKZONE_PROG="$(type -P blkzone)"
 export GZIP_PROG="$(type -P gzip)"
+export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/rc b/common/rc
index de60fb7b0677..e2d3d72a00f6 100644
--- a/common/rc
+++ b/common/rc
@@ -642,6 +642,9 @@ _metadump_dev() {
 	test "$DUMP_CORRUPT_FS" = 1 || return 0
 
 	case "$FSTYP" in
+	btrfs)
+		_btrfs_metadump $device $dumpfile
+		;;
 	ext*)
 		_ext4_metadump $device $dumpfile $compressopt
 		;;
-- 
2.35.1

