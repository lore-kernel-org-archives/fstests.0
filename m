Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D61FFC7E
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090892; cv=none; b=MJMdvGohekj4fqRSqCiV/7d9AJ2mA5uXtS0GYuhWR/SVEqEdsvJ1UcfmIzMWghttuL59NHGKadrtJIhKNeaeL6WSW9WQKPUbLm9BVUfVrDIjUjrJC7VsbJ5NIUiIyDT6cxVE/4IGUPVsHB1/IQvfKPwZB23OIENFNCXrtP7FVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090892; c=relaxed/simple;
	bh=N8TKVt5ZoZilmj95nNHHXeIQrwaPFKCV/8ZelweOb/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3pEI/dpE/n/O0fKoZ8pY6PbOzEdyBCGlspaX1E94Y47xBsXnDpjFQAzX8eI43vtAQK9lM6rZUyi8GwmWI1l4aszpDf1jKNNzucMQgy/GsaEx8I2VRmrN3OosRqag5XzaQpjbT2dvpNVckq7E8IgsiECMisOO1eaFlz84HD2+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZZLR6Nmo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZZLR6Nmo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sseHBSEkdoeMPJvSH1dIIphkpGRXEQsVTzidSof9Ams=; b=ZZLR6NmoU1jYQ//vuDJj+7czEP
	pNY81ansrozaKyOjhjPadj/CZ9MlELae+45mHOiyVKIXuOL3R8nXmIuf5Q3yKZbcnGfvjAn1OyeZD
	f1K3DsrwtJM6rWb+misLi0DKs1jThncwZ7Qj8nqh1MVOEAtJEsdFLCcaTCDCrm6SC5kNtzeXveXkC
	5y4+Qb6ayHycRq/bftGpSOR8l1h5bO32Fn1z2z00firWpaMq1AqxVmuqwOUy7cVmhzoJHP44slv/M
	wMnxQBGNyxTMheSeq5MlCY4wc57Md7BHuzzKdZXmzLq0uFcLz8YvzE6dOpSFNKfitVTa43J+7bbIE
	PwndXjwA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpRGz-003hiL-JD; Tue, 04 Mar 2025 13:21:27 +0100
From: Luis Henriques <luis@igalia.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH 1/2] src: include libgen.h for function basename() if not using GNU libc
Date: Tue,  4 Mar 2025 12:21:18 +0000
Message-ID: <20250304122119.21412-2-luis@igalia.com>
In-Reply-To: <20250304122119.21412-1-luis@igalia.com>
References: <20250304122119.21412-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling fstests on a system without the GNU libc fails because the
basename() is defined in libgen.h by POSIX and not in string.h.

Fix that by including the libgen.h header if __USE_GNU isn't defined.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 src/aio-dio-regress/aio-dio-append-write-read-race.c | 3 +++
 src/splice-test.c                                    | 3 +++
 src/t_ext4_dax_inline_corruption.c                   | 3 +++
 src/t_ext4_dax_journal_corruption.c                  | 3 +++
 src/t_mmap_collision.c                               | 3 +++
 src/t_mmap_dio.c                                     | 3 +++
 6 files changed, 18 insertions(+)

diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
index d9f8982f007c..1a0c8e99c61f 100644
--- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
+++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
@@ -19,6 +19,9 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 #include <libaio.h>
 #include <pthread.h>
diff --git a/src/splice-test.c b/src/splice-test.c
index eb8636738064..e6753a15dc47 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -18,6 +18,9 @@
 #include <string.h>
 #include <errno.h>
 #include <malloc.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 unsigned int sector_size;
 unsigned int buffer_size;
diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
index e1a39a6c1e46..a6cb768512fc 100644
--- a/src/t_ext4_dax_inline_corruption.c
+++ b/src/t_ext4_dax_inline_corruption.c
@@ -10,6 +10,9 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 #define PAGE(a) ((a)*0x1000)
 #define STRLEN 256
diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
index ba7a96e43559..4e5762d77058 100644
--- a/src/t_ext4_dax_journal_corruption.c
+++ b/src/t_ext4_dax_journal_corruption.c
@@ -10,6 +10,9 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 #define PAGE(a) ((a)*0x1000)
 #define STRLEN 256
diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
index c872f4e26940..638424d2e619 100644
--- a/src/t_mmap_collision.c
+++ b/src/t_mmap_collision.c
@@ -24,6 +24,9 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 void *dax_data;
 int nodax_fd;
diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
index 6c8ca1a39181..342e2c6deb4b 100644
--- a/src/t_mmap_dio.c
+++ b/src/t_mmap_dio.c
@@ -14,6 +14,9 @@
 #include <libaio.h>
 #include <errno.h>
 #include <sys/time.h>
+#ifndef __USE_GNU
+#include <libgen.h>
+#endif
 
 void usage(char *prog)
 {
