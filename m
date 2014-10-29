Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51032 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbaJ2E6p (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Oct 2014 00:58:45 -0400
Message-ID: <54507402.4000600@redhat.com>
Date: Tue, 28 Oct 2014 23:58:42 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs/068: fix expected output file for proper restore output
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, xfs-oss <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

Oh my, I did a very bad thing - I wrote a new test to
check for xfsdump regressions, but did not create the
.out file with a known-good kernel.

This matches output from older, stable kernels, and is the
proper expected output.  Sorry about that!

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/068.out b/tests/xfs/068.out
index c270c66..2196eee 100644
--- a/tests/xfs/068.out
+++ b/tests/xfs/068.out
@@ -22,7 +22,7 @@ xfsrestore: session id: ID
 xfsrestore: media ID: ID
 xfsrestore: searching media for directory dump
 xfsrestore: reading directories
-xfsrestore: 486 directories and 1590 entries processed
+xfsrestore: 495 directories and 1593 entries processed
 xfsrestore: directory post-processing
 xfsrestore: restoring non-directory files
 xfsrestore: restore complete: SECS seconds elapsed

