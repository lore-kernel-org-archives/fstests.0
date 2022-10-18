Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD7C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 18:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRSQp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJRSQo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Oct 2022 14:16:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509833436
        for <fstests@vger.kernel.org>; Tue, 18 Oct 2022 11:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE36EB820EC
        for <fstests@vger.kernel.org>; Tue, 18 Oct 2022 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC72C433D6;
        Tue, 18 Oct 2022 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666117000;
        bh=U9tblLfgIT/spVxHTS81sl8QNOWD+4+sBmXnDwfyzKk=;
        h=From:To:Cc:Subject:Date:From;
        b=oDibwypjz81hqsf5wSN1fHJrROrz5AlzvMjeUlzYwv+yY7HOwNfko6F+KD3sxD7YG
         nCkQ5YclonByYCK5PJmOicfstMLehZAI3dy2QEX+xnoOiLeDjygaEwqqpBxuMTiNct
         5o9kjK2Gj7qQPU+mM88E84mSgAdJdK3RsRTrnXuqJu/wyUL9LySkYVm5yL+r1POZAY
         NDx11FVwz2hZb5z6AKqegz355+ow9Nkw967Fn95pNyBy18p9ebhy3T20BbxS8iGpck
         qM74A8b6LkCGNFeVME9+aSPSD7b70Au5VVLILmrHU4Bs315SQU2so6xFGju9E3E5uJ
         TIGEpvSV1OMKQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] Use grep -E instead of egrep
Date:   Tue, 18 Oct 2022 11:16:26 -0700
Message-Id: <20221018181626.154383-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Avoid some of the "egrep is obsolescent" warnings that the latest
version of GNU grep prints.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 run-fstests/get-results                          |  8 ++++----
 setup-buildchroot                                |  2 +-
 test-appliance/android-setup-partitions          | 10 +++++-----
 test-appliance/files/usr/local/sbin/gce-shutdown | 16 ++++++++--------
 test-appliance/files/usr/local/sbin/get-results  |  8 ++++----
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/run-fstests/get-results b/run-fstests/get-results
index ebaf701..d899c33 100755
--- a/run-fstests/get-results
+++ b/run-fstests/get-results
@@ -21,12 +21,12 @@ then
     IN=$(/bin/ls -t logs/log.* | head -1)
 fi
 
-egrep "$REGEXP" "$IN"
+grep -E "$REGEXP" "$IN"
 if test -n "$do_failure"; then
-    b=$(egrep ^BEGIN "$IN" | wc -l)
-    e=$(egrep ^END "$IN" | wc -l)
+    b=$(grep -E ^BEGIN "$IN" | wc -l)
+    e=$(grep -E ^END "$IN" | wc -l)
     if test "$b" -gt "$e" ; then
-	l=$(egrep ^BEGIN "$IN" | tail -n 1 | sed -e 's/BEGIN //')
+	l=$(grep -E ^BEGIN "$IN" | tail -n 1 | sed -e 's/BEGIN //')
 	echo " "
 	echo Missing END "$l"
     fi
diff --git a/setup-buildchroot b/setup-buildchroot
index 6cf14b3..ff2b01f 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -421,7 +421,7 @@ get_schroot_config()
     then
 	(cd $SCHROOT_CHROOT_D ;
 	 find . -maxdepth 1 -type f |
-	     egrep '^./[a-ZA-Z0-9_-][a-ZA-Z0-9_.-]*$' |
+	     grep -E '^./[a-ZA-Z0-9_-][a-ZA-Z0-9_.-]*$' |
 	     xargs cat)
     fi
 }
diff --git a/test-appliance/android-setup-partitions b/test-appliance/android-setup-partitions
index 2eb5fca..1f4bb7e 100755
--- a/test-appliance/android-setup-partitions
+++ b/test-appliance/android-setup-partitions
@@ -57,7 +57,7 @@ pprint_bytes()
 get_partition_number()
 {
     local dev=$1
-    echo $dev | egrep -o '[0-9]+$'
+    echo $dev | grep -E -o '[0-9]+$'
 }
 
 # Get the size in bytes of the given partition, as stored in the partition table
@@ -108,7 +108,7 @@ find_userdata_partition()
     if [ ! -b $dev ]; then
 	die "Unable to find the userdata partition"
     fi
-    if ! echo $dev | egrep -q '[0-9]+$'; then
+    if ! echo $dev | grep -E -q '[0-9]+$'; then
 	die "Name of userdata device node has an unexpected format: \"$dev\""
     fi
     echo $dev
