Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F11DF99C
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876917; cv=none; b=XzzrO3FqtYsPKAY/3VCVZ+I9pCcoMlMEWQq5jbmAWCRnxRVl6/qavql/l7ZWQa+ejymrUbfNWivIRsDLJJUMZioOlmlg8MMEqM/v7HJFs75Vd1Ozb3foxIR78OT8ify7Ti1u+t0WKkt8HX+H79JHfCU+7NJ/paOucF9lWRc1p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876917; c=relaxed/simple;
	bh=+6ceStr1pwa93vSTqO1+JxmhyghFa7UHh4dZyvMWuMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRFEH+COVlihVSxFLPZ/ER7Ee+7zFPP5sXhaTlX4l8x7yTDtDs0UpO7X1sAotQ6oSgQhskze50z3nm5ddcZe31akJvLHEmLdj9BfznkSq4MzmTDFTKYS9ChG4rzcD0gKgEOLE3X+sQ3EnsAdFC+wDT3dDwXt1ChIxJTA9mNqkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAit6mE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAit6mE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738876913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRZdQCp2QG2WlZHDNniYpt/U4I7+MZLg527LTl2mfgM=;
	b=gAit6mE8kgeoLM1D59xCdX13ekIy6d2A3e/K3FB5yyJ/tLzStMTeewYGxKFMlN+XasnAiu
	P3cgSHZ80vOEZB24ydh9kP30t3nNsn4dXCJdFawIQD/gghKJxpjGu0BBmsgShYlDMdBUtE
	oAKedno1sliU8LaOqYHIwuvvSktoMkM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-PGjMFrvzM7O-RjL1lRPf3A-1; Thu, 06 Feb 2025 16:21:52 -0500
X-MC-Unique: PGjMFrvzM7O-RjL1lRPf3A-1
X-Mimecast-MFC-AGG-ID: PGjMFrvzM7O-RjL1lRPf3A
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d13d1f8420so2105995ab.1
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2025 13:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876911; x=1739481711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRZdQCp2QG2WlZHDNniYpt/U4I7+MZLg527LTl2mfgM=;
        b=a7fTD2KutYG6MRisPBneVyOHfNDhPxedn8IPs7LvVMR6wI1WbJAms/n+6Yy9jSrLwP
         eMUlR/VHxbikgAgQ/mX4HG36kEerUwJ3Ycp/uMAaXgAFdSzFewo8mZRQifj69SYzytwu
         ph9rfKuiK+bebYiEqj13VWzhJ7yAz5BNR8Nnfs3ubvMKFMiHrZULkdoV4PGPBKOT/Q32
         L9RnqMygN3uqVUfYPvyXE0yHXDPht9kx7+eGf0PYNRQEHG1ZkHnszG5g03TQwlPqj0hl
         3+Vk/73zGBtAAZt7Hf4I0ydHo6235x6xk4IJM1wBSZa5E3XwJRNmiibrWH5nO6+fNgE9
         bgGQ==
X-Gm-Message-State: AOJu0YxMR+qbD66XKiwleze09hXimuMcuUa7BWRZixj7gKVyEm6mZra1
	O1z5LXQ6UWrzHmGbW2YcjrOZ4oEGE5MD/dgsUjnd5bbDxJOQgJ0uBP8fsJZ6FrnblcsKcXFVh88
	hjH1k2uV9f1X1zJBHscz4wBMvaF0mRSfh7ncGiIxTegIP67Cq6u9Sp+iVAX1deweK6iSKIsdnbm
	u2Mqmn6UV9F70y51QdQbrIEuCMOnJ2a4J6J+qfN6u9
X-Gm-Gg: ASbGnctkCQGLAmArd8WCwtHz2zJW5OprDoy6x8iC1423Y1m03dvJtGtZGZLJkYWde6R
	s9YUbtQVqC8eotcIy5HI/20ghTV3ljrHyN87K5Mk5gJnpRFFLvQrP9WsHPKyCw658mxnbS7Z8PQ
	uiJ6hRgFHLFMuoqz5qN4AMRKmXwfqWXaQ4nbKV+HMG+3SxZhuxtKriob07w6THVHKN4QnZ0alnN
	tFHqZMKFMzwiBr1yeJ4zmy24uxl2svEOrG/IlLaUThVxrEH119LgwZ/IH1PF3n7wnvb4OzyZtDv
	wjXCcJI0ML930iSbXGhMN6+zN3Au9QiwWFHozyAJesWp7BnuPORzQw==
