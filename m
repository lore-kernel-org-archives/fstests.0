Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213888801
	for <fstests@vger.kernel.org>; Thu, 11 Jul 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663154; cv=none; b=j9bKuhtiAK7E8tFjzp7iZMYGgArCou7Cr9YyV8aBMeC+QqW1pPLbydNQy/M3v+CiusnuEHk5l3d0bO5yxTjp0RWvU6kDXMTmgUTjQWFx0TiQ09BR7o7Emr09e20xyszGok4v7MqBs8cLFTmZZaXRSVpklnMLDAOhp/Fiv3CCuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663154; c=relaxed/simple;
	bh=rWedrg8RFLPX73RGXYv7bt5RLDNoNl7OiqJuZN4cXRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxuH/wsQp/iCAidQ3XzkQ3HomTrUKLNeYylUCHDhTcJyxNene/Zy3IbJZgPmSfJ6wKYfAqawpxWWgJSifM26HQ49UGVbxbYbz6rrDFWmUNMEhyCsG+CiUIlnkomIxWeuno1PNYcgUdYcdqAEyXgqPcCy8hcRzkNmWoUiAUixMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HrBVrSRz; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HrBVrSRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=3QjC9
	9BDsdH9j721fOWrsY/qGoRYqUeRxVEjLTCFcy0=; b=HrBVrSRzRNiHJjsE2Ach6
	rOvQtA28snkuWRffFDya1KhZwamrxjVGpjj0tXeysR+r1oUPLqO2Mc2sprCUyIVS
	+QOK9HKvL2ocqWy5KWdNsSi7ig5g6WKXo1sdRuicNYpva3Lf4j717kgvw8bRpWDU
	xFWLPfkV+AEa7visWiUgEQ=
Received: from chi-book.. (unknown [111.48.69.245])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3369XPI9mT0CsCQ--.52550S2;
	Thu, 11 Jul 2024 09:58:48 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] t_stripealign: add stripe alignment check for all extents
Date: Thu, 11 Jul 2024 09:58:12 +0800
Message-ID: <20240711015812.95489-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3369XPI9mT0CsCQ--.52550S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWkZF4Dtr4rXr1DAFW8JFb_yoW5JF47pr
	4fu3Z0grs5W3yIgF1ay3s8JFnxW34kWF1UCFW7WF1jyFZaq3yfGrnFkryFgr1DGrWkXa4Y
	vFZavFyUGasrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDDGrUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBLxEZnWXAlTJ1fQACsy

From: Chi Zhiling <chizhiling@kylinos.cn>

When testing generic/223, if the file occupies multiple extents,
the t_stripealign only checks the first extent. Therefore, this
patch adds a check for all extents

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 src/t_stripealign.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index 00a5a3d1..87c2c4e8 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * t_stripealign.c
- * Print whether the file start block is stripe-aligned.
+ * Print whether the file start block of all extents is stripe-aligned.
  * Copyright (c) 2010 Eric Sandeen <sandeen@sandeen.net>
  */
 #include <unistd.h>
@@ -13,6 +13,7 @@
 #include <sys/ioctl.h>
 #include <linux/fiemap.h>
 #include <linux/fs.h>
+#include <sys/stat.h>
 
 #ifndef FIEMAP_EXTENT_SHARED
 # define FIEMAP_EXTENT_SHARED	0x00002000
@@ -32,13 +33,16 @@
 int main(int argc, char ** argv)
 {
 	struct statfs		sb;
+	struct stat		st;
 	struct fiemap		*fie;
 	struct fiemap_extent	*fe;
 	int			fd;
 	int			ret;
 	int			sunit = 0;	/* in blocks */
+	int			fsize;
 	char			*filename;
 	unsigned long long	block;
+	unsigned long long	offset = 0;
 
         if (argc < 3) {
                 printf("Usage: %s <filename> <sunit in blocks>\n", argv[0]);
@@ -61,13 +65,25 @@ int main(int argc, char ** argv)
 		return 1;
 	}
 
+	/* Read file size */
+	ret = fstat(fd, &st);
+	if (ret) {
+		perror(filename);
+		close(fd);
+		return 1;
+	}
+	fsize = st.st_size;
+
 	fie = calloc(1, sizeof(struct fiemap) + sizeof(struct fiemap_extent));
 	if (!fie) {
 		close(fd);
 		perror("malloc");
 		return 1;
 	}
-	fie->fm_length = 1;
+
+next_extent:
+	fie->fm_start = offset;
+	fie->fm_length = fsize - offset;
 	fie->fm_flags = FIEMAP_FLAG_SYNC;
 	fie->fm_extent_count = 1;
 
@@ -86,6 +102,7 @@ int main(int argc, char ** argv)
 			return 1;
 		}
 		block = bmap;
+		offset += fsize;
 		goto check;
 	}
 
@@ -105,11 +122,14 @@ int main(int argc, char ** argv)
 	}
 
 	block = fie->fm_extents[0].fe_physical / sb.f_bsize;
+	offset += fie->fm_extents[0].fe_length;
 check:
 	if (block % sunit) {
-		printf("%s: Start block %llu not multiple of sunit %u\n",
-			filename, block, sunit);
+		printf("%s: Start block %llu (offset %llu) not multiple of sunit %u\n",
+			filename, block, offset, sunit);
 		return 1;
+	} else if (offset < fsize) {
+		goto next_extent;
 	} else
 		printf("%s: well-aligned\n", filename);
 	free(fie);
-- 
2.43.0

