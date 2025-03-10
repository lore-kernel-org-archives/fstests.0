Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582B235362
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631404; cv=none; b=Zhs9UXnYWWENTpaLeZTOPBxYKkivMOYYtdgoOR8k/EHHXHiGyk21PGgGCjMs4JXTsK8PgKzZYNTHYtHA47WuwvtkEtC8QH1HDCB2rXNS/1WQayRe+6OPsJATAwsxgkvlOi7Einsw7H6Zk6R4c49CnfPdKM6dzrvfHmY0fUFtnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631404; c=relaxed/simple;
	bh=WS4EwsfvJ826l9lDnqXQvWZtH5N0//w9etJh3qHGl1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlKGtUsaoowxAhz2QPG3BvPO8TPvVTqDIf3Q9DUIDajJZE2xBMlqLDUbbAHG9LmXiPesP8hXvBhMgF83RjtAlTIL1c6RRnvZibJg6zFXV/J/4kJ/mHmOvhA6Tmr5wBXSK1OrPP3qUL56P8MyczqxXij5yUeczsTY60NlvI0Q7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTUK6K/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTUK6K/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741631401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkjA4WUBCvVFZmIEojLDsEz1KcGqMNnupoSBqInwxNU=;
	b=fTUK6K/Q+Xg0/0RNlN6jV96l30rhoRrvyPTslBaTzcOEnbKmZv+EEJbCRkFEJDk4RntLbG
	3mBt+uzOupcz1nO5O6K3iSb7LPMaKe1ThnqHCn25JPfC/pYzH3p4o0z+Tzy7igeWcJTPrd
	JILjyEThofqZ+0Ax9FU5GEXBK/IDC7I=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-q0Z42G-vNf6hfE823P4Zlg-1; Mon, 10 Mar 2025 14:30:00 -0400
X-MC-Unique: q0Z42G-vNf6hfE823P4Zlg-1
X-Mimecast-MFC-AGG-ID: q0Z42G-vNf6hfE823P4Zlg_1741631399
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso42535025ab.1
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631399; x=1742236199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkjA4WUBCvVFZmIEojLDsEz1KcGqMNnupoSBqInwxNU=;
        b=njHm6SWK8XEe8bUhXAEs8zLPTsNSy1HgEDNE4+zfi62XOHyR7tFT6ZaRb149jMMFUT
         pfOdigRkhkOEQaQsc9SYPyrl3UzK7PpN0vYr1InR7mrcTpCm3hcFS3DILZ/3wz9TZXwG
         SqQ7QiTksqaJ/WMgCCX/WAbEcPRhykcR+ehCZ2EVQ2C2l+uPblfCwCHqJ5k69hMC/r1b
         Z6NqUKrmp+u3DcDitPXMsEL9q30r4hprpPTf6llVBiXktXWedOjEB9ectji9fkgpy2tm
         2TO5Bx9B3T8FYdf+DgV993cZQYCnY/3yrYAmwV0UML8o3WqgmQSbJvplPb15CqKyRkx8
         hPxg==
X-Gm-Message-State: AOJu0Yw3rwafvhRx3YsPVUbYRx/1Vs6eN3YEgR6+u77iXcRDL12shlsv
	E5vsNaDojlXoGv9Mk9upejsDbP7H4dApcY8EPAiuPw40SzlZqhHPXEnao0sW298QO7ifrT8cIdR
	+lmkcKwPOoigyWKorAkoxKMolvLJHw3a2JbcGlCvLXIRUdPAEZA3NBHEhxDDMBWmYEoZXPyEgko
	G08SvDcn15hSZhQJdtmtGUDWy+RRKfZkbanOubAuBy
X-Gm-Gg: ASbGncsWsfDO8oYwx7PxXFikiFE4XDM16ApS2+LEwzaBSO2x80AOWiKGcBC/r2FfJP/
	2d+Q42vFhXBbplo/jxyeW/ARBzTrT6/83Iz8SEoaGL5pjblUZG+2tJ5gcnm5+Sa6xomNYgTxakP
	lv/2v8G8JqExKalx4nH78j6hc5Q6DD0yoLtxi9sGtQs8DKjuZZ/Ybqel4VtWOD0kI77vPRmCDjX
	QFR5lv1orrFm/YswJ1aNZ8BEgI7oqS+fb3pvw5dcRaWQDngJOei3TNAN6eKsSoRvY/ncSFw8Fxt
	2pfZ0yOe6VCrrOdVkrq27XYLfLF/MVg=