X-Received: by 2002:a05:6e02:12c1:b0:3cf:b9b8:5052 with SMTP id e9e14a558f8ab-3d13dcd8ffamr5404995ab.3.1738876911134;
        Thu, 06 Feb 2025 13:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUV5m7HDJuLHkvHNZTGs2zNdIQLGXh5K+HXV5CVrIH00fDOyboBC2VbwWh52Xn0BqyrMwNmg==
X-Received: by 2002:a05:6e02:12c1:b0:3cf:b9b8:5052 with SMTP id e9e14a558f8ab-3d13dcd8ffamr5404755ab.3.1738876910571;
        Thu, 06 Feb 2025 13:21:50 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9afe8bsm435133173.6.2025.02.06.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:21:50 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 3/7] lib: Fix non-ANSI function declarations
Date: Thu,  6 Feb 2025 15:19:58 -0600
Message-ID: <20250206212145.7732-4-sandeen@redhat.com>
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

lib/ was full of non-ANSI function declarations, fix them to make
sparse happier.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 lib/dataascii.c    | 59 +++++++++++++++++++++-----------------------
 lib/databin.c      | 28 ++++++++++-----------
 lib/datapid.c      | 32 +++++++++---------------
 lib/file_lock.c    | 12 ++-------
 lib/forker.c       | 19 ++++++---------
 lib/pattern.c      | 14 ++---------
 lib/random_range.c | 61 ++++++++++++++--------------------------------
 lib/str_to_bytes.c |  9 +++----
 lib/tlibio.c       | 50 ++++++++++++++++++-------------------
 lib/write_log.c    | 32 ++++++++----------------
 10 files changed, 119 insertions(+), 197 deletions(-)

diff --git a/lib/dataascii.c b/lib/dataascii.c
index e2509f8d..d11609ee 100644
--- a/lib/dataascii.c
+++ b/lib/dataascii.c
@@ -17,18 +17,18 @@
 static char Errmsg[80];
 
 int
-dataasciigen(listofchars, buffer, bsize, offset)
-char *listofchars;	/* a null terminated list of characters */
-char *buffer;
-int bsize;
-int offset;
+dataasciigen(
+	char *listofchars,	/* a null terminated list of characters */
+	char *buffer,
+	int bsize,
+	int offset)
 {
-   int cnt;
-   int total;
-   int ind;	/* index into CHARS array */
-   char *chr;
-   int chars_size;
-   char *charlist;
+	int cnt;
+	int total;
+	int ind;	/* index into CHARS array */
+	char *chr;
+	int chars_size;
+	char *charlist;
 
 	chr=buffer;
 	total=offset+bsize;
@@ -52,19 +52,19 @@ int offset;
 }	/* end of dataasciigen */
 
 int
