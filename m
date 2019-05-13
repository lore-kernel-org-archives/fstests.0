Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47626 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727272AbfEMGNd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 May 2019 02:13:33 -0400
From: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] common/rc: improve _fstyp_has_non_default_seek_data_hole()
Date: Mon, 13 May 2019 14:13:07 +0800
Message-Id: <1557727987-3788-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: caspar@linux.alibaba.com, amir73il@gmail.com, Jeffle Xu <jefflexu@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

commit 34081087 adds more sanity to seek_sanity_test(), where
some kinds of filesystem type should not only support default
behavior of SEEK_HOLE, that is, always returns EOF. A hardcoded
whitelist is maintained to distinguish whether a filesystem type
is allowed to only support default behavior or not.

In this whitelist, NFS is not allowed to support default behavior
only. However as far as I know, nfsv2 and nfsv3 only support
default behavior of SEEK_HOLE in linux.

On the other hand, xfstests uses "mount -t nfs ..." to mount a
NFS mount point. Normally the mount point is mounted on nfsv4,
but it can be mounted mandatorily on nfsv3 if we specify
"Nfsvers=3" in /etc/nfsmount.conf. And in this case, a series of
tests fail (including generic/285, generic/448, generic/490, et
cetera) with error message "Default behavior is not allowed.
Aborting."

So I just make some special handling for NFS in
_fstyp_has_non_default_seek_data_hole(), that is, default behavior
of SEEK_HOLE is acceptable for nfsv2 and nfsv3.

I'm not sure how nfsv2 and nfsv3 behave SEEK_HOLE in other OS other
than linux, and any comment is welcomed if I misunderstand the
SEEK_HOLE behavior of nfsv2/nfsv3 in linux.

Thanks.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index cbd3c59..83e9729 100644
--- a/common/rc
+++ b/common/rc
@@ -2315,9 +2315,15 @@ _fstyp_has_non_default_seek_data_hole()
 	fi
 
 	case "$fstyp" in
-	btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|nfs*|ocfs2|tmpfs)
+	btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|ocfs2|tmpfs)
 		return 0
 		;;
+	nfs*)
+		# NFSv2 and NFSv3 only support default behavior of SEEK_HOLE,
+		# while NFSv4 supports non-default behavior
+		local nfsvers=`_df_device $TEST_DEV | $AWK_PROG '{ print $2 }'`
+		[ "$nfsvers" = "nfs4" ] && return 0 || return 1
+		;;
 	overlay)
 		if [ ! -z $OVL_BASE_FSTYP -a $OVL_BASE_FSTYP != "overlay" ]; then
 			_fstyp_has_non_default_seek_data_hole $OVL_BASE_FSTYP
-- 
1.8.3.1
