Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1A13B5BE
	for <fstests@vger.kernel.org>; Mon, 25 Mar 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389208; cv=none; b=C58LHxsBl/1KJy3MrMLAFPedq9kulSpcQWGdd65qkbJYV+mbvtSNWVD865wqGC48ZiTXcb41LyEPvMcEUkye8+05+5UWek8r8kuiwdy7SH4y5Xw1PDMYyXe2BAHZtH+LMkPtp7SdXgpnJfJ4DE45JQDiuKsuEZJx80Jl5UGIm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389208; c=relaxed/simple;
	bh=fApQh+id8isTcKopewm7maXcm+sPWkJ8+t5uySRhP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtHqm/NI2Bo+Afl0Uw2iJzpa10yEBBQPiFL1iy992r9moxH2Fw0pkTTh5rLMEAv/ra1F409f3cSJCH7anzgLK1C60lw4aE3H66xpscgp9Ziljo6DzQExiQsumjxRuP+tA+xQuwr66K90IzWdw+ZcvT9B6qRzbTIOuVYtcb+L9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLeykw1b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLeykw1b"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so2985394b3a.2
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389206; x=1711994006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOPWuqKnERY7yQtIfn7iVIOMl/7WW/izTcReguLeUDA=;
        b=aLeykw1bRksC4uhkUZ3uD49P0dBNsPrnPVq20RcMtPQnA12tBGIE2/ag6+c9wwDqTR
         QhWJlLbpDt6AUO4jggSip7rvKqm6vFyYKg0W3Ii7iCUez8FTFrNUNShCtQDcCQevQkmp
         WOK6lSebyXdvM5ESE18vl3A7v0OpNbBPPs+ujj7AJIMWvo7lGyTOPf8hLWLXeYROwjzT
         ZxFNfjw5Qd2gi2P5vxkrvRMW33ap4T9ChdLQjQddhRCWoPhgpINcJJDgYLPsC+U2LBz8
         9ZYWVl/0LmEhap28dXWcLFiT65EpykbokUdPzbMiJVJZlcpnoVzGlgt10BXXqnRxQyEU
         BX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389206; x=1711994006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOPWuqKnERY7yQtIfn7iVIOMl/7WW/izTcReguLeUDA=;
        b=oj+KF3OqXFSjMmCOsDmlXrFU4hoNZm9ewP+D9snVfvoA8Vli4LDEe+Km9+RDkMfN37
         asRiN8znrEorGBjjtbwupt5pFh/+bxbvnJOj11czEmORNJJxvma/lM7swQgThBC0WEDO
         YA60JDhirZ1EGTUMhGdLeu27nJ80Llg33kFtOf03Nfl0ulDkc7vKu9oV+itjVMdJvYRN
         QM7hC2+vh2JNN8U2Y/eEHvGVWRVpMmRfridRkYxjJxn7m4v8L/Y0uCuVf2v5Z/SrDlvN
         uwCxt24Wgy4uoseV3rfwhHrljdfseqFZUFjU/SgiHsxLCKntQa0a7jyDDcwI4IILeI/J
         n93w==
X-Gm-Message-State: AOJu0YzrA82fXPZoYg03s7CoBGTeGgc6ShqCiy+Fi7Ey/ncZTehchTfo
	5ArMWJ56lX3JgtYkN39B91I+9ZaUSY5b6YP+lkFnhiRTTGhuk2FLQy25iv5Q
X-Google-Smtp-Source: AGHT+IFoUBOWeRNl2ITGr2V983nxCdu2RDOt+I0s9em2pFZwDXrgydhyVeFYUV18WAkeMHNKACTPXQ==
X-Received: by 2002:a05:6a00:c90:b0:6ea:699f:8dbb with SMTP id a16-20020a056a000c9000b006ea699f8dbbmr8133105pfv.21.1711389206098;
        Mon, 25 Mar 2024 10:53:26 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::5eba])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79e45000000b006e641fee598sm4513867pfq.141.2024.03.25.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:53:25 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: fstests@vger.kernel.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 2/2] Add missing STATX_ATTR_* defines from musl sys/stat.h
Date: Mon, 25 Mar 2024 10:53:23 -0700
Message-ID: <20240325175323.3450750-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325175323.3450750-1-raj.khem@gmail.com>
References: <20240325175323.3450750-1-raj.khem@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These defines are not provided by sys/stat.h on musl but are
in glibc's sys/stat.h, therefore to compile the tests on musl
based systems add the missing defines from linux/stat.h
if they are not provided

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 src/statx.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/statx.h b/src/statx.h
index 3f239d79..12599f5b 100644
--- a/src/statx.h
+++ b/src/statx.h
@@ -12,6 +12,18 @@
 #define AT_STATX_DONT_SYNC      0x4000  /* - Don't sync attributes with the server */
 #endif
 
+#ifndef STATX_ATTR_COMPRESSED
+#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
+#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
+#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
+#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
+#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
+#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
+#define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
+#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
+#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#endif
+
 #ifndef AT_NO_AUTOMOUNT
 #define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
 #endif
-- 
2.44.0

