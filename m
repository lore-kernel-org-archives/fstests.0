Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7934BA5A
	for <fstests@vger.kernel.org>; Thu, 21 May 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352014; cv=none; b=eWCYimTZ+DZlT9jTvxUwG3xhpmbeH7aoREAXLzu5R7fJ1AV/fm5tcuYGNMzwoe1BVJXxgZrDEE+E4IO352ZHM3sScM7m5WdDnrY696FVMCqc7d3fWiM377M5EOfAJrR32hA82IgAZubjIJFmNDgkUaZT5LOowE0oCjZj1xt7UFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352014; c=relaxed/simple;
	bh=t+dYFwwroJ79g56ofZ3qsKwAvGkXesZ9n+pOyfyXENY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXe3J33bdQi+tkDLpAd3eZubDgj/VPiCw3LKamqk0VHce/UTCT+cH9NGZ6csz2N1uCmiJL/Wf3uhp+VisC50IbVD5q+nleMWaevki5TewIxqHzvn+7Z5bSpMm6KOqzErsP0I8sLodCrIiorwU8XHuUGpD4ojA+krLjW/PFxkVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUwIU+qN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUwIU+qN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C11F000E9;
	Thu, 21 May 2026 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779352013;
	bh=naG/5zhiSvTW5dBxlfjMY9yH1v7DNjIU6EpkDGI13ec=;
	h=From:To:Cc:Subject:Date;
	b=gUwIU+qNU0Wq+sZmqz7xYj9qSxXJs94bHlGDC0MHVw56EVTSJmQR2jEAmTEVfLN+l
	 v9MZdwxdzZKmvhh7bnST+dursijd7Q0FRjUnb04SirtfS3BRu6mrwDP/nXfqBWbULV
	 XjyfT9p1jz0SlDiEPSRkFHYOAKA/LAVYcWSQTaQhXmlqT4X7gIPOWocQrcNOgnoGlt
	 wS/ZNrCUkv7lkqJWh10mfWlMneadZJEaY90AxWjZCvafyOxFLmIklM3CBLvARxaM/Q
	 y0C1/2+vfYRDoyxM9/ULtqeb0yBm1uAeH5E1toXOwuJvl+6+kgNH0XcGqHRkwbPzIi
	 X/BTj7ZSRWTUQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: djwong@kernel.org,
	fstests@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v2] generic/791: don't run if kernel misses FANOTIFY
Date: Thu, 21 May 2026 10:26:46 +0200
Message-ID: <20260521082648.843312-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FANOTIFY=no in the kernel, then fs-monitor will fail to start. Fix
fs-monitor error codes to detect and skip the test on "Function not
implemented" code.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes from v1:
- Remove returning of errno
- Instead of checking for error code add new -c argument to fs-monitor

---
 src/fs-monitor.c  | 19 ++++++++++++++++++-
 tests/generic/791 |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/fs-monitor.c b/src/fs-monitor.c
index 0cf09677a3ef..dd91a5d7f623 100644
--- a/src/fs-monitor.c
+++ b/src/fs-monitor.c
@@ -117,6 +117,8 @@ next_event:
 int main(int argc, char **argv)
 {
 	int fd;
+	int opt;
+	int check = 0;
 
 	char buffer[BUFSIZ];
 
@@ -125,14 +127,29 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	while ((opt = getopt(argc, argv, "c")) != -1) {
+		switch (opt) {
+		case 'c':
+			check = 1;
+			break;
+		default:
+			fprintf(stderr, "Usage: %s [-c] path\n",
+				argv[0]);
+			exit(EXIT_FAILURE);
+		}
+	}
+
 	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
+	if (check)
+		exit(fd < 0);
+
 	if (fd < 0) {
 		perror("fanotify_init");
 		errx(1, "fanotify_init");
 	}
 
 	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
-			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
+			  FAN_FS_ERROR, AT_FDCWD, argv[optind])) {
 		perror("fanotify_mark");
 		errx(1, "fanotify_mark");
 	}
diff --git a/tests/generic/791 b/tests/generic/791
index 90242292cba2..edefbb7767c3 100755
--- a/tests/generic/791
+++ b/tests/generic/791
@@ -65,6 +65,9 @@ _dmerror_mount >> $seqres.full 2>&1
 
 test $FSTYP = xfs && _xfs_force_bdev data $SCRATCH_MNT
 
+$here/src/fs-monitor -c $SCRATCH_MNT &> /dev/null || \
+		_notrun "fanotify too old"
+
 # Write a file with 4 file blocks worth of data, figure out the LBA to target
 victim=$SCRATCH_MNT/a
 file_blksz=$(_get_file_block_size $SCRATCH_MNT)
-- 
2.51.2

