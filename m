Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AF241665
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284246; cv=none; b=bQ/5eKU//mUdZopizxvjglJM5ae7XWm+rT3iPmMg2eat/mfvn9zHX8G2Blc+4HURPo4I0wjVLPl2+Gh4LozYOu8bldfjEvMjZKvjAWU5Nu4mBJJpBIXM33uwYew+JMkmFhZROBFJ53HbBFThAfMs2K9TjrJDndgGvyxPHzefZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284246; c=relaxed/simple;
	bh=Bp2C0v0CSTXNBOYkrZqXhZrH93cfGqEh+FuXJLgy+os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfT6qS0n4LCqDgGUvm/cFBe6DGoYs8OyRoocSbpN7Bvu05isZwUT1dlt1bhOD45Vv881EqBZVJIWYbEso9d34s3xaxJ9726Quhk5guvXcqTg1C6NtcOKA71OBnrezepMj0ja+vIjYDHKX1wmD/SO1xqSTPFy6yXSgbM4SBDqQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF8aEgDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF8aEgDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4E1F000E9;
	Wed, 20 May 2026 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284245;
	bh=jX6URKb/X67sWa1KawZE+pB/vLdlTQNdATQGuCiTen4=;
	h=From:To:Cc:Subject:Date;
	b=ZF8aEgDiVyL1EqLSxj4+byYY8k0mWCxTNw6a5p1YH/UbNutyjORdYtLSnPZpGfEaj
	 ryto2c/o71S1fUoOPsg+ASq0dcHr8hnWiQGq0MkTyZF3A7ZCnaUImOvolpm4ZnNz8z
	 8Bgsu9e47Sd3Gs8OLHC2l264N8WAThczhCVGegxWlRmg1Tb6PKxna19NM/02F3pfxb
	 D5Iji3Qjr/2IaBjxSekMzRbYqedF94CBMdtzLU8X+3Y4WRrMC8nVSyARcWgeflG5Eg
	 7xi0SWgvpg7PtrZq76PpoiLlEapiYfOoP+mf8v5xZ7c4nYoHX25lXaHgel/1Ol/sOA
	 JFbtYu3I/GjRg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: djwong@kernel.org,
	fstests@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH] generic/791: don't run if kernel misses FANOTIFY
Date: Wed, 20 May 2026 15:37:15 +0200
Message-ID: <20260520133719.573809-1-aalbersh@kernel.org>
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
 src/fs-monitor.c  |  9 ++++++---
 tests/generic/791 | 10 +++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/fs-monitor.c b/src/fs-monitor.c
index 0cf09677a3ef..28436ec2336f 100644
--- a/src/fs-monitor.c
+++ b/src/fs-monitor.c
@@ -117,6 +117,7 @@ next_event:
 int main(int argc, char **argv)
 {
 	int fd;
+	int error;
 
 	char buffer[BUFSIZ];
 
@@ -126,15 +127,17 @@ int main(int argc, char **argv)
 	}
 
 	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
+	error = errno;
 	if (fd < 0) {
 		perror("fanotify_init");
-		errx(1, "fanotify_init");
+		errx(error, "fanotify_init");
 	}
 
 	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
 			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
+		error = errno;
 		perror("fanotify_mark");
-		errx(1, "fanotify_mark");
+		errx(errno, "fanotify_mark");
 	}
 
 	printf("fanotify active\n");
@@ -144,7 +147,7 @@ int main(int argc, char **argv)
 		int n = read(fd, buffer, BUFSIZ);
 
 		if (n < 0)
-			errx(1, "read");
+			errx(errno, "read");
 
 		handle_notifications(buffer, n);
 	}
diff --git a/tests/generic/791 b/tests/generic/791
index 90242292cba2..1d3a6c181011 100755
--- a/tests/generic/791
+++ b/tests/generic/791
@@ -123,10 +123,18 @@ fi
 _dmerror_unmount
 _dmerror_mount
 
-$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor &
+$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor 2>&1 &
 fsmonitor_pid=$!
 sleep 1
 
+if ! kill -0 $fsmonitor_pid 2>/dev/null; then
+	wait $fsmonitor_pid
+	# Function not implemented
+	if [ $? -eq 38 ]; then
+		_notrun "Kernel doesn't support fanotify"
+	fi
+fi
+
 _dmerror_mark_range_bad $bad_sector $bad_len
 
 cat >> $seqres.full << ENDL
-- 
2.51.2

