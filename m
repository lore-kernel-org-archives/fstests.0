Return-Path: <fstests-owner@vger.kernel.org>
Received: from nbl-ex10-fe01.nebula.fi ([188.117.32.121]:12189 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753943AbaIVM1Q (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Sep 2014 08:27:16 -0400
Message-ID: <1411388692.2869.21.camel@ari-macbook>
Subject: [PATCH 3/4] generic/310: Make killall invocations not use the path
 to the executable.
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 22 Sep 2014 15:24:52 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

This allows busybox killall to be used.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/310 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/310 b/tests/generic/310
index 9d46e87..c0a8645 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -103,7 +103,7 @@ _test_read()
 {
 	src/t_readdir_1 $SEQ_DIR &
 	sleep $RUN_TIME
-	killall src/t_readdir_1
+	killall t_readdir_1
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
@@ -114,7 +114,7 @@ _test_lseek()
 {
 	src/t_readdir_2 $SEQ_DIR &
 	sleep $RUN_TIME
-	killall src/t_readdir_2
+	killall t_readdir_2
 	check_kernel_bug
 	if [ $? -ne 0 ]; then
 		_fatal "kernel bug detected, check dmesg for more infomation."
-- 
2.1.0



