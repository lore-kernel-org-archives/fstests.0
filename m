Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32869 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbDBP4V (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2015 11:56:21 -0400
Received: by wixm2 with SMTP id m2so58684148wix.0
        for <fstests@vger.kernel.org>; Thu, 02 Apr 2015 08:56:20 -0700 (PDT)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH] generic/076: fixed incorrect fsstress parameters
Date: Thu,  2 Apr 2015 18:56:08 +0300
Message-Id: <1427990168-21503-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

Test was not run because directory parameter was omitted.
Also return value was not tested, so this problem was not caught.

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
---
 tests/generic/076 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/076 b/tests/generic/076
index aa0aae0..3e1aa1a 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -74,9 +74,11 @@ echo "*** test concurrent block/fs access"
 cat $SCRATCH_DEV >/dev/null &
 pid=$!
 
-FSSTRESS_ARGS=`_scale_fsstress_args -p 2 -n 2000 $FSSTRESS_AVOID`
+FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
 echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
 $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
+rc=$?
+[ $rc != 0 ] && echo "fsstress returned $rc - see $seqres.full"
 _lets_get_pidst
 
 echo "*** done"
-- 
1.9.3

