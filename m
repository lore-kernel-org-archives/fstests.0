Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33689 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933069AbbELShG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 May 2015 14:37:06 -0400
Received: by wief7 with SMTP id f7so118962857wie.0
        for <fstests@vger.kernel.org>; Tue, 12 May 2015 11:37:05 -0700 (PDT)
From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH] generic: Fix _is_block_dev quoting
Date: Tue, 12 May 2015 20:36:39 +0200
Message-Id: <1431455799-13289-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

Add more quoting so that test cases that don't require a SCRATCH_DEV won't
fail.

Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
---
 common/rc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index 6ea107e..bec7417 100644
--- a/common/rc
+++ b/common/rc
@@ -967,11 +967,11 @@ _is_block_dev()
 
     _dev=$1
     if [ -L "${_dev}" ]; then
-        _dev=`readlink -f ${_dev}`
+        _dev=`readlink -f "${_dev}"`
     fi
 
     if [ -b "${_dev}" ]; then
-        src/lstat64 ${_dev} | $AWK_PROG '/Device type:/ { print $9 }'
+        src/lstat64 "${_dev}" | $AWK_PROG '/Device type:/ { print $9 }'
     fi
 }
 
@@ -1105,11 +1105,11 @@ _require_scratch_nocheck()
 		fi
 		;;
 	*)
-		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
+		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
 		     _notrun "this test requires a valid \$SCRATCH_DEV"
 		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
+		 if [ "`_is_block_dev "$SCRATCH_DEV"`" = "`_is_block_dev "$TEST_DEV"`" ]
 		 then
 		     _notrun "this test requires a valid \$SCRATCH_DEV"
 		 fi
@@ -1179,11 +1179,11 @@ _require_test()
 		fi
 		;;
 	*)
-		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
+		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
 		     _notrun "this test requires a valid \$TEST_DEV"
 		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
+		 if [ "`_is_block_dev "$SCRATCH_DEV"`" = "`_is_block_dev "$TEST_DEV"`" ]
 		 then
 		     _notrun "this test requires a valid \$TEST_DEV"
 		 fi
@@ -2282,10 +2282,10 @@ _require_scratch_dev_pool()
 	esac
 
 	for i in $SCRATCH_DEV_POOL; do
-		if [ "`_is_block_dev $i`" = "" ]; then
+		if [ "`_is_block_dev "$i"`" = "" ]; then
 			_notrun "this test requires valid block disk $i"
 		fi
-		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
+		if [ "`_is_block_dev "$i"`" = "`_is_block_dev "$TEST_DEV"`" ]; then
 			_notrun "$i is part of TEST_DEV, this test requires unique disks"
 		fi
 		if _mount | grep -q $i; then
-- 
2.4.0