X-Received: by 2002:a05:6e02:ecd:b0:3d4:2a80:74fb with SMTP id e9e14a558f8ab-3d46915efcemr5134685ab.3.1741631399340;
        Mon, 10 Mar 2025 11:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHliH1cGCLJ8JRAt2P9BNK6iQMPs87HW08aavU6UJxJR8utRmkIbi99MWddUNoZkwlZS0RGvQ==
X-Received: by 2002:a05:6e02:ecd:b0:3d4:2a80:74fb with SMTP id e9e14a558f8ab-3d46915efcemr5134475ab.3.1741631398917;
        Mon, 10 Mar 2025 11:29:58 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f222ee2efdsm1587512173.13.2025.03.10.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:29:58 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 2/7] treewide: check for #ifdef __linux__ not linux
Date: Mon, 10 Mar 2025 13:29:04 -0500
Message-ID: <20250310182954.1396724-3-sandeen@redhat.com>
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

There are several #ifdef linux guards in the code, which caused
a few sparse warnings, because while gcc defines both linux
and __linux__, sparse defines only __linux__. So, switch our
guards to check for __linux__ which hch says "is the preferred
version these days."

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/tlibio.h    |  6 +++---
 include/write_log.h |  2 +-
 lib/str_to_bytes.c  |  2 +-
 lib/tlibio.c        | 12 ++++++------
 lib/write_log.c     |  2 +-
 ltp/doio.c          |  8 ++++----
 ltp/iogen.c         |  6 +++---
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/tlibio.h b/include/tlibio.h
index 12649cf5..4f462ff1 100644
--- a/include/tlibio.h
+++ b/include/tlibio.h
@@ -11,7 +11,7 @@
 #define LIO_IO_SYNCV            00020   /* single-buffer readv/writev */
 #define LIO_IO_SYNCP            00040   /* pread/pwrite */
 
-#ifdef linux
+#ifdef __linux__
 #define LIO_IO_TYPES            00021   /* all io types */
 #endif /* linux */
 
@@ -21,14 +21,14 @@
 #define LIO_WAIT_SIGPAUSE       00100000 /* call pause */
 #define LIO_WAIT_SIGACTIVE      00200000 /* spin waiting for signal */
 
-#ifdef linux
+#ifdef __linux__
 #define LIO_WAIT_TYPES          00300000 /* all wait types, except nowait */
 #endif /* linux */
 
 /* meta wait io  */
 /*  00  000 0000 */
 
-#ifdef linux
+#ifdef __linux__
 /* all signal wait types */
 #define LIO_WAIT_SIGTYPES	(LIO_WAIT_SIGPAUSE)
 #endif /* linux */
