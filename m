Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526D1B4F09
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616786; cv=none; b=dVL+eE8sGrBvkntghqZHX7LzYzLKfX06t9BtbMu9FaGlIPGwakAXzLNtJ5i6dC78VdL2AOg9APmW4mhLnreQrX/A3Q9YYWdva+Px3bgM1uooMm1Rntix/lM5OJc5Ml9x2PXSabowXZMGNv+QxNDRfFpbRs9XdNSnPa9iBLEM47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616786; c=relaxed/simple;
	bh=6rer+KeSKu9dpmtmaljvwdtceQ4KSczRVVsBLEkd1j4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DjhSOpoCvk7+t6KKD94FHQ89eDIMmDirjgwCv+e7ATemWhc2oK9nJlRSOREeLqffpAkg+2gevZCGoLIQBtkywANz6PTq2Wffq3drQmh3//pFmVyeX8MokYGzuxnHsy5MakXAbup9CgqlvjVcbmTVJylwKrhWbr8t3f1BBhFyiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jU4sTaF7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jU4sTaF7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jU4sTaF7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jU4sTaF7"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out2.suse.de (Postfix) with ESMTP id 51E171F393
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746616782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e2nq1C8mXPwUpsceUxHMTs02nF7IffjCXuUr8L1oMBw=;
	b=jU4sTaF7pKD3838/ua+EkdsHkC46QpKU2GkPJu1KZjVdb6BpfO7cUlWervowDq+wPxPwmQ
	zjd2bTGWIZkamq34VzxdOh+ECLSH9IxQnoxrkAJrXPIuEL4HJmoLa6ymxk+VFEJbcNX81b
	NoT5MWLIKgmulWkT6nKCcjqlXG+c+ws=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746616782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e2nq1C8mXPwUpsceUxHMTs02nF7IffjCXuUr8L1oMBw=;
	b=jU4sTaF7pKD3838/ua+EkdsHkC46QpKU2GkPJu1KZjVdb6BpfO7cUlWervowDq+wPxPwmQ
	zjd2bTGWIZkamq34VzxdOh+ECLSH9IxQnoxrkAJrXPIuEL4HJmoLa6ymxk+VFEJbcNX81b
	NoT5MWLIKgmulWkT6nKCcjqlXG+c+ws=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH REPOST] generic/211: completely remove obsolete test and related code
Date: Wed,  7 May 2025 13:18:12 +0200
Message-ID: <20250507111811.8624-2-ailiop@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:helo,suse.com:mid,suse.com:email]
X-Spam-Score: -1.80

This was a regression test for a bug in fs/aio.c kernel code that could
cause kernel crashing and was fixed in commit 3e45a10919b3 ("aio: remove
incorrect initialization of "nr_pages"") more than 20 years ago (in
v2.6.10).

The test code was basically trying to trigger the bug by doing repeated
mmaps until it would exhaust the vm.max_map_count limit, after which the
aio_setup_ring() would fail its own internal mmap and branch into
aio_free_ring() where it would attempt to free pages that were not
allocated and crash the kernel.

The bug is was not really relevant to filesystems in the first place,
and further to its fix it was made not possible to trigger due to commit
3dc9acb67600 ("aio: clean up and fix aio_setup_ring page mapping").

The test currently triggers the oom killer on systems where the
vm.max_map_count limit has been increased significantly from the default
as it eventually exhausts the available memory. This could be trivially
fixed by lowering and then restoring the limit just for the duration of
the test, but since it no longer serves any purpose let's drop it
completely.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 .gitignore                                    |  1 -
 .../aio-free-ring-with-bogus-nr-pages.c       | 72 -------------------
 tests/generic/211                             | 20 ------
 tests/generic/211.out                         |  2 -
 4 files changed, 95 deletions(-)
 delete mode 100644 src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
 delete mode 100755 tests/generic/211
 delete mode 100644 tests/generic/211.out

diff --git a/.gitignore b/.gitignore
index 4fd817243dca..20dee781c663 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,7 +198,6 @@ tags
 /src/aio-dio-regress/aio-dio-invalidate-readahead
 /src/aio-dio-regress/aio-dio-subblock-eof-read
 /src/aio-dio-regress/aio-dio-write-verify
-/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
 /src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiocp
diff --git a/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c b/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
deleted file mode 100644
index 7e8189f06a4e..000000000000
--- a/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2006 Kostantin Khorenko
- * Copyright (C) 2006 Jeff Moyer
- */
-
-/*
- *  Test aio_setup_ring with bad nr_pages
- *
- *  Code taken from an example posted to Red Hat bugzilla #220971
- *  Original Author: Kostantin Khorenko from OpenVZ/Virtuozzo
- *  Munged by Jeff Moyer.
- *
- *  Description: "aio_setup_ring() function initializes info->nr_pages
- *    variable incorrectly, then this variable can be used in error path
- *    to free the allocated resources. By this way an unprivileged user
- *    can crash the node."
- *
- *  At the beginning of aio_setup_ring, info->nr_pages is initialized
- *  to the requested number of pages.  However, it is supposed to
- *  indicate how many pages are mapped in info->ring_pages.  Thus, if
- *  the call to do_mmap fails:
- *
- *	info->mmap_base = do_mmap(NULL, 0, info->mmap_size, 
- *				  PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE,
- *				  0);
- *	if (IS_ERR((void *)info->mmap_base)) {
- *		up_write(&ctx->mm->mmap_sem);
- *		printk("mmap err: %ld\n", -info->mmap_base);
- *		info->mmap_size = 0;
- *		aio_free_ring(ctx);    <---------
- *		return -EAGAIN;
- *	}
- *
- *  we end up calling aio_free_ring with a bogus array and cause an oops.
- *
- *  This is a destructive test.
- */
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <libgen.h>
-#include <libaio.h>
-
-int main(int __attribute__((unused)) argc, char **argv)
-{
-	long res;
-	io_context_t ctx;
-	void* map;
-
-	while (1) {
-		map = mmap(NULL, 100, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE,
-			   0, 0);
-		if (map == MAP_FAILED)
-			break;
-		map = mmap(NULL, 100, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE,
-			   0, 0);
-		if (map == MAP_FAILED)
-			break;
-	}
-
-	memset(&ctx, 0, sizeof(ctx));
-	res = io_setup(10000, &ctx);
-	if (res != -ENOMEM) {
-		printf("%s: Error: io_setup returned %ld, expected -ENOMEM\n",
-		       basename(argv[0]), res);
-		return 1;
-	} else
-		printf("%s: Success!\n", basename(argv[0]));
-	return 0;
-}
diff --git a/tests/generic/211 b/tests/generic/211
deleted file mode 100755
index 9868c600767d..000000000000
--- a/tests/generic/211
+++ /dev/null
@@ -1,20 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2009 Eric Sandeen.  All Rights Reserved.
-#
-# FS QA Test No. 211
-#
-# Run aio-free-ring-with-bogus-nr-pages - test aio_setup_ring with bad nr_pages
-#
-. ./common/preamble
-_begin_fstest auto aio quick
-
-# Import common functions.
-. ./common/filter
-
-
-_require_test
-
-_run_aiodio aio-free-ring-with-bogus-nr-pages
-
-exit $status
diff --git a/tests/generic/211.out b/tests/generic/211.out
deleted file mode 100644
index 08be2c5495d0..000000000000
--- a/tests/generic/211.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 211
-aio-free-ring-with-bogus-nr-pages: Success!
-- 
2.44.0

