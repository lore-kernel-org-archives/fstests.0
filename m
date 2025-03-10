Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CD155393
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631410; cv=none; b=mNxIgnmwOiGmekzF2+sj+9x4TFmZWILUoblyIeSu/X+1zdDWxX4jt2nBVzV0bqc/PNiSE54DTm198UAdujr1IT08gUxc8+TFsldqQnniZLlHbC/ERqwfsjoNeHDR1i3yS0O54lHkJyJelOYfj+pOCwXjfD5Gq6khfhYxUmXS4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631410; c=relaxed/simple;
	bh=g9AMFS2pLaNP2/8ZfsPeL96KOZZ1HNSrFxF4UmyQbWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYeQK9ymg9FEPKwHQf0zQOmh2Cio6MyJUZUOVQioJGlSxWrIB/E7khsSUrrPVSQQGEOs4/smHQmoLmi8u4WzyhtkboOFnuhv4b7EIwBfFlfbxebblmfudfJ9y7rkt1oBcU8h9QntR+vOQWOalqDbFqC0XWELNQmirWwBc9MzKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsVQ5b5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsVQ5b5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/BbupdrNsXT+97/gNmiatqpkKXDA1TzNydLm0ut1UM=;
	b=SsVQ5b5//mG9w4QBHdch9Vl/lRZ/PcRm2nDn5+aLvdWzgz4z751/0Wd4G69Mewp29QfOiu
	w8U43nYi5Ka82x02ZW36YEUhQLTtiDU2LwC2oObxLw57W0c2cv2vfUeTbCP4c6g8ZKmTNu
	iAyFYhsmPSP0SLEwUUISAoPAD3rn/i0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-h0FmcPhHO0mrDjEikMI3Ew-1; Mon, 10 Mar 2025 14:30:06 -0400
X-MC-Unique: h0FmcPhHO0mrDjEikMI3Ew-1
X-Mimecast-MFC-AGG-ID: h0FmcPhHO0mrDjEikMI3Ew_1741631405
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8555eff9e0dso366295539f.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631405; x=1742236205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/BbupdrNsXT+97/gNmiatqpkKXDA1TzNydLm0ut1UM=;
        b=pTTSRk2peU2GUwE+6SoZBtFUp0Nabx9eHIJsTAS2+0ogizJl4Y2CbvLl/LXh+2uDf4
         eezX2VlgmEyNGxR1E6NF31i6GEmYY1HeEjEbh0OBbtWBpestVTNRAbwhrf2N+7k4cXAi
         w6R6RbwTTSDEJFmydW1XQeyy9WkuW+OyUf0+2nDH1/ZSzrI8DqK/jKiAsDGZ8Z/TKd/P
         Tcj3OruIHpc2p8aKB+px+ATQrRbU6pjKxTXD21nkHw4gZty7hDNd5VP+aQgZpkKyTY1V
         AKN8WmQNgwrVh0Nti71RSlEuGmVkCr7qqiROIvuG7khjlt1lCrOhZKVVooG9Bam9AVe/
         SjrA==
X-Gm-Message-State: AOJu0YxhOC7bE/jhh+HcKh9VeCNAJcgAE71tTZANMxDHfKzekwNyeq0z
	KEPebRyoAZu4L2z0plSg0LEoI4ZkYzoATJDIFGZ7hPKRzgC+Zn7u46bdFAsdkebz0hS0+iRxTRP
	iTSkhK9ApheHwf7FlFaXUwqdh04t13gnM57gogyNhgOykQpzvmLPBJ34vKFc3CXkz4WHI4kkdlh
	xfQIbHFde4/Tj8RDdir6PLX1SfPzSaPf1BQKt+xs23