diff --git a/include/write_log.h b/include/write_log.h
index 025ebac0..6b088416 100644
--- a/include/write_log.h
+++ b/include/write_log.h
@@ -79,7 +79,7 @@ struct wlog_rec {
  */
 
 struct wlog_rec_disk {
-#ifdef linux
+#ifdef __linux__
     uint    w_offset    : 32;	    /* file offset  	    	    */
     uint    w_extra0    : 32;       /* EXTRA BITS IN WORD 0         */
 #endif
diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
index 2f6b2b92..89bc7d31 100644
--- a/lib/str_to_bytes.c
+++ b/lib/str_to_bytes.c
@@ -31,7 +31,7 @@
  *
  ****************************************************************************/
 
-#if linux
+#ifdef __linux__
 #define B_MULT	DEV_BSIZE	/* block size */
 #endif
 
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 5b810059..ae936f41 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -74,7 +74,7 @@
 #endif
 
 
-#ifndef linux
+#ifndef __linux__
 static void lio_async_signal_handler();
 #endif
 
@@ -351,7 +351,7 @@ lio_help2(char *prefix)
     return;
 }
 
-#ifndef linux
+#ifndef __linux__
 /***********************************************************************
  * This is an internal signal handler.
  * If the handler is called, it will increment the Received_signal
@@ -453,7 +453,7 @@ char **errmsg;	/* char pointer that will be updated to point to err message */
 long wrd;	/* to allow future features, use zero for now */
 {
     int ret = 0;	/* syscall return or used to get random method */
-#ifndef linux
+#ifndef __linux__
     int omethod = method;
     int listio_cmd;		/* Holds the listio/lio_listio cmd */
 #endif
@@ -650,7 +650,7 @@ char **errmsg;	/* char pointer that will be updated to point to err message */
 long wrd;	/* to allow future features, use zero for now */
 {
     int ret = 0;	/* syscall return or used to get random method */
-#ifndef linux
+#ifndef __linux__
     int listio_cmd;		/* Holds the listio/lio_listio cmd */
     int omethod = method;
 #endif
@@ -797,7 +797,7 @@ long wrd;	/* to allow future features, use zero for now */
 }	/* end of lio_read_buffer */
 
 
-#ifndef linux
+#ifndef __linux__
 /***********************************************************************
  * This function will check that async io was successful.
  * It can also be used to check sync listio since it uses the
@@ -998,7 +998,7 @@ lio_wait4asyncio(int method, int fd, aiocb_t *aiocbp)
 
 } /* end of lio_wait4asyncio */
 
-#endif /* ifndef linux */
+#endif /* ifndef __linux__ */
 
 #if UNIT_TEST
 /***********************************************************************
diff --git a/lib/write_log.c b/lib/write_log.c
index cdc72593..7c58a95f 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -49,7 +49,7 @@
 #include "write_log.h"
 
 #ifndef BSIZE
-#ifdef linux
+#ifdef __linux__
 #define BSIZE DEV_BSIZE
 #else
 #define BSIZE BBSIZE
diff --git a/ltp/doio.c b/ltp/doio.c
index fd64df0f..ba080a0b 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -222,7 +222,7 @@ int     parse_cmdline( int, char **, char * );
 int     lock_file_region( char *, int, int, int, int );
 struct	fd_cache *alloc_fdcache(char *, int);
 int     aio_register( int, int, int );
-#ifndef linux
+#ifndef __linux__
 int aio_wait(int);
 #endif
 
@@ -1990,7 +1990,7 @@ do_rw(req)
 		/*
 		 * If the syscall was async, wait for I/O to complete
 		 */
-#ifndef linux
+#ifndef __linux__
 		if(sy->sy_flags & SY_ASYNC) {
 			for(i=0; i < nents; i++) {
 				aio_wait(s->aioid[i]);
@@ -2425,7 +2425,7 @@ int nbytes;
 	static int	mturn = 0;	/* which memory type to use */
 	struct memalloc	*M;
 	char		filename[255];
-#ifdef linux
+#ifdef __linux__
 	struct shmid_ds shm_ds;
 	bzero( &shm_ds, sizeof(struct shmid_ds) );
 #endif
@@ -2997,7 +2997,7 @@ int	aio_id;
 	return 0;
 }
 
-#ifndef linux
+#ifndef __linux__
 int
 aio_wait(aio_id)
 int	aio_id;
diff --git a/ltp/iogen.c b/ltp/iogen.c
index 0c8b97e9..416dedbc 100644
--- a/ltp/iogen.c
+++ b/ltp/iogen.c
@@ -128,7 +128,7 @@ void	startup_info(FILE *stream, int seed);
  */
 
 struct strmap	Aio_Strat_Map[] = {
-#ifndef linux
+#ifndef __linux__
 	{ "poll",	A_POLL		},
 	{ "signal",	A_SIGNAL	},
 #else
@@ -1610,7 +1610,7 @@ FILE	*stream;
 {
     usage(stream);
     fprintf(stream, "\n");
-#ifndef linux
+#ifndef __linux__
     fprintf(stream, "\t-a aio_type,...  Async io completion types to choose.  Supported types\n");
     fprintf(stream, "\t                 are:  poll, signal, suspend, and callback.\n");
     fprintf(stream, "\t                 Default is all of the above.\n");
@@ -1643,7 +1643,7 @@ FILE	*stream;
     fprintf(stream, "\t-q               Quiet mode.  Normally iogen spits out info\n");
     fprintf(stream, "\t                 about test files, options, etc. before starting.\n");
     fprintf(stream, "\t-s syscall,...   Syscalls to do.  Supported syscalls are\n");
-#ifdef linux
+#ifdef __linux__
     fprintf(stream, "\t                 read, write, pread, pwrite, readv, writev,\n");
     fprintf(stream, "\t                 mmread, mmwrite, fsync2, fdatasync,\n");
     fprintf(stream, "\t                 Default is 'read,write,readv,writev,mmread,mmwrite'.\n");
-- 
2.48.0