@@ -118,7 +118,7 @@ find_userdata_partition()
 find_dm_device_by_name()
 {
     local dm_device_name=$1
-    if ls /sys/class/block/ | egrep -q 'dm-[0-9]+$'; then
+    if ls /sys/class/block/ | grep -E -q 'dm-[0-9]+$'; then
 	for dir in /sys/class/block/dm-*; do
 	    if [ $dm_device_name = $(< $dir/dm/name) ]; then
 		local dev=/dev/block/$(basename $dir)
@@ -173,8 +173,8 @@ validate_dm_device()
 	;;
     esac
 
-    if ! echo "$start_sector" | egrep -q '^[0-9]+$' ||
-       ! echo "$raw_devno" | egrep -q '^[0-9]+:[0-9]+$'; then
+    if ! echo "$start_sector" | grep -E -q '^[0-9]+$' ||
+       ! echo "$raw_devno" | grep -E -q '^[0-9]+:[0-9]+$'; then
 	die "device-mapper device \"$dm_devname\" uses target with" \
 	    "unsupported table format: ${table[@]}"
     fi
diff --git a/test-appliance/files/usr/local/sbin/gce-shutdown b/test-appliance/files/usr/local/sbin/gce-shutdown
index 9ebe008..0ca1d32 100755
--- a/test-appliance/files/usr/local/sbin/gce-shutdown
+++ b/test-appliance/files/usr/local/sbin/gce-shutdown
@@ -24,13 +24,13 @@ REGEXP_FAILURE="(^CMDLINE)|(^FSTEST)|(^MNTOPTS)|(^CPUS:)|(^MEM:)|(^BEGIN)|(^Fail
 
 function gen_xfstests_summary()
 {
-    egrep "$REGEXP" < /results/runtests.log > /results/summary
+    grep -E "$REGEXP" < /results/runtests.log > /results/summary
 
-    egrep "$REGEXP_FAILURE" < /results/runtests.log > /results/failures
+    grep -E "$REGEXP_FAILURE" < /results/runtests.log > /results/failures
     printf "\n" >> /results/failures
     sed -n -f /usr/local/lib/get-check-failures.sed < /results/runtests.log >> /results/failures
     printf "\n" >> /results/failures
-    egrep "$SYSLOG_RE_FAILURE" < /results/syslog >> /results/failures
+    grep -E "$SYSLOG_RE_FAILURE" < /results/syslog >> /results/failures
 }
 
 BLK_REGEXP="( Linux version )|(^CMDLINE)|(^FSTEST)|(^MNTOPTS)|(^CPUS:)|(^MEM:)|(^BEGIN)|(^MOUNT_OPTIONS)|(^MKFS_OPTIONS)|(^EXT4-fs error)|(WARNING)|(^_check_)|(inconsistent)|(^Shutdown reason)"
@@ -38,24 +38,24 @@ BLK_REGEXP_FAILURE="( Linux version )|(^CMDLINE)|(^FSTEST)|(^MNTOPTS)|(^CPUS:)|(
 
 function gen_blktests_summary()
 {
-    run_tests=$(egrep "(\[failed\])|(\[passed\])" < /results/runtests.log | awk '{print $1}')
-    failed_tests=$(egrep "\[failed\]" < /results/runtests.log | awk '{print $1}')
+    run_tests=$(grep -E "(\[failed\])|(\[passed\])" < /results/runtests.log | awk '{print $1}')
+    failed_tests=$(grep -E "\[failed\]" < /results/runtests.log | awk '{print $1}')
 
     nr_run="$(echo $run_tests | wc -w)"
     nr_failed="$(echo $failed_tests | wc -w)"
 
-    egrep "$BLK_REGEXP" < /results/runtests.log > /results/summary
+    grep -E "$BLK_REGEXP" < /results/runtests.log > /results/summary
     echo "Run: $(echo $run_tests)" >> /results/summary
     echo "Failures: $(echo $failed_tests)" >> /results/summary
     echo "Failed $nr_failed of $nr_run tests" >> /results/summary
     grep ^END < /results/runtests.log >> /results/summary
 
-    egrep "$BLK_REGEXP_FAILURE" < /results/runtests.log >> /results/failures
+    grep -E "$BLK_REGEXP_FAILURE" < /results/runtests.log >> /results/failures
     echo "Run: $(echo $run_tests)" >> /results/failures
     echo "Failures: $(echo $failed_tests)" >> /results/failures
     echo "Failed $nr_failed of $nr_run tests" >> /results/failures
     grep ^END < /results/runtests.log >> /results/failures
-    egrep "$SYSLOG_RE_FAILURE" < /results/syslog >> /results/failures
+    grep -E "$SYSLOG_RE_FAILURE" < /results/syslog >> /results/failures
 }
 
 reason=$(gce_attribute shutdown_reason)
diff --git a/test-appliance/files/usr/local/sbin/get-results b/test-appliance/files/usr/local/sbin/get-results
index 7169b12..053c45c 100755
--- a/test-appliance/files/usr/local/sbin/get-results
+++ b/test-appliance/files/usr/local/sbin/get-results
@@ -21,12 +21,12 @@ then
     IN=-
 fi
 
-egrep "$REGEXP" "$IN"
+grep -E "$REGEXP" "$IN"
 if test -n "$do_failure"; then
-    b=$(egrep ^BEGIN "$IN" | wc -l)
-    e=$(egrep ^END "$IN" | wc -l)
+    b=$(grep -E ^BEGIN "$IN" | wc -l)
+    e=$(grep -E ^END "$IN" | wc -l)
     if test "$b" -gt "$e" ; then
-	l=$(egrep ^BEGIN "$IN" | tail -n 1 | sed -e 's/BEGIN //')
+	l=$(grep -E ^BEGIN "$IN" | tail -n 1 | sed -e 's/BEGIN //')
 	echo " "
 	echo Missing END "$l"
     fi
-- 
2.38.0