-dataasciichk(listofchars, buffer, bsize, offset, errmsg)
-char *listofchars;	/* a null terminated list of characters */
-char *buffer;
-int bsize;
-int offset;
-char **errmsg;
+dataasciichk(
+	char *listofchars,	/* a null terminated list of characters */
+	char *buffer,
+	int bsize,
+	int offset,
+	char **errmsg)
 {
-   int cnt;
-   int total;
-   int ind;	/* index into CHARS array */
-   char *chr;
-   int chars_size;
-   char *charlist;
+	int cnt;
+	int total;
+	int ind;	/* index into CHARS array */
+	char *chr;
+	int chars_size;
+	char *charlist;
 
 	chr=buffer;
 	total=offset+bsize;
@@ -104,15 +104,12 @@ char **errmsg;
  * main for doing unit testing
  ***********************************************************************/
 int
-main(ac, ag)
-int ac;
-char **ag;
+main(int ac, char **ag)
 {
-
-int size=1023;
-char *buffer;
-int ret;
-char *errmsg;
+    int size=1023;
+    char *buffer;
+    int ret;
+    char *errmsg;
 
     if ((buffer=(char *)malloc(size)) == NULL ) {
         perror("malloc");
diff --git a/lib/databin.c b/lib/databin.c
index 8a36dff3..000d0d1a 100644
--- a/lib/databin.c
+++ b/lib/databin.c
@@ -16,13 +16,13 @@
 static char Errmsg[80];
 
 void
-databingen (mode, buffer, bsize, offset)
-int mode;	/* either a, c, r, o, z or C */
-unsigned char *buffer;	/* buffer pointer */
-int bsize;	/* size of buffer */
-int offset;	/* offset into the file where buffer starts */
+databingen(
+	int mode,	/* either a, c, r, o, z or C */
+	unsigned char *buffer,	/* buffer pointer */
+	int bsize,	/* size of buffer */
+	int offset)	/* offset into the file where buffer starts */
 {
-int ind;
+	int ind;
 
         switch (mode)
         {
@@ -63,12 +63,12 @@ int ind;
  *      < 0  : no error
  ***********************************************************************/
 int
-databinchk(mode, buffer, bsize, offset, errmsg)
-int mode;	/* either a, c, r, z, o, or C */
-unsigned char *buffer;	/* buffer pointer */
-int bsize;	/* size of buffer */
-int offset;	/* offset into the file where buffer starts */
-char **errmsg;
+databinchk(
+	int mode,	/* either a, c, r, z, o, or C */
+	unsigned char *buffer,	/* buffer pointer */
+	int bsize,	/* size of buffer */
+	int offset,	/* offset into the file where buffer starts */
+	char **errmsg)
 {
 	int cnt;
 	unsigned char *chr;
@@ -138,9 +138,7 @@ char **errmsg;
  * main for doing unit testing
  ***********************************************************************/
 int
-main(ac, ag)
-int ac;
-char **ag;
+main(int ac, char **ag)
 {
 
     int size=1023;
diff --git a/lib/datapid.c b/lib/datapid.c
index 15af8871..6786323d 100644
--- a/lib/datapid.c
+++ b/lib/datapid.c
@@ -57,15 +57,13 @@ static char Errmsg[80];
  * Thus, offset 8 is in middle of word 1
  ***********************************************************************/
 int
-datapidgen(pid, buffer, bsize, offset)
-int pid;
-char *buffer;
-int bsize;
-int offset;
+datapidgen(
+	int pid,
+	char *buffer,
+	int bsize,
+	int offset)
 {
 	return -1;	/* not support on non-64 bits word machines  */
-
-
 } 
 
 /***********************************************************************
@@ -73,12 +71,7 @@ int offset;
  *
  ***********************************************************************/
 int
-datapidchk(pid, buffer, bsize, offset, errmsg)
-int pid;
-char *buffer;
-int bsize;
-int offset;
-char **errmsg;
+datapidchk(int pid, char *buffer, int bsize, int offset, char **errmsg)
 {
     if ( errmsg != NULL ) {
         *errmsg = Errmsg;
@@ -94,15 +87,12 @@ char **errmsg;
  * main for doing unit testing
  ***********************************************************************/
 int
-main(ac, ag)
-int ac;
-char **ag;
+main( int ac, char **ag)
 {
-
-int size=1234;
-char *buffer;
-int ret;
-char *errmsg;
+    int size=1234;
+    char *buffer;
+    int ret;
+    char *errmsg;
 
     if ((buffer=(char *)malloc(size)) == NULL ) {
         perror("malloc");
diff --git a/lib/file_lock.c b/lib/file_lock.c
index f0791489..6d87e281 100644
--- a/lib/file_lock.c
+++ b/lib/file_lock.c
@@ -34,10 +34,7 @@ static char errmsg[256];
  * It will loop if the LOCK_NB flags is NOT set.
  ***********************************************************************/
 int
-file_lock(fd, flags, errormsg)
-int fd;
-int flags;
-char **errormsg;
+file_lock(int fd, int flags, char **errormsg)
 {
         register int cmd, ret;
         struct flock flocks;
@@ -109,12 +106,7 @@ char **errormsg;
  * It will loop if the LOCK_NB flags is NOT set.
  ***********************************************************************/
 int
-record_lock(fd, flags, start, len, errormsg)
-int fd;
-int flags;
-int start;
-int len;
-char **errormsg;
+record_lock(int fd, int flags, int start, int len, char **errormsg)
 {
         register int cmd, ret;
         struct flock flocks;
diff --git a/lib/forker.c b/lib/forker.c
index 63d8fcdb..10920ddb 100644
--- a/lib/forker.c
+++ b/lib/forker.c
@@ -105,8 +105,7 @@ int Forker_npids=0;             /* number of entries in Forker_pids */
  *  !0 : if fork failed, the return value will be the errno.
  ***********************************************************************/
 int
-background(prefix)
-char *prefix;
+background(char *prefix)
 {
   switch (fork()) {
   case -1:
@@ -131,12 +130,12 @@ char *prefix;
  * 
  ***********************************************************************/
 int
-forker(ncopies, mode, prefix)
-int ncopies;
-int mode;	/* 0 - all childern of parent, 1 - only 1 direct child */
-char *prefix;   /* if ! NULL, an message will be printed to stderr */
-		/* if fork fails.  The prefix (program name) will */
-	        /* preceed the message */
+forker(
+    int ncopies,
+    int mode,		/* 0: all childern of parent, 1: only 1 direct child */
+    char *prefix)   	/* if ! NULL, an message will be printed to stderr */
+			/* if fork fails.  The prefix (program name) will */
+			/* preceed the message */
 {
     int cnt;
     int pid;
@@ -210,9 +209,7 @@ char *prefix;   /* if ! NULL, an message will be printed to stderr */
  */
 
 int
-main(argc, argv)
-int argc;
-char **argv;
+main(int argc, char **argv)
 {
     int ncopies=1;
     int mode=0;
diff --git a/lib/pattern.c b/lib/pattern.c
index d622b935..20bbdc97 100644
--- a/lib/pattern.c
+++ b/lib/pattern.c
@@ -12,12 +12,7 @@
  */
 
 int
-pattern_check(buf, buflen, pat, patlen, patshift)
-char	*buf;
-int	buflen;
-char	*pat;
-int	patlen;
-int	patshift;
+pattern_check(char *buf, int buflen, char *pat, int patlen, int patshift)
 {
     int		nb, ncmp, nleft;
     char	*cp;
@@ -79,12 +74,7 @@ int	patshift;
 }
 
 int
-pattern_fill(buf, buflen, pat, patlen, patshift)
-char	*buf;
-int	buflen;
-char	*pat;
-int	patlen;
-int	patshift;
+pattern_fill(char *buf, int buflen, char *pat, int patlen, int patshift)
 {
     int		trans, ncopied, nleft;
     char	*cp;
diff --git a/lib/random_range.c b/lib/random_range.c
index 3fa01f0d..680bf71c 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -73,14 +73,14 @@ static int       str_to_int();
 static long long divider(long long, long long, long long, long long);
 
 int
-parse_ranges(str, defmin, defmax, defmult, parse_func, rangeptr, errptr)
-char	*str;
-int	defmin;
-int	defmax;
-int	defmult;
-int	(*parse_func)();
-char	**rangeptr;
-char	**errptr;
+parse_ranges(
+	char *str,
+	int defmin,
+	int defmax,
+	int defmult,
+	int (*parse_func)(),
+	char **rangeptr,
+	char **errptr)
 {
 	int		ncommas;
 	char		*tmpstr, *cp, *tok, *n1str, *n2str, *multstr;
@@ -194,9 +194,7 @@ char	**errptr;
  */
 
 static int
-str_to_int(str, ip)
-char	*str;
-int	*ip;
+str_to_int(char *str, int *ip)
 {
 	char	c;
 
@@ -214,25 +212,19 @@ int	*ip;
  */
 
 int
-range_min(rbuf, r)
-char	*rbuf;
-int	r;
+range_min(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].min;
 }
 
 int
-range_max(rbuf, r)
-char	*rbuf;
-int	r;
+range_max(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].max;
 }
 
 int
-range_mult(rbuf, r)
-char	*rbuf;
-int	r;
+range_mult(char *rbuf, int r)
 {
 	return ((struct range *)rbuf)[r].mult;
 }
@@ -263,11 +255,7 @@ int	r;
  *****************************************************************************/
 
 long
-random_range(min, max, mult, errp)
-int	min;
-int	max;
-int	mult;
-char	**errp;
+random_range(int min, int max, int mult, char **errp)
 {
 	int     	r, nmults, orig_min, orig_max, orig_mult, tmp;
 	extern long	lrand48();
@@ -333,11 +321,7 @@ char	**errp;
  * Just like random_range, but all values are longs.
  */
 long
-random_rangel(min, max, mult, errp)
-long	min;
-long	max;
-long	mult;
-char	**errp;
+random_range1(long min, long max, long mult, char **errp)
 {
 	long     	r, nmults, orig_min, orig_max, orig_mult, tmp;
 	extern long	lrand48();
@@ -424,11 +408,7 @@ char	**errp;
  *  Attempts to be just like random_range, but everything is long long (64 bit)
  */
 long long
-random_rangell(min, max, mult, errp)
-long long	min;
-long long	max;
-long long	mult;
-char		**errp;
+random_rangell(long long min, long long max, long long mult, char **errp)
 {
 	long long     	r, nmults, orig_min, orig_max, orig_mult, tmp;
         long long	randnum;
@@ -588,8 +568,7 @@ printf("   diff = %lld, half = %lld,   med = %lld\n", diff, half, med);
  *****************************************************************************/
 
 void
-random_range_seed(s)
-long    s;
+random_range_seed(long s)
 {
     extern void srand48();
 
@@ -652,9 +631,7 @@ random_bit(long mask)
 /*
  *  The following is a unit test main function for random_bit().
  */
-main(argc, argv)
-int argc;
-char **argv;
+main(int argc, char **argv)
 {
     int ind;
     int cnt, iter;
@@ -695,9 +672,7 @@ char **argv;
 #define MEG  1024*1024*1024
 #define GIG 1073741824
 int
-main(argc, argv)
-int argc;
-char **argv;
+main(int argc, char **argv)
 {
     int ind;
     int cnt, iter=10;
diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
index 2f6b2b92..20cd2a0f 100644
--- a/lib/str_to_bytes.c
+++ b/lib/str_to_bytes.c
@@ -42,8 +42,7 @@
 #define T_MULT	1099511627776	/* tera or 2^40 */
 
 int
-str_to_bytes(s)
-char    *s;
+str_to_bytes(char *s)
 {
     char    mult, junk;
     int	    nconv;
@@ -77,8 +76,7 @@ char    *s;
 }
 
 long
-str_to_lbytes(s)
-char    *s;
+str_to_lbytes(char *s)
 {
     char    mult, junk;
     long    nconv;
@@ -117,8 +115,7 @@ char    *s;
  */
 
 long long
-str_to_llbytes(s)
-char    *s;
+str_to_llbytes(char *s)
 {
     char    mult, junk;
     long    nconv;
diff --git a/lib/tlibio.c b/lib/tlibio.c
index f7259734..3c23bf4d 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -143,13 +143,13 @@ static int Debug_level = 0;
  ***********************************************************************/
 
 int
-stride_bounds(offset, stride, nstrides, bytes_per_stride, min, max)
-int	offset;
-int	stride;
-int	nstrides;
-int	bytes_per_stride;
-int	*min;
-int	*max;
+stride_bounds(
+	int offset,
+	int stride,
+	int nstrides,
+	int bytes_per_stride,
+	int *min,
+	int *max)
 {
 	int	nbytes, min_byte, max_byte;
 
@@ -443,14 +443,14 @@ lio_random_methods(long curr_mask)
  * (rrl 04/96)
  ***********************************************************************/
 int
-lio_write_buffer(fd, method, buffer, size, sig, errmsg, wrd)
-int fd;		/* open file descriptor */
-int method;	/* contains io type and wait method bitmask */
-char *buffer;	/* pointer to buffer */
-int size;	/* the size of the io */
-int sig;	/* signal to use if async io */
-char **errmsg;	/* char pointer that will be updated to point to err message */
-long wrd;	/* to allow future features, use zero for now */
+lio_write_buffer(
+    int fd,		/* open file descriptor */
+    int method,		/* contains io type and wait method bitmask */
+    char *buffer,	/* pointer to buffer */
+    int size,		/* the size of the io */
+    int sig,		/* signal to use if async io */
+    char **errmsg,	/* char pointer that will be updated to point to err message */
+    long wrd)		/* to allow future features, use zero for now */
 {
     int ret = 0;	/* syscall return or used to get random method */
 #ifndef linux
@@ -640,14 +640,14 @@ long wrd;	/* to allow future features, use zero for now */
  * (rrl 04/96)
  ***********************************************************************/
 int
-lio_read_buffer(fd, method, buffer, size, sig, errmsg, wrd)
-int fd;		/* open file descriptor */
-int method;	/* contains io type and wait method bitmask */
-char *buffer;	/* pointer to buffer */
-int size;	/* the size of the io */
-int sig;	/* signal to use if async io */
-char **errmsg;	/* char pointer that will be updated to point to err message */
-long wrd;	/* to allow future features, use zero for now */
+lio_read_buffer(
+    int fd,		/* open file descriptor */
+    int method,		/* contains io type and wait method bitmask */
+    char *buffer,	/* pointer to buffer */
+    int size,		/* the size of the io */
+    int sig,		/* signal to use if async io */
+    char **errmsg,	/* char pointer that will be updated to point to err message */
+    long wrd)		/* to allow future features, use zero for now */
 {
     int ret = 0;	/* syscall return or used to get random method */
 #ifndef linux
@@ -1031,9 +1031,7 @@ struct unit_info_t {
 };
 
 int
-main(argc, argv)
-int argc;
-char **argv;
+main(int argc, char **argv)
 {
     extern char *optarg;
     extern int optind;
diff --git a/lib/write_log.c b/lib/write_log.c
index cdc72593..c82cc1f4 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -87,10 +87,7 @@ static int	wlog_rec_unpack();
  */
 
 int
-wlog_open(wfile, trunc, mode)
-struct wlog_file	*wfile;
-int			trunc;
-int			mode;
+wlog_open(struct wlog_file *wfile, int trunc, int mode)
 {
 	int	omask, oflags;
 
@@ -138,8 +135,7 @@ int			mode;
  */
 
 int
-wlog_close(wfile)
-struct wlog_file	*wfile;
+wlog_close(struct wlog_file *wfile)
 {
 	close(wfile->w_afd);
 	close(wfile->w_rfd);
@@ -173,10 +169,7 @@ struct wlog_file	*wfile;
  */
 
 int
-wlog_record_write(wfile, wrec, offset)
-struct wlog_file	*wfile;
-struct wlog_rec		*wrec;
-long			offset;
+wlog_record_write(struct wlog_file *wfile, struct wlog_rec *wrec, long offset)
 {
     int		reclen;
     char	wbuf[WLOG_REC_MAX_SIZE + 2];
@@ -221,11 +214,11 @@ long			offset;
  */
 
 int
-wlog_scan_backward(wfile, nrecs, func, data)
-struct wlog_file	*wfile;
-int 			nrecs;
-int 			(*func)();
-long			data;
+wlog_scan_backward(
+	struct wlog_file	*wfile,
+	int 			nrecs,
+	int 			(*func)(),
+	long			data)
 {
 	int			fd, leftover, nbytes, offset, recnum, reclen;
 	char    		buf[BSIZE*32], *bufend, *cp, *bufstart;
@@ -351,10 +344,7 @@ long			data;
  */
 
 static int
-wlog_rec_pack(wrec, buf, flag)
-struct wlog_rec	*wrec;
-char		*buf;
-int             flag;
+wlog_rec_pack(struct wlog_rec *wrec, char *buf, int flag)
 {
 	char			*file, *host, *pattern;
 	struct wlog_rec_disk	*wrecd;
@@ -400,9 +390,7 @@ int             flag;
 }
 
 static int
-wlog_rec_unpack(wrec, buf)
-struct wlog_rec	*wrec;
-char		*buf;
+wlog_rec_unpack(struct wlog_rec *wrec, char *buf)
 {
 	char			*file, *host, *pattern;
 	struct wlog_rec_disk	*wrecd;
-- 
2.48.0

