Received: from mx1.redhat.com ([209.132.183.28]:55740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfHEWtc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Aug 2019 18:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6601181F11
        for <fstests@vger.kernel.org>; Mon,  5 Aug 2019 22:49:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] aio-dio-regress: code clarification
Date: Tue,  6 Aug 2019 00:49:29 +0200
Message-Id: <20190805224929.25005-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

In this test, FILE_SIZE is defined as 300 but that definition isn't used
consistently.  Make the code more obvious.

(Used by generic/210.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/aio-dio-regress/aio-dio-subblock-eof-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-subblock-eof-read.c b/src/aio-dio-regress/aio-dio-subblock-eof-read.c
index 6f35b0e8..894965ea 100644
--- a/src/aio-dio-regress/aio-dio-subblock-eof-read.c
+++ b/src/aio-dio-regress/aio-dio-subblock-eof-read.c
@@ -63,7 +63,7 @@ main(int argc, char **argv)
 	/* <1> use normal disk read, this should be ok */
 	ret = read(fd, buffer, 4096);
 	if (ret != FILE_SIZE)
-		fail("buffered read returned %d, should be 300\n", ret);
+		fail("buffered read returned %d, should be %d\n", ret, FILE_SIZE);
 
 	/* <2> use AIO disk read, it sees error. */
 	memset(&myiocb, 0, sizeof(myiocb));
@@ -89,7 +89,7 @@ main(int argc, char **argv)
 		fail("io_getevents returned %d\n", ret);
 
 	/*
-	 *  If all goes well, we should see 300 bytes read.  If things
+	 *  If all goes well, we should see FILE_SIZE bytes read.  If things
 	 *  are broken, we may very well see a result of 4k.
 	 */
 	if (ie.res != FILE_SIZE)
-- 
2.20.1
