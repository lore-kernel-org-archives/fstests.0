Received: from mx1.redhat.com ([209.132.183.28]:53042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030356AbdDZVP7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 17:15:59 -0400
Subject: [PATCH] statx: Kill fd-with-NULL-path support in favour of
 AT_EMPTY_PATH
From: David Howells <dhowells@redhat.com>
Date: Wed, 26 Apr 2017 22:15:55 +0100
Message-ID: <149324135581.24512.17200609423997054366.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>, linux-kernel@vger.kernel.org, fstests@vger.kernel.org, dhowells@redhat.com, Michael Kerrisk <mtk.manpages@gmail.com>, linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
List-ID: <fstests@vger.kernel.org>

[!] NOTE: This breaks UAPI introduced in 4.11-rc1.

With the new statx() syscall, the following both allow the attributes of the
file attached to a file descriptor to be retrieved:

	statx(dfd, NULL, 0, ...);

and:

	statx(dfd, "", AT_EMPTY_PATH, ...);

Change the code to reject the first option, though this means copying the
path and engaging pathwalk for the fstat() equivalent.  dfd can be a
non-directory provided path is "".

Fixes: a528d35e8bfc ("statx: Add a system call to make enhanced file info available")
Reported-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Sandeen <sandeen@sandeen.net>
cc: fstests@vger.kernel.org
cc: linux-api@vger.kernel.org
cc: linux-man@vger.kernel.org
---

 fs/stat.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index c6c963b2546b..3d85747bd86e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -547,13 +547,13 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 /**
  * sys_statx - System call to get enhanced stats
  * @dfd: Base directory to pathwalk from *or* fd to stat.
- * @filename: File to stat *or* NULL.
+ * @filename: File to stat or "" with AT_EMPTY_PATH
  * @flags: AT_* flags to control pathwalk.
  * @mask: Parts of statx struct actually required.
  * @buffer: Result buffer.
  *
- * Note that if filename is NULL, then it does the equivalent of fstat() using
- * dfd to indicate the file of interest.
+ * Note that fstat() can be emulated by setting dfd to the fd of interest,
+ * supplying "" as the filename and setting AT_EMPTY_PATH in the flags.
  */
 SYSCALL_DEFINE5(statx,
 		int, dfd, const char __user *, filename, unsigned, flags,
@@ -567,11 +567,10 @@ SYSCALL_DEFINE5(statx,
 		return -EINVAL;
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
+	if (!filename)
+		return -EINVAL;
 
-	if (filename)
-		error = vfs_statx(dfd, filename, flags, &stat, mask);
-	else
-		error = vfs_statx_fd(dfd, &stat, mask, flags);
+	error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
 

