Received: from mx1.redhat.com ([209.132.183.28]:43502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfBDPsR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Feb 2019 10:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E62217F416
        for <fstests@vger.kernel.org>; Mon,  4 Feb 2019 15:48:16 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA2C88A625
        for <fstests@vger.kernel.org>; Mon,  4 Feb 2019 15:48:15 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsstress: avoid splice_f generating too large sparse file
Date: Mon,  4 Feb 2019 23:48:09 +0800
Message-Id: <20190204154809.7990-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Thanks to Darrick J. Wong find this issue! Current splice_f generates
file offset as below:

  lr = ((int64_t)random() << 32) + random();
  off2 = (off64_t)(lr % maxfsize);

It generates a pseudorandom 64-bit candidate offset for the
destination file where we'll land the splice data, and then caps the
offset at maxfsize (which is 2^63- 1 on x64), which effectively means
that the data will appear at a very high file offset which creates
large (sparse) files very quickly.

That's not what we want, and some case likes shared/009 will take
forever to run md5sum on lots of huge files.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 68e40ee6..cacaedbc 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2874,10 +2874,11 @@ splice_f(int opno, long r)
 
 	/*
 	 * splice can overlap write, so the offset of the target file can be
-	 * any number (< maxfsize)
+	 * any number. But to avoid too large offset, add a clamp of 1024 blocks
+	 * past the current dest file EOF
 	 */
 	lr = ((int64_t)random() << 32) + random();
-	off2 = (off64_t)(lr % maxfsize);
+	off2 = (off64_t)(lr % MIN(stat2.st_size + (1024ULL * stat2.st_blksize), MAXFSIZE));
 
 	/*
 	 * Due to len, off1 and off2 will be changed later, so record the
-- 
2.17.2
