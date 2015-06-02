Return-Path: <fstests-owner@vger.kernel.org>
Received: from smtpproxy19.qq.com ([184.105.206.84]:35049 "EHLO
	smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbFBAdN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Jun 2015 20:33:13 -0400
Received: from bjgrwang.internal.tilera.com (unknown [124.207.145.166])
	by esmtp4.qq.com (ESMTP) with SMTP id 0
	for <fstests@vger.kernel.org>; Tue, 02 Jun 2015 08:32:55 +0800 (CST)
From: Wang Sheng-Hui <shhuiw@foxmail.com>
Subject: [PATCH] generic/288: correct the testcase description
Date: Tue,  2 Jun 2015 08:32:51 +0800
Message-Id: <1433205171-7392-1-git-send-email-shhuiw@foxmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The testcase tests 2 corner cases:
    Length is zero
    Length is smaller than block size
Correct the beginning description by changing "of" to "or".

Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
---
 tests/generic/288 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/288 b/tests/generic/288
index 0368828..aed6238 100755
--- a/tests/generic/288
+++ b/tests/generic/288
@@ -2,7 +2,7 @@
 # FS QA Test No. 288
 #
 # This check the FITRIM argument handling in the corner case where length is
-# smaller than block size of zero.
+# smaller than block size or zero.
 #
 #-----------------------------------------------------------------------
 # Copyright 2012 (C) Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>
-- 
1.8.3.2




