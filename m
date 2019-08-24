Received: from mail-pf1-f196.google.com ([209.85.210.196]:43636 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfHXOlv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Aug 2019 10:41:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so8644254pfn.10
        for <fstests@vger.kernel.org>; Sat, 24 Aug 2019 07:41:51 -0700 (PDT)
From: Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH v2] ltp/fsx: avoid infinite loop while finding offset2 in clone/dedupe/copy range ops
Date: Sat, 24 Aug 2019 22:41:07 +0800
Message-Id: <20190824144107.27748-1-guaneryu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

From: Eryu Guan <eguan@linux.alibaba.com>

In CLONE/DEDUPE/COPY RANGE operations, we pick a "offset" and "size"
first, then find a suitable "offset2" by looping if there's overlap
(|offset2-offset| < size) or final file size is greater than max
file size (offset2 + size > maxfilelen).

But it's possible that there's no such suitable offset2 and we loop
forever. e.g. block_size = 4096, offset = 0, size = 4096 and
maxfilelen is a value smaller than 8212 (which could be set via '-l'
option).

Fix it by making sure maxfilelen/file_size is big enough to hold
'size' bytes from 'offset2', and just skip this operation if not.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
v2:
- don't use macro with ugly hacks, use an inline function instead

 ltp/fsx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e93f3..890666ab6140 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1911,6 +1911,15 @@ fail:
 	return 0;
 }
 
+/* Check if range operations are possible to find a suitable offset */
+static inline bool check_range(unsigned long op, unsigned long off,
+			       unsigned long len, unsigned long size)
+{
+	bool ret = ((off + len * 2) <= size);
+	if (!ret)
+		log5(op, off, len, -1, FL_SKIPPED);
+	return ret;
+}
 
 int
 test(void)
@@ -1989,6 +1998,8 @@ test(void)
 		TRIM_OFF_LEN(offset, size, file_size);
 		offset = offset & ~(block_size - 1);
 		size = size & ~(block_size - 1);
+		if (!check_range(op, offset, size, maxfilelen))
+			goto out;
 		do {
 			offset2 = random();
 			TRIM_OFF(offset2, maxfilelen);
@@ -2003,6 +2014,8 @@ test(void)
 			TRIM_OFF_LEN(offset, size, file_size);
 			offset = offset & ~(block_size - 1);
 			size = size & ~(block_size - 1);
+			if (!check_range(op, offset, size, file_size))
+				goto out;
 			do {
 				if (tries++ >= 30) {
 					size = 0;
@@ -2020,6 +2033,8 @@ test(void)
 		offset -= offset % readbdy;
 		if (o_direct)
 			size -= size % readbdy;
+		if (!check_range(op, offset, size, maxfilelen))
+			goto out;
 		do {
 			offset2 = random();
 			TRIM_OFF(offset2, maxfilelen);
-- 
2.21.0
