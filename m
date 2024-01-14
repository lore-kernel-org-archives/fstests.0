Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001B2100
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E2B856410419
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 14:57:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dFBHcGhHjjiX; Sun, 14 Jan 2024 14:57:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 74EAA6410415;
	Sun, 14 Jan 2024 14:57:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c_jK_Ke9GrFB; Sun, 14 Jan 2024 14:57:25 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 465746410411;
	Sun, 14 Jan 2024 14:57:25 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: fstests@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] generic/020: Compute correct max_attrs for UBIFS
Date: Sun, 14 Jan 2024 14:57:13 +0100
Message-Id: <20240114135713.10555-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When testing on a MTD with a rather small erase block
size, the default max_attr limit can be too much and the
test will fail.
Instead compute the actual limit.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/config     | 1 +
 common/ubifs      | 9 +++++++++
 tests/generic/020 | 6 ++++++
 3 files changed, 16 insertions(+)
 create mode 100644 common/ubifs

diff --git a/common/config b/common/config
index c9771ff9..05f2bb35 100644
--- a/common/config
+++ b/common/config
@@ -545,6 +545,7 @@ _source_specific_fs()
 		;;
 	ubifs)
 		[ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol not found"
+		. ./common/ubifs
 		;;
 	esac
 }
diff --git a/common/ubifs b/common/ubifs
new file mode 100644
index 00000000..08323260
--- /dev/null
+++ b/common/ubifs
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+_get_leb_size()
+{
+	local ubivol=3D$1
+
+	cat /sys/class/ubi/`basename $ubivol`/usable_eb_size
+}
diff --git a/tests/generic/020 b/tests/generic/020
index da258aa5..4951b9e3 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -101,6 +101,12 @@ _attr_get_max()
 			let max_attrs=3D$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
 		fi
 		;;
+	ubifs)
+		LEB_SIZE=3D`_get_leb_size $TEST_DEV`
+		# On UBIFS, the number of xattrs has to be less than 50% LEB size
+		# divided by 160 (inode size)
+		let max_attrs=3D$((($LEB_SIZE / 2 / 160) - 1))
+		;;
 	*)
 		# Assume max ~1 block of attrs
 		BLOCK_SIZE=3D`_get_block_size $TEST_DIR`
--=20
2.35.3

