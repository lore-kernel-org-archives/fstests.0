Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74A1DFD84
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876916; cv=none; b=XHxoUlaHCao0q/+sO6m7J1xGYkBYM4UOrWeHjUScuOW5FS3UXt7o7vLEwgnoJpHg5x5Stobpm7ewpA/qtV1nX2+8rKnGGZZHTYlHPwrHjKcf+VAL2t4gtO0SsBaVqAlo0YNUorre6LF/P40AXARmLKXPS6gQG5gs7z9g9x2tmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876916; c=relaxed/simple;
	bh=z9lGMSHQ78g772E8GogNFFZQYFBCIgIevaF/yZDEHWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU2jC0Ymz+UltKEKdWtDS1uwBIlky6L2w3+0t/fhch818DWcllGU+9NHU5M3VRsV56ZmQNsKsXzkC8vI7lMfN0F4jxUBW+gl4meD6sRocPd5wtQlp3esjzrY/9ruS7doxAcFSoLAewM5brZbKPzPqI61TQXOMM1lG4twi4HlRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEdJg0VX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEdJg0VX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzSGFhL31AUY779ljL+xTCHmICNVaLEkmDk5MRhfzaw=;
	b=PEdJg0VXcDAsaqLefB2Nhmz+oAYa5RqHq4ytlm1psUf2RoGwwxgu4LudTEEaNePNM28YSP
	PLb4wPCbf2xnwasx0Bl54kAwmMxdYyk5wK0WINlZNJd0/+DoyuIbC7B09hejwnpxMaHZmI
	xOsuHUyPH7NYkT+zFzgk0U0xB8zJNUo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-9gR8U1CqPiWLzb0eF6m-oA-1; Thu, 06 Feb 2025 16:21:52 -0500
X-MC-Unique: 9gR8U1CqPiWLzb0eF6m-oA-1
X-Mimecast-MFC-AGG-ID: 9gR8U1CqPiWLzb0eF6m-oA
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo9976025ab.0
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876912; x=1739481712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzSGFhL31AUY779ljL+xTCHmICNVaLEkmDk5MRhfzaw=;
        b=hswNbDvbfdehcuOB1PIzx2G648NGO19vdYyxdd9lkpRUuOdtjlF+XF7dkDXGwpS592
         K9QeAPR7dgaAB/uM0xED7SlsoGoziPK6umJn7W/dUJW9NpCnOoc/2pbqmxnjMBTMgjyF
         VxU7vv7uuK7Ciq2HkUdnCKwdX2/yahppZMS4JcL+QKtSBA+IG/T3Z0/wltOadGE0psmc
         IYauwUDG1lJwXnBzjMLrvrIPqSqJkfxG2EI93FWGbxMiAGfKSjIrGuCd8w65cO1pT1se
         1+ZtP9E2qTjT0RMnSdywp9T0i8fVflrmho2ogZLLt+L72WRsDYAEVNDFk6zX+rslfNt7
         SZ6Q==
X-Gm-Message-State: AOJu0YwLggE+ouq5HbmTICySanGpEKE4zHqEIA2jQ+8idjiGscsrkjzh
	sb5EHScFl22Svj57MokcoaEG9df5XSnhcPYkjxbLzfZL9SoBIhUKUs6chOqL748Vrw93Bc/7G3Q
	LQ3XntvyWkFJHLN2OGFQ2N2HXzRxVJ9VtmBTAazEXsuYG9U7QbW6Ym60XwWWbWmJHxtMM5sY0B9
	gtkjcaiC8nlv+8SwNtXVfzeqJBPoNPLQFzp34caF0i
X-Gm-Gg: ASbGnctDGwKvsX/0ZACMz0fJfC00CKy4uEZQ88EwDJU0KgTP9Gv9i1Rjf0pAKQr/K7l
	ViJ5owgc4bXEPdKdVYv8ZbAPhb0MtuZpXBj8pOIOEKk0sf0jXJRYBpxZAmkvjRSIrCV+pN7M/xi
	B8wULtRo6qVMq5D0HCG5MVlb8U5Pk7LepkV7O6skoz3QoVfDaqyUowCtyLouexWgZMqxV9xz222
	jgzUq5/m3yAhNGKlnR/0iim5ho30FNtMKLcBo1T62KcNdLv7r4COflN6RqhP8iOz0ddlwLjmYGL
	eSZ9jgVBL96L+ZLB/DAsw1woVImTdC9KSRCwIsCfwm0ZAtwffAQvGg==
X-Received: by 2002:a05:6e02:1fe3:b0:3cf:c7d3:e4b with SMTP id e9e14a558f8ab-3d13df17868mr5671545ab.21.1738876911860;
        Thu, 06 Feb 2025 13:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs/ybREdbhzX3Edy0EKkVRpAjC6a5s8cCJfmGcbm7HrjdGMLCAbUO4moxHUkTFnpco62wIlQ==
X-Received: by 2002:a05:6e02:1fe3:b0:3cf:c7d3:e4b with SMTP id e9e14a558f8ab-3d13df17868mr5671335ab.21.1738876911345;
        Thu, 06 Feb 2025 13:21:51 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:51 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 4/7] lib: fix empty arg function prototypes
Date: Thu,  6 Feb 2025 15:19:59 -0600
Message-ID: <20250206212145.7732-5-sandeen@redhat.com>
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

Several function prototypes used () when in fact they take
arguments. Fix those to make sparse happy.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
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
index 025ebac0..d02f898a 100644
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
index 3c23bf4d..19192b38 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -75,7 +75,7 @@
 
 
 #ifndef linux
-static void lio_async_signal_handler();
+static void lio_async_signal_handler(int sig);
 #endif
 
 /*
diff --git a/lib/write_log.c b/lib/write_log.c
index c82cc1f4..e04fed4b 100644
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

