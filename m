Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543C38DC68
	for <fstests@vger.kernel.org>; Fri, 31 Jul 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489137; cv=none; b=S86rReTSpBrTMSFYpU0f5d0eoajKJPvvJlOMscFx2RFGOMXo4WzCTgwEXzjIkm9A3KRkZIl76SrJK39Ghi8GSY7JoxXWcolHPaH4nan1NhlalJfqjOzh4vOs1RWPvd23Rvol6bZo4eCz7+WAvTSLgtSaBQg8XnSdZXBmTuvvs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489137; c=relaxed/simple;
	bh=uNu4IYoa3tOQzzVvjvAk3akKqe5wlnUl0kRFzxD9UHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxJjbVuGIeli7R9e619FUXjxE8eXR0KN9W/9E9ovtjxMBS1fqcysMrKwK/mdefClTorLnY8YNycEV1GgaY2TYW2VLQJ9XM2loTBpD0LZ0SKkTmWzgEuPMfZo16ztOpfIca7COAW5G7GjaiTIfBmbVZhc9+TcUs7NZ8H+9JQgRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hBL0P0jJQzYQthS
	for <fstests@vger.kernel.org>; Fri, 31 Jul 2026 17:11:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4DE0E4057D
	for <fstests@vger.kernel.org>; Fri, 31 Jul 2026 17:12:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCX0kHfZmxqzCphAg--.6418S4;
	Fri, 31 Jul 2026 17:12:01 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: zlang@kernel.org,
	brauner@kernel.org,
	fstests@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH] idmapped-mounts: probe O_TMPFILE support with the caller's mapped id
Date: Fri, 31 Jul 2026 17:02:53 +0800
Message-ID: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCX0kHfZmxqzCphAg--.6418S4
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7Zr1fXFWxur4kZrW8WFg_yoWxur18pa
	9Yqr98trWxtF1agw1DJFn7KFW3Kr4rGw1jqrnFkayfA3ZIkF9avr4IyF10y3s8CryfWa47
	XaykJ34UW3y3GF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUklb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26rWY
	6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnrnY7UUUU
	U==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Kernel commit 539dce114465 ("fs: refuse O_TMPFILE creation with an
unmapped fsuid or fsgid") made vfs_tmpfile() return -EOVERFLOW when the
caller's fsuid/fsgid has no mapping in the filesystem's user namespace
after applying the mount's idmapping. This is a no-op on non-idmapped
mounts and only takes effect on an idmapped mount that does not map the
caller.

The idmapped-mount testcases behind generic/696 and generic/697 build an
idmapping (e.g. "0 10000 10000") that covers host uid 10000-19999 but
not uid 0, then call openat_tmpfile_supported() from the parent process
that is still real root (fsuid 0). The probe now gets -EOVERFLOW, falls
into the log_errno() branch, and prints

  utils.c: 928: openat_tmpfile_supported - Value too large for defined \
data type - failure: create

to stderr. Both testcases expect "Silence is golden", so this spurious
output fails them, even though the kernel behavior is correct and the
testcases' own assertions all pass.

Move each openat_tmpfile_supported() call into the child, after
switch_ids()/switch_userns(), so it probes with the mapped identity the
tmpfile section uses. Silencing EOVERFLOW in openat_tmpfile_supported()
would make it indistinguishable whether the idmapping genuinely has no
mapping for any caller, or the probe just ran in the unmapped parent before
the switch.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 src/vfs/idmapped-mounts.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index ed9992f9..bfbe9042 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -3838,8 +3838,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -3849,6 +3847,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
 		if (!switch_ids(10000, 11000))
 			die("failure: switch fsids");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -4014,8 +4014,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -4025,6 +4023,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -4133,6 +4133,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		if (!caps_down_fsetid())
 			die("failure: caps_down_fsetid");
 
@@ -4257,6 +4259,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		if (!switch_userns(attr.userns_fd, 0, 1000, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		if (!caps_down_fsetid())
 			die("failure: caps_down_fsetid");
 
@@ -7733,8 +7737,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7752,6 +7754,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
 		if (!switch_ids(10000, 11000))
 			die("failure: switch fsids");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -7947,8 +7951,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	/*
 	 * Below we verify that setgid inheritance for a newly created file or
 	 * directory works correctly. As part of this we need to verify that
@@ -7984,6 +7986,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		if (!caps_down_fsetid())
 			die("failure: caps_down_fsetid");
 
@@ -8181,8 +8185,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8207,6 +8209,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
 		if (!switch_ids(10000, 11000))
 			die("failure: switch fsids");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8342,6 +8346,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
 		if (!switch_ids(10000, 11000))
 			die("failure: switch fsids");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8536,8 +8542,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	/*
 	 * Below we verify that setgid inheritance for a newly created file or
 	 * directory works correctly. As part of this we need to verify that
@@ -8580,6 +8584,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		if (!caps_down_fsetid())
 			die("failure: caps_down_fsetid");
 
@@ -8723,6 +8729,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
 		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		supported = openat_tmpfile_supported(open_tree_fd);
+
 		if (!caps_down_fsetid())
 			die("failure: caps_down_fsetid");
 
-- 
2.52.0

