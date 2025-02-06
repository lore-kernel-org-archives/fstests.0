Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194B1DFDA2
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876920; cv=none; b=nOVHUv3JdOnUmDqYVxYVozGi/sb+yyBHTuvR83VoydSxdzqwkt8USjVyvXROpeS3UIoPFN+QEcEuRXEeulHWEVnSiDYXEGpwJw5F8EkPt+vhWaBHod6b/7Lst7wZWgc8xcwUFpSDt4VCpx8r3j7AV2xw8qkTkrpQg3sR/nDLQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876920; c=relaxed/simple;
	bh=TW7H/K0yTxj3uSLhwEymo0Hu9PfeuSVIsg/MNPO7leY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfKL+qc4407mnYtiBJx7FagW6lEqjYre0pPCGwTs0xhp06GQck1IJN6dkreOY7FjkXNn2BfWzJ8ghPkB/L0CUUFU8f8X40CvAoE6fWSrm+uM/nrWYRQUbiG4H1jHeQgg0zYcEkGlCg9VfTSyYKbbRNjrqlVpHSTqCdZ3NdKWj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ngjp447l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngjp447l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbBmy7pg6XqoKn7LEhb8ZeCHLebEcwdi76wy5EF5IJI=;
	b=Ngjp447lEsAyEZQbYZU09KEEWWrLfTIFCZkfo0Zpa7S/P+4aa9hNMoVklzCKB/oZHJboeV
	y20lL54xN/1g4zpY8gLh7hr+wlNTX5Dq/fGVvCkyo1ySSrp9nqNueezhIyZEkR6HqIYCpm
	NF4JV5mMNczWwrek3WxHEPFJPD5diR8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dXpmlkt8MoO1L1rm6NHu3Q-1; Thu, 06 Feb 2025 16:21:55 -0500
X-MC-Unique: dXpmlkt8MoO1L1rm6NHu3Q-1
X-Mimecast-MFC-AGG-ID: dXpmlkt8MoO1L1rm6NHu3Q
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844dadd9bdcso249235239f.2
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876914; x=1739481714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbBmy7pg6XqoKn7LEhb8ZeCHLebEcwdi76wy5EF5IJI=;
        b=nJVw63ldMgz3YLGRbN8T895lIlS3xqG0vMg6XxUr72fST4Ua0Rm7sHh6KQC0JzY6GM
         Q3tEx5uTYc06tYc3TT1Wa98dzBMQkqUF9dkEyjBlV5Q7Q5xG4HkepiTRIh+y5+zJ1qDL
         s9Kdz+RdPfZ4k29r48P1jDXUE5rKFumiGokVMOhzqB2ln2pc4sq00P0CNqTMDIg3x81Z
         L3gtPznE8kDdFMz010aABH3EN7WfwBdB2pEsy1XQyusfvGC8k6D2nEjcm8WEH+e5qDK9
         3T4Z7+UQITw7Nsqy3L9oHQ3YeF4UL1OJdmHP33YJxzD8NqM8uD9ZQyqauGYeBQDOt1GM
         +hmw==
X-Gm-Message-State: AOJu0Yz8tOcd87nxBpgT8fFr+gs3lWtw9pF7DzpnUxk8MY6rxpmIud/k
	nx7eSxXw9I/BWIcuiKDDdJ5r6lopKqirQ3y9dvoD88wda9CT1jBJ7GGv+KJuemjjdpK6LKZV+Ym
	4wZSsiPOHZpVqfUuTx6I2PKGa+p3chWu0fNqk/SHZRYCGa5n1VBwh8VGByTrsCYvgFBFISe0u9m
	EcyHLUUJPyfiDmXliZNBJE/0WovowotJO+JWbB27AA
X-Gm-Gg: ASbGncvjQ9BXtPWaA7uzC1WD52voGseetPsEehZxIAJ26i+/kAZjQhikfalrejnjanA
	mqmF90tyvCT70EusteJGKYjrNjlM8lcPwRGUT70kwBjmCbgs6LnMCKciymWbq6u4LClhCCbCgGy
	oFKufnFq7C85yd9xaLv3XBd15KbRpAOKwdftIqkj8jxSbM0IGshxlRHBX5VTjZMNsX+Q9i502ff
	IJqLGrkAXDKNNljJ2VU3g1UtRULLWly5zt95K5mEfMrP8lGjCkgWrGLvnssKyIB+lpIs2Xl16rP
	MsTJ6ltvCsaZDIESiE2oAyyE3W/STDGDNuvmRPTOpYdlplNqnss2YQ==
X-Received: by 2002:a05:6602:6cc2:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-854fd89d459mr131276239f.5.1738876914482;
        Thu, 06 Feb 2025 13:21:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMEy+Bzvg88QKSY9fxDsWkCpizPLjvAT9hnWO9Q9ZIDyckms9WdPNc+rJ2aqAv+q8XJEwwUw==
X-Received: by 2002:a05:6602:6cc2:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-854fd89d459mr131273539f.5.1738876914075;
        Thu, 06 Feb 2025 13:21:54 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:53 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 7/7] lib: remove random.c
Date: Thu,  6 Feb 2025 15:20:02 -0600
Message-ID: <20250206212145.7732-8-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250206212145.7732-1-sandeen@redhat.com>
References: <20250206212145.7732-1-sandeen@redhat.com>
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

