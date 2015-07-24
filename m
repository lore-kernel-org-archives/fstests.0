Received: from e28smtp04.in.ibm.com ([122.248.162.4]:35302 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbGXJfN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 24 Jul 2015 05:35:13 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <fstests@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
	Fri, 24 Jul 2015 15:05:10 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id B952E125805E
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2015 15:08:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6O9YLwU19071166
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2015 15:04:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6O8CUdw010354
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2015 13:42:30 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [TRIVIAL PATCH] check: Fix a typo
Date: Fri, 24 Jul 2015 15:04:04 +0530
Message-Id: <1437730444-30933-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-ID: <fstests@vger.kernel.org>

Fix the spelling of 'Argments' -> 'Arguments'.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index a3001309e7a0..573c72826b18 100755
--- a/check
+++ b/check
@@ -260,7 +260,7 @@ done
 if $have_test_arg; then
	while [ $# -gt 0 ]; do
		case "$1" in
-		-*)	echo "Argments before tests, please!"
+		-*)	echo "Arguments before tests, please!"
			status=1
			exit $status
			;;
--
2.1.2