X-Gm-Gg: ASbGncveisAcWVGP/aG2r3sNhKrPZ/l0iPWAFYh+VVFLX/iepiY5xFfobfF7XaIj7XF
	Iwg95ZBHucQh6gBK9qRQcyMG4nCgSJDDhz1PAMwhdd3Yxoa5qp0nPbr+mzaCMjhlbsls4kgt4+1
	8xlHE6J8VUd9uuCcFVZMFmGhusOuHz3LhX119AF42I8xLE0cEkUAvnOXFazXNC5fMdeRPgfLgQU
	ChYHaQzwq9tkpUMn+BZU2D8BXLV7MUqZGO6AX03/cv9S2QTlI4U3V64J6pGfT43c5BtoNKM/AOi
	XcvLwQK1EhErUJLpFa+NW42hsj4ubko=
X-Received: by 2002:a05:6602:6a94:b0:85a:e24f:2b53 with SMTP id ca18e2360f4ac-85b1cfcec5amr1684262639f.1.1741631405213;
        Mon, 10 Mar 2025 11:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY22Sv0sKUQnvx3uMpuKtabliRmvifkl/tQX5zQISLBzQuUFAIHxRk1AHRE3beMpWpX6dhAg==
X-Received: by 2002:a05:6602:6a94:b0:85a:e24f:2b53 with SMTP id ca18e2360f4ac-85b1cfcec5amr1684258839f.1.1741631404549;
        Mon, 10 Mar 2025 11:30:04 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:30:03 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] lib: remove random.c
Date: Mon, 10 Mar 2025 13:29:09 -0500
Message-ID: <20250310182954.1396724-8-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250310182954.1396724-1-sandeen@redhat.com>
References: <20250310182954.1396724-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse points out that lots of things in random.c could be static,
and upon doing so we realize that nothing in this file is used.
Which is unsurprising since these are all part of the standard
C library ... so just remove the file.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 lib/Makefile |   5 +-
 lib/random.c | 224 ---------------------------------------------------
 2 files changed, 2 insertions(+), 227 deletions(-)
 delete mode 100644 lib/random.c

diff --git a/lib/Makefile b/lib/Makefile
index 53540ca7..ce4381a2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -11,13 +11,12 @@ LT_REVISION = 0
 LT_AGE = 0
 
 #
-# Everything (except for random.c) copied directly from LTP.
+# Everything copied directly from LTP.
 # Refer to http://ltp.sourceforge.net/ for complete source.
 #
 CFILES = dataascii.c databin.c datapid.c file_lock.c forker.c \
 	pattern.c open_flags.c random_range.c string_to_tokens.c \
-	str_to_bytes.c tlibio.c write_log.c \
-	random.c
+	str_to_bytes.c tlibio.c write_log.c
 
 default: depend $(LTLIBRARY)
 
