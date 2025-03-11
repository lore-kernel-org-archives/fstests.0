Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E71C695
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700812; cv=none; b=KSV0CR5PB4W+K7guAij9/ZoxHHq+pYbah3iAYqIx+7NRiujOKMg9DUxAIakUyJGDNgo0QPvDAL2nrdyVcDZecKXSla4IL4f6IgpJzri3/6g+mirLnUHlbDxIjbubkjhCU2CQNJV2/uzObiIYzrcexBw34TS7w7YjlL8zBDl9FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700812; c=relaxed/simple;
	bh=H9eYqo2zTPlHeI6F5pjZag12ySmD19EyMdsYhi281Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqgMM7F+pHPL6bayDmt3MPu2Jw+f3e74lkoPh/8iy/QWpMuMqbObQa9ElK/bXG+skQk27Imb0Xk7wbWU1H3WfHB+rFIEWoIbD9RoXL6A3s/fna+3gjhHhDSfLN9boTV/v9RJvwN2cP9tUl+ajMhuwgsrs3skI+dO02N0SpgVqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=J6gq0kDp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjU1MGu2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="J6gq0kDp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjU1MGu2"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4355525400E9;
	Tue, 11 Mar 2025 09:46:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 09:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741700809;
	 x=1741787209; bh=aUSb5Cze6U/+4NXHlcLen0ifAV6F+Ii2tyeaBAD8z2Q=; b=
	J6gq0kDpjumz/k5KDVdapJgW101+TengVjs9sxU3p5IngemtSVOhE0FYYHGmj5s2
	anm637sfWp4OHArnqCiUVNc3j0PTbxDjXw3L6eq1f5EEnQttGVHVguK8YTCWIUAc
	O4r14bJFIdaSs/SvED8kdFLGOgTEveLwq1AUp5CcfezvJKrC3/IrXcnpDkreuJ/W
	4ZXT1iT070dXo18tzHLMlKalLtnpsDR10kkfGKITElXH42qir7OCogVHSE/FJff4
	seSjaIB5vn9FC21V261CXSzimJQo4ZVDWimvRF/n7nZWNWUq29KFvCveh8IJm74s
	XdLro6fZ1iLZNi7/B0RIMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741700809; x=
	1741787209; bh=aUSb5Cze6U/+4NXHlcLen0ifAV6F+Ii2tyeaBAD8z2Q=; b=W
	jU1MGu2AYyyVgPd9yVnUgV9vHExPu5Ug4F5iXTo4j+JgGZ4gcOip86CJJQuHuev7
	t5WyZu/4Ttpz/aKaXslIt6t0M5coMMtQHlRN9mU1iiZ8wUiZyGFQ4MPTkVbBFAX3
	o6qUuYX5CPUhiCX56hIF3TcbU6Suf440liKcu+K/ofIh2Pxpy3dgamBS4WxjmCuX
	N8asK9zV8YoJHIbs2KBRULLnv/7Gd54v25YvemZGOMfxEv2bTNUsroWwWqN4lEzz
	XtBPIUrGlAPAqcE4d7MCeR5zicX5X8VAEGrMZiKTi8drQOORx2ddwrVbAt4/VoR4
	0KYHwmDo7n8VaI/ZM2wYw==
X-ME-Sender: <xms:yD7QZy1SGjiZxJrIsNr8IjHy4JjuZNbdek3tVboLxtrRZTmVfm60JQ>
    <xme:yD7QZ1GHe5hsOIlcCgxh8Wx1zAkSCJFid-stB3HPB4jLkO7nlyvKr9mAvzYA20FtY
    It5KW0wutPFJ8gMSAE>
X-ME-Received: <xmr:yD7QZ667N9xq1sFDH-sNVzEViSBDXnK_Q4NpuEW9y4w_qGtLMZwyQazwliPZPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgfhrihgtucfurghnuggv
    vghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveeikeeuteefueejtdehfeefvdegffeivdejjeelfffhgeegjeeutdejueelhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrnhguvg
    gvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    jhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvg
    grugdrohhrgh
X-ME-Proxy: <xmx:yD7QZz2ppAObs9gzFzBkc6cuRpuBVcdSAJh039EwXWzCeF0iL9TGZQ>
    <xmx:yD7QZ1GhqKOM7NlxJGtWMyheNwBHudGT3bHGqJEbaUjmgFob7ASgLw>
    <xmx:yD7QZ88RTqWrzZMXrl0LXfnF9jZ5MGyS2cUJc69RId0ojCUxefRsSg>
    <xmx:yD7QZ6kgr-XZZWtPymVie0OKyktnuH5d4sUu9D7rkxQgMy2Cm-W7uA>
    <xmx:yT7QZ5i7OmX3vpBT4uzJu-pjJpIdS9jcDzqyvcGyOJq3iucQ6lgXgZLj>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 09:46:48 -0400 (EDT)
Message-ID: <290f4825-dc3c-405f-a306-49a978fa2597@sandeen.net>
Date: Tue, 11 Mar 2025 08:46:48 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/7 V3] treewide: check for #ifdef __linux__ not linux
To: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, hch@infradead.org
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-3-sandeen@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250310182954.1396724-3-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are several #ifdef linux guards in the code, which caused
a few sparse warnings, because while gcc defines both linux
and __linux__, sparse defines only __linux__. So, switch our
guards to check for __linux__ which is defined by both gcc
and sparse.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


