Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47202C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 21:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbiDYVSQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiDYVSP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 17:18:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8AE8F
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 14:15:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23PLEuFf002414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 17:14:57 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 667C915C3EA1; Mon, 25 Apr 2022 17:14:56 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] generic/681, generic/682: add debugging information to $seqreq.full
Date:   Mon, 25 Apr 2022 17:14:50 -0400
Message-Id: <20220425211450.3842888-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These two tests are checking whether a non-privileged user causing a
block allocation while expanding a directory block when over quota
will fail with an EDQUOT error.  There are three reasons why this can
fail.

* Aa test bug, where if the file system is using cluster allocation
  (for example, ext4 bigalloc) the test doesn't add enough directory
  entries to actually force directory grwoth.

* A file system bug, where the file system allocates blocks but for
  some reason isn't charging the space quota correctly (which
  currently seems to be the case in ext4 with fscrypt).

* A file system bug, where the file system is correctly charging the
  space quota to the unprivileged user, but isn't failing the system
  call with EDQUOT.

By adding some additional debugging information about whether
directory has grown or not (in addition to the existing repquota
output) to the the $seqres.full, it makes easier for the file system
developer to disambiguate between these possibilities.  It's cheap to
do this, and it could save developer time when trying to root cause
the failure.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/681 | 4 ++++
 tests/generic/682 | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/generic/681 b/tests/generic/681
index 2baae9f4..090da795 100755
--- a/tests/generic/681
+++ b/tests/generic/681
@@ -50,6 +50,8 @@ echo "set up quota" >> $seqres.full
 setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
 chown $qa_user $scratchdir $scratchfile
 repquota -upn $SCRATCH_MNT >> $seqres.full
+echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
+ls -sld $scratchdir  >> $seqres.full
 
 # Fail at appending the directory as qa_user to ensure quota enforcement works
 echo "fail quota" >> $seqres.full
@@ -60,6 +62,8 @@ for ((i = 0; i < dirents; i++)); do
 	test "${PIPESTATUS[0]}" -ne 0 && break
 done
 repquota -upn $SCRATCH_MNT >> $seqres.full
+echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
+ls -sld $scratchdir  >> $seqres.full
 
 # success, all done
 echo Silence is golden
diff --git a/tests/generic/682 b/tests/generic/682
index 31629a56..b4cd0cd9 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -51,6 +51,8 @@ echo "set up quota" >> $seqres.full
 setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
 chown $qa_user $scratchdir $scratchfile
 repquota -upn $SCRATCH_MNT >> $seqres.full
+echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
+ls -sld $scratchdir  >> $seqres.full
 
 # Fail at renaming into the directory as qa_user to ensure quota enforcement
 # works
@@ -64,6 +66,8 @@ for ((i = 0; i < dirents; i++)); do
 	test "${PIPESTATUS[0]}" -ne 0 && break
 done
 repquota -upn $SCRATCH_MNT >> $seqres.full
+echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
+ls -sld $scratchdir  >> $seqres.full
 
 # success, all done
 echo Silence is golden
-- 
2.31.0

