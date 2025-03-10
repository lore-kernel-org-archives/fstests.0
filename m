Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7102356AB
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631406; cv=none; b=Kco7Ujr9uMG+0rsDetm5cofT22ykVG7wRsvSx8ZY9HcPfl7XpdgoAHPf9NkogSG2KDqgG7wcdb+OGRUH9Ykdl+Fxbiy4efp08QdK5cdldgUfPaJJ5QqBpCQNBa8JHVHZ+OEyVoJJkpQmjYPEyZLUbSCypLJVuLl2IKcke0xFB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631406; c=relaxed/simple;
	bh=0t9BCgW7QPQlncTRz5pkKuwmjAjcun4gJbJwI+1/oGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL78QzqIPPgJnXszcoE4cwnQzChFD00pmbyiHCK0LVd7LSD/+pIifoLDqFI8dbDSq7b4heUmMKR4gGMGIQ/dpd0HLjMAkzAVHO8ENwOo3XG/czBXTPF4XO/IQadFUZDoFZDejVYdJ3bPUtrjn1HfZdFONmm4jBuba0yuKzWIBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P24MmAbz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P24MmAbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZYxbXAxz4FnZhUraCDTh0jfDoW7Ipx7CtPh87NNppI=;
	b=P24MmAbz177kOMHsGmflr+vYuPs9FJUj3Ge+tkoRPHDfr84zxHUk7upQB4xSpIdNQg0jCG
	TPMW1DrhFJurc+VELBSM/FflER/h2F1AFg+XWNqKMkIrxEgiiWsJ3FMZTWwaPKenUSgcTc
	LHkEuDcRP4lQlMNyoKhDmTYa0RFFb24=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-MUIr3eQDPB6Rxb1Xjm5w4w-1; Mon, 10 Mar 2025 14:30:02 -0400
X-MC-Unique: MUIr3eQDPB6Rxb1Xjm5w4w-1
X-Mimecast-MFC-AGG-ID: MUIr3eQDPB6Rxb1Xjm5w4w_1741631401
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b37197e83so164190439f.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631401; x=1742236201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZYxbXAxz4FnZhUraCDTh0jfDoW7Ipx7CtPh87NNppI=;
        b=J9Ei4/ph3v0j0GEiVee1lRPshyCQPjanJCC+Q0oRumQtUsU1B4HUhbCo+rxTrbyBjm
         9oMkZPGQmZlaCFMD0si4navjuumZISnoOMW+kN012wx+ehjDreXpOvluObyIsTsxShdk
         97fxkXoM7cYb38CtDG8C9YZxQQTtQ1AjZGkh0g9NrvXSO+a85LD8FUtlnby+6m758nqr
         rCyMYkeb/PrygdgS3nHOq3LsH7sqzISUoRMjrBzq/MgKMHQPKGAVq59A7hH7hA6Nijc0
         3TAOmx2HpN+qiSg61v+y2B0LDbk/CZraodY+C8eoTCCjDu4uazGM0vbT6eWCLEgZfOYM
         W04w==
X-Gm-Message-State: AOJu0YwOpgEVDCD7EhtWzTawpZFaMK2uoIDkpSjHy9qluC+oLEurZwLb
	7sXcrl3iuTSIpl5Q0gkXRq/Hb4gOHSo0FwTJmdpD4mS0YB9uW90UNh3aXI+l1UL/RKtsoPspKwq
	ea4DSsiscLSIDOjrlgw+v9Vwk3lBpTIARK1m6OMt+xW/y5aFM4euTh+L51sOxn1OO6AqnRS+rAV
	sgP7A/v7KGlyHww4xmX1al94OjLlhI7zvS3sSub9hA
X-Gm-Gg: ASbGncsny7WW72TxVR9WktQxdYYq7cpduR33sLaaeEEOKrhovHu1s+NdTnzZ0YCjv/X
	ICkWyfOa/DmBPfJWto3cJeVV/RyuPufvapg56LQu6mrVrbVq6+BRocjzaxw/e5hIQWMO6rriNyY
	q98uD4qrI3fYyxUySN09h8vjTvA3Av4HR2kNRBtOLV1tKzpGSIXc+ygZ94QfeC2Hn1Rob3SYBiC
	xf8uXv3//FDAQ/IoqSxAQGbXYwCiNpLYmrbnn3xNWu3TOD52JG5IhDxYXSx5sx1eNV+1X3gfyJO
	tfGQMHWy2ylTghPeB5+RCADADo2zgBs=
