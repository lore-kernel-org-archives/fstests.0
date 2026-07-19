Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657C175A6D
	for <fstests@vger.kernel.org>; Sun, 19 Jul 2026 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487169; cv=none; b=Q29PM2/IqxYI408sXdaYctqIf15HqydiozOv3spDfBtAnSb3JNqDjmhHXwjleh/woyT9fYuZoWYkVGj559/MMeq5dixK1rEFsIckzQP6GCl8dfKHWwXIKWGx/4SPcASHwvY+TTbt0DKD9s5JlgODU3VzmELCXhHVHHkUhtUhdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487169; c=relaxed/simple;
	bh=IG+aZ58wI0bvaLjDYBSQzWhuMEI0fIBg5E26WRQ2Cc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AB9tBy35iQlzVtSLlVgdaLGGNTmiE5xBCPwW8uTpqRmC/invwhbzTTinKyCYR2wPeWdD56nkqEDqs6Rb3I49vdbjERz4kiB+nrOePDvTnnR+kk0pPM/NYQZLmJhugD9emc6NALatqHSqkbKaeWiVzVnwsjKV0M2iTS1to0/wpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3nKhwwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3nKhwwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DC1F000E9
	for <fstests@vger.kernel.org>; Sun, 19 Jul 2026 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784487168;
	bh=PxHXgDqXp7iCdxVllPe7rqbTo08sKxfyPHuP9JuttLk=;
	h=From:To:Subject:Date;
	b=R3nKhwwP/LPRrasCcBeUkOE0xKECWjUZvizlxBFtkjwYgcrGhsbNyK492deVI15SN
	 3BWZ0sv+Oxn3d0wGibxN/3Jtf/OSXy+zA3KBwcNIqCijcCyRbfJxrGlU6DrWowyASa
	 FIWGkfN7F2xtFHviobslououmHl/BukWByDXw/idjcuIid8MdbCj7Gx0WHMW1Aubz+
	 UBY3Ik81cgsnW5t4Y1UVU+vI6iCTk5noVVb+ccJpUmRZ4m2Cf0RAbT5yGjRtqyPgRk
	 WydvJTTo7xA8mvk3uo5h0EnTn45BXo0Vb5i0sNOPa8nf+oK9Tsezv2k0IKhDd+g8gX
	 GnuiAPvrx+yqw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [RFC PATCH] src/locktest.c: fix build failure of struct delegation
Date: Mon, 20 Jul 2026 02:52:38 +0800
Message-ID: <20260719185238.52370-1-zlang@kernel.org>
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
cause detailed in the commit log above. I'm tagging this patch as an RFC
since I'd like to get more feedback on whether this is the right approach.

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
index 441f543c..8967f117 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,6 +110,10 @@ AC_CHECK_TYPES([struct btrfs_ioctl_received_subvol_args], [], [], [[
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

