Received: from mx1.redhat.com ([209.132.183.28]:58589 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbbLVUyK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 15:54:10 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 6CB62219D
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 20:54:10 +0000 (UTC)
Received: from schleppi.home.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBMKs3S6007345
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 15:54:09 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/6] fsx: Fix hex numbers in operation dump
Date: Tue, 22 Dec 2015 21:53:52 +0100
Message-Id: <1450817636-11416-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
References: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Some hex numbers are prefixed with "0x" and right-aligned with spaces,
leading to output like "0x beef".  Make that "0x0beef" instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 ltp/fsx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 805fdfb..16d74c0 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -447,10 +447,10 @@ check_buffers(unsigned offset, unsigned size)
 			if (c != t) {
 			        if (n < 16) {
 					bad = short_at(&temp_buf[i]);
-				        prt("0x%5x\t0x%04x\t0x%04x", offset,
+				        prt("0x%05x\t0x%04x\t0x%04x", offset,
 				            short_at(&good_buf[offset]), bad);
 					op = temp_buf[offset & 1 ? i+1 : i];
-				        prt("\t0x%5x\n", n);
+				        prt("\t0x%05x\n", n);
 					if (op)
 						prt("operation# (mod 256) for "
 						  "the bad data may be %u\n",
-- 
2.4.3