X-Received: by 2002:a05:6602:6a8a:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-85b4afc1399mr633957639f.5.1741631401335;
        Mon, 10 Mar 2025 11:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF315xHqr/2TzlOLv2q9RJN26/2xg2p2aaZqB3teqvXqtKfchY9hLoULhA3ca7yFlGesQ0n2w==
X-Received: by 2002:a05:6602:6a8a:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-85b4afc1399mr633953839f.5.1741631400964;
        Mon, 10 Mar 2025 11:30:00 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:30:00 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/7] lib: fix empty arg function prototypes
Date: Mon, 10 Mar 2025 13:29:06 -0500
Message-ID: <20250310182954.1396724-5-sandeen@redhat.com>
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

Several function prototypes used () when in fact they take
arguments. Fix those to make sparse happy.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/random_range.h | 2 +-
 include/write_log.h    | 2 +-
 lib/random_range.c     | 6 ++----
 lib/string_to_tokens.c | 1 -
 lib/tlibio.c           | 2 +-
 lib/write_log.c        | 2 +-
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/random_range.h b/include/random_range.h
index b47aef9e..c352c5a9 100644
--- a/include/random_range.h
+++ b/include/random_range.h
@@ -6,7 +6,7 @@
 #ifndef _RANDOM_RANGE_H_
 #define _RANDOM_RANGE_H_
 
-int       parse_ranges     ( char *, int, int, int, int (*)(), char **, char ** );
+int       parse_ranges     ( char *, int, int, int, int (*)(char *, int *), char **, char ** );
 int       range_min        ( char *, int );
 int       range_max        ( char *, int );
 int       range_mult       ( char *, int );
diff --git a/include/write_log.h b/include/write_log.h
index 6b088416..a7ad2ee4 100644
--- a/include/write_log.h
+++ b/include/write_log.h
@@ -125,7 +125,7 @@ extern int	wlog_close(struct wlog_file *wfile);
 extern int	wlog_record_write(struct wlog_file *wfile,
 				  struct wlog_rec *wrec, long offset);
 extern int	wlog_scan_backward(struct wlog_file *wfile, int nrecs,
-				   int (*func)(struct wlog_rec *rec),
+				   int (*func)(struct wlog_rec *rec, long data),
 				   long data);
 #else
 int	wlog_open();
diff --git a/lib/random_range.c b/lib/random_range.c
index 680bf71c..0b38eb7f 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -69,7 +69,7 @@ struct range {
  * parse_range() returns -1 on error, or the number of ranges parsed.
  */
 
-static int       str_to_int();
+static int       str_to_int(char *str, int *ip);
 static long long divider(long long, long long, long long, long long);
 
 int
@@ -78,7 +78,7 @@ parse_ranges(
 	int defmin,
 	int defmax,
 	int defmult,
-	int (*parse_func)(),
+	int (*parse_func)(char *str, int *ip),
 	char **rangeptr,
 	char **errptr)
 {
@@ -570,8 +570,6 @@ printf("   diff = %lld, half = %lld,   med = %lld\n", diff, half, med);
 void
 random_range_seed(long s)
 {
-    extern void srand48();
-
     srand48(s);
 }
 
diff --git a/lib/string_to_tokens.c b/lib/string_to_tokens.c
index 08df9fcc..8383ed4c 100644
--- a/lib/string_to_tokens.c
+++ b/lib/string_to_tokens.c
@@ -54,7 +54,6 @@ int
 string_to_tokens(char *arg_string, char *arg_array[], int array_size, char *separator)
 {
    int num_toks = 0;  /* number of tokens found */
-   char *strtok();
 	
    if ( arg_array == NULL || array_size <= 1 || separator == NULL )
 	return -1;
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 17ab34ee..75f10cec 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -75,7 +75,7 @@
 
 
 #ifndef __linux__
-static void lio_async_signal_handler();
+static void lio_async_signal_handler(int sig);
 #endif
 
 /*
diff --git a/lib/write_log.c b/lib/write_log.c
index 32567a1c..eb3fa2b3 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -217,7 +217,7 @@ int
 wlog_scan_backward(
 	struct wlog_file	*wfile,
 	int 			nrecs,
-	int 			(*func)(),
+	int 			(*func)(struct wlog_rec *, long data),
 	long			data)
 {
 	int			fd, leftover, nbytes, offset, recnum, reclen;
-- 
2.48.0