diff --git a/lib/random.c b/lib/random.c
deleted file mode 100644
index d5c81be8..00000000
--- a/lib/random.c
+++ /dev/null
@@ -1,224 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * random.c -- pseudo random number generator
- * Copyright (C) 1994  Chris Wallace (csw@bruce.cs.monash.edu.au)
- */
-
-#include <sys/types.h>
-
-/*
- * modified by dxm@sgi.com so that this file acts as a drop in replacement
- * for srandom and random.
- */
-
-/*
- *	A random number generator called as a function by
- *	random (iseed)	or	irandm (iseed)
- *	The parameter should be a pointer to a 2-element int32_t vector.
- *	The first function returns a double uniform in 0 .. 1.
- *	The second returns a int32_t integer uniform in 0 .. 2**31-1
- *	Both update iseed[] in exactly the same way.
- *	iseed[] must be a 2-element integer vector.
- *	The initial value of the second element may be anything.
- *
- *	The period of the random sequence is 2**32 * (2**32-1)
- *	The table mt[0:127] is defined by mt[i] = 69069 ** (128-i)
- */
-
-#define MASK ((int32_t) 593970775)
-/*	or in hex, 23674657	*/
-
-#define SCALE ((double) 1.0 / (1024.0 * 1024.0 * 1024.0 * 2.0))
-/*	i.e. 2 to power -31	*/
-
-static int32_t mt [128] =   {
-      902906369,
-     2030498053,
-     -473499623,
-     1640834941,
-      723406961,
-     1993558325,
-     -257162999,
-    -1627724755,
-      913952737,
-      278845029,
-     1327502073,
-    -1261253155,
-      981676113,
-    -1785280363,
-     1700077033,
-      366908557,
-    -1514479167,
-     -682799163,
-      141955545,
-     -830150595,
-      317871153,
-     1542036469,
-     -946413879,
-    -1950779155,
-      985397153,
-      626515237,
-      530871481,
-      783087261,
-    -1512358895,
-     1031357269,
-    -2007710807,
-    -1652747955,
-    -1867214463,
-      928251525,
-     1243003801,
-    -2132510467,
-     1874683889,
-     -717013323,
-      218254473,
-    -1628774995,
-    -2064896159,
-       69678053,
-      281568889,
-    -2104168611,
-     -165128239,
-     1536495125,
-      -39650967,
-      546594317,
-     -725987007,
-     1392966981,
-     1044706649,
-      687331773,
-    -2051306575,
-     1544302965,
-     -758494647,
-    -1243934099,
-      -75073759,
-      293132965,
-    -1935153095,
-      118929437,
-      807830417,
-    -1416222507,
-    -1550074071,
-      -84903219,
-     1355292929,
-     -380482555,
-    -1818444007,
-     -204797315,
-      170442609,
-    -1636797387,
-      868931593,
-     -623503571,
-     1711722209,
-      381210981,
-     -161547783,
-     -272740131,
-    -1450066095,
-     2116588437,
-     1100682473,
-      358442893,
-    -1529216831,
-     2116152005,
-     -776333095,
-     1265240893,
-     -482278607,
-     1067190005,
-      333444553,
-       86502381,
-      753481377,
-       39000101,
-     1779014585,
-      219658653,
-     -920253679,
-     2029538901,
-     1207761577,
-    -1515772851,
-     -236195711,
-      442620293,
-      423166617,
-    -1763648515,
-     -398436623,
-    -1749358155,
-     -538598519,
-     -652439379,
-      430550625,
-    -1481396507,
-     2093206905,
-    -1934691747,
-     -962631983,
-     1454463253,
-    -1877118871,
-     -291917555,
-    -1711673279,
-      201201733,
-     -474645415,
-      -96764739,
-    -1587365199,
-     1945705589,
-     1303896393,
-     1744831853,
-      381957665,
-     2135332261,
-      -55996615,
-    -1190135011,
-     1790562961,
-    -1493191723,
-      475559465,
-          69069
-		};
-
-double 
-_random (int32_t is [2])
-{
-	int32_t it, leh, nit;
-
-	it = is [0];
-	leh = is [1];
-	if (it <= 0)	
-		it = (it + it) ^ MASK;
-	else
-		it = it + it;
-	nit = it - 1;
-/*	to ensure all-ones pattern omitted    */
-	leh = leh * mt[nit & 127] + nit;
-	is [0] = it;    is [1] = leh;
-	if (leh < 0) leh = ~leh;
-	return (SCALE * ((int32_t) (leh | 1)));
-}
-
-
-
-int32_t 
-_irandm (int32_t is [2])
-{
-	int32_t it, leh, nit;
-
-	it = is [0];
-	leh = is [1];
-	if (it <= 0)	
-		it = (it + it) ^ MASK;
-	else
-		it = it + it;
-	nit = it - 1;
-/*	to ensure all-ones pattern omitted    */
-	leh = leh * mt[nit & 127] + nit;
-	is [0] = it;    is [1] = leh;
-	if (leh < 0) leh = ~leh;
-	return (leh);
-}
-
-/*
- * make this a drop in replacement for random and srandom
- *
- * XXX not thread safe I guess.
- */
-
-static int32_t saved_seed[2];
-
-long random(void)
-{
-    return _irandm(saved_seed);
-}
-
-void srandom(unsigned seed)
-{
-    saved_seed[0]=seed;
-    saved_seed[1]=0;
-    _irandm(saved_seed);
-}
-
-- 
2.48.0

