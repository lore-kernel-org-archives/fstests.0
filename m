Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32914 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbbEGKjU (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 May 2015 06:39:20 -0400
Received: by wief7 with SMTP id f7so10574060wie.0
        for <fstests@vger.kernel.org>; Thu, 07 May 2015 03:39:19 -0700 (PDT)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH v2] generic/076: fixed incorrect fsstress parameters
Date: Thu,  7 May 2015 13:39:10 +0300
Message-Id: <1430995150-16749-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

Test was not run because directory parameter was omitted.

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Tested-by: Filipe Manana <fdmanana@suse.com>
---
changelog:
v2:
  Removed fsstress return value check, as Dave instructed.
  Rebased to latest xfstests.
---
 tests/generic/076 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/076 b/tests/generic/076
index aa0aae0..f3e5b6f 100755
--- a/tests/generic/076
+++ b/tests/generic/076
@@ -74,7 +74,7 @@ echo "*** test concurrent block/fs access"
 cat $SCRATCH_DEV >/dev/null &
 pid=$!
 
-FSSTRESS_ARGS=`_scale_fsstress_args -p 2 -n 2000 $FSSTRESS_AVOID`
+FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
 echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
 $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
 _lets_get_pidst
-- 
1.9.3

