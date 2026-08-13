Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AE481FC7;
	Thu, 13 Aug 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633737; cv=none; b=WbUxOvhtA7HAsN4PEpSzTeCpaa6f4d/AejJ1gg42LlalENKtsIJknmq//KTsI1T/z8yX1Cj2eaQOxc4WZHvMaOVkNvf1rBgjO2jfpuvOWWHMKMvvETHzkz+HkN6/nstDj8eUxOfcqN65CnvEqdcR31SaAMhvIguYZhIuQnPADBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633737; c=relaxed/simple;
	bh=C97P2/ckRvHMo73Rd6quud9TJ72euOWfvwrSRa/GIE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qY3SS9xaq0Acqj9eOexlPehWkwudnSuJ3SwyeeaRmY5zdf5t0hyZTX8rmqh/ZItPIwcbxmjTkqHeqvLjQhfnrq8bTrNROfc7BHY9r47+YvMXxO5eeYAqa0LnhnWDKNnhR77ngiEMhPzE7LhyxUroFB0SMNHrb+J68vlt0d1f8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRnBX/3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRnBX/3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F601F000E9;
	Thu, 13 Aug 2026 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633736;
	bh=e56j2MpaZlrQrdzuNl4pLzfP/+mjlmZz5JJG5kW85bA=;
	h=From:To:Cc:Subject:Date;
	b=YRnBX/3Rq39uCfRVaWZaV5Mjt8MeTmeSlflDfnZQFk0aImZnNhuMFdco60/hIES3J
	 lqwJh/CvzXMVd5q+00Vos2WYFyvmmrYI2waPB4TvjMIpr549pI31p80dONeOiNPQU4
	 0eZsfmwHIRc+1IV/kcq9vNUb07vI1IUcOqc5+bJq3BUtIQ55T2UMkmbIvoOQRt09+8
	 Iqp+f4ooG9FDEouVcQZUGJOfnTDN2ABozt2h/zXwY27OgLeo58IRfU+IfMGBpremx4
	 Fpxt3Kd0Af/JgrxOxQAywZ+04ccvNijnDFaPtN1v6LdKvf36LQaSmH+J3yBKZlj/KO
	 ihibzcqlCccbg==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] src/locktest.c: fix build failure of struct delegation
Date: Thu, 13 Aug 2026 23:08:46 +0800
Message-ID: <20260813150846.280498-1-zlang@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since glibc commit f2e3dacbff88 ("Add new constants from Linux 6.12,
6.18 and 6.19 to bits/fcntl-linux.h"), the F_GETDELEG and F_SETDELEG
constants from Linux 6.19 have been added directly into <fcntl.h>.
However, the corresponding full definition for 'struct delegation'
was not included in glibc's userspace wrapper. That causes below
build error:

 locktest.c:1065:16: error: variable 'deleg' has initializer but incomplete type
  1065 |         struct delegation deleg = { .d_type = F_UNLCK };
 ...

Fix this by isolating the definition of 'struct delegation' from the
command macros via autoconf capability probing:

1. Add an AC_CHECK_TYPES check for 'struct delegation' in configure.ac.
2. In locktest.c, unbind 'struct delegation' from the '#ifndef F_GETDELEG'
   guard and wrap it with '#ifndef HAVE_STRUCT_DELEGATION' instead.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

fstests currently fails to build against the latest glibc, with the root
cause detailed in the commit log above.

The glibc now defines F_GETDELEG and F_SETDELEG, but leaves out the actual
'struct delegation' definition. The complete struct is available in <linux/fcntl.h>,
but we cannot simply include both <fcntl.h> and <linux/fcntl.h> due to nasty
namespace redefinition conflicts.

I am not entirely sure if glibc will bring in 'struct delegation', so for now,
I chose to decouple and handle the structure definition independently via
autoconf.

Any thoughts or better suggestions on how we should handle this transition?

Thanks,
Zorro

 configure.ac   | 4 ++++
 src/locktest.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index feb24ddd..6d7ff3ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -111,6 +111,10 @@ AC_CHECK_TYPES([struct btrfs_ioctl_received_subvol_args], [], [], [[
 #include <stddef.h>
 #include <linux/btrfs.h>
 ]])
+AC_CHECK_TYPES([struct delegation], [], [], [[
+#include <stddef.h>
+#include <fcntl.h>
+]])
 AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
 AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
 #include <stddef.h>
diff --git a/src/locktest.c b/src/locktest.c
index 54ee1f07..d0264c94 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -80,7 +80,9 @@ extern int h_errno;
 #ifndef F_GETDELEG
 #define F_GETDELEG	(1024 + 15)
 #define F_SETDELEG	(1024 + 16)
+#endif
 
+#ifndef HAVE_STRUCT_DELEGATION
 struct delegation {
 	uint32_t d_flags;
 	uint16_t d_type;
-- 
2.55.0

