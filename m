Return-Path: <fstests-owner@vger.kernel.org>
Received: from nbl-ex10-fe01.nebula.fi ([188.117.32.121]:12628 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753558AbaIVM1f (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Sep 2014 08:27:35 -0400
Message-ID: <1411388774.2869.23.camel@ari-macbook>
Subject: [PATCH 4/4] generic/100: Don't use the -R option for tar.
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 22 Sep 2014 15:26:14 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

It does not seem to be necessary and is not supported by busybox tar.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/100 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/100 b/tests/generic/100
index 59b8e75..e5e819d 100755
--- a/tests/generic/100
+++ b/tests/generic/100
@@ -73,7 +73,7 @@ _require_scratch
 
 # untar on f/s
 cd $TEST_DIR
-tar -xRvf $TEMP_DIR/$TAR_FILE >>$seqres.full 2>&1
+tar -xvf $TEMP_DIR/$TAR_FILE >>$seqres.full 2>&1
 cd $here
 
 # use diff -qr to compare
-- 
2.1.0



