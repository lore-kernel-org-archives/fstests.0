Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D202C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiBIW0V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7BE015271
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=muIG+O5/S4KB2qMjBKLY7jIgEKWuhsRT/ImKeHA4F8s=; b=rUm6LIdwT7yIk/X5KHw9XbQeKr
        /5i1/uRrmwopsK2UC1zW40UbNHmSwZDBGcvl2sm902S8OqumexgJo/ntL1DZLLbb47TY+eLi1WJF/
        wR2gs+fHjWYOroLWEilCIky0fdDUjTTT/TN4eAyTxAcXeicx2rqjBc7bqBsn6aYsi/fa8TkhLG0s9
        vFmrDuQyRDUz3/bFBPOhdFY6zoH4Ir/EUsJCDFHPIH4QIToZ0X5kogZaCsG+CJLlYO1MpMyu8O4Q7
        Hz+N0kef0JNNvE11qFBxEBWXjeyhXaie0BPN7flOtLUZQRo7eMW6p0fpWE8tAZUmSt0eJRjXl2DB2
        AK4iMP+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q6P-Ur; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 13/25] child: do not overlap on memcpy()
Date:   Wed,  9 Feb 2022 14:25:58 -0800
Message-Id: <20220209222610.438470-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fix this compilation warning:

gcc -g -O2 -Wall -W -I. -DVERSION=\"4.00\"
-DDATADIR=\"/usr/local/share\" `pkg-config --cflags libtirpc`
-Wimplicit-fallthrough=2   -c -o child.o child.c
In function ‘parse_randomstring’,
    inlined from ‘child_run’ at child.c:465:8:
child.c:291:17: warning: ‘memcpy’ accessing 255 bytes at offsets 0 and 1
overlaps 254 bytes at offset 1 [-Wrestrict]
  291 |                 memcpy(str, str+1, sizeof(str)-1);

We fix this by using a copy of the string to a original string
so to avoid having memcpy() overlap.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 child.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/child.c b/child.c
index 2545e4c..715452e 100644
--- a/child.c
+++ b/child.c
@@ -250,6 +250,7 @@ static int parse_randomstring(char *line)
 	int num;
 	char *pstart, *pend, rndc[2];
 	unsigned int idx;
+	char str_orig[256];
 	char str[256];
 	size_t min_len;
 
@@ -262,6 +263,7 @@ again:
 	/* Truncate or use the smaller size passed */
 	min_len = strlen(line) < sizeof(str) ? strlen(line) : sizeof(str);
 	strncpy(str, pstart, min_len);
+	strncpy(str_orig, pstart, min_len);
 
 	pend = index(str, ']');
 	if (pstart == NULL) {
@@ -288,7 +290,7 @@ finished:
 	}
 	/* remote initial " */
 	while (str[0] == '"') {
-		memcpy(str, str+1, sizeof(str)-1);
+		memcpy(str, str_orig+1, sizeof(str_orig)-1);
 	}
 	/* remote trailing " */
 	while (1) {
-- 
2.34.1

