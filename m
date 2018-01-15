Received: from mail.cn.fujitsu.com ([183.91.158.132]:30999 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753590AbeAOHwX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jan 2018 02:52:23 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 1/3] common/xfs: Check if write supports [-c|-d] option in xfs_db
Date: Mon, 15 Jan 2018 15:48:30 +0800
Message-ID: <1516002512-3861-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180115062929.GB3102@eguan.usersys.redhat.com>
References: <20180115062929.GB3102@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: david@fromorbit.com, darrick.wong@oracle.com, fstests@vger.kernel.org, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Make sure _scratch_xfs_set_metadata_field() can be used on an
old xfsprogs-dev(e.g. v3.1.1).

The "-d" option was introduced since xfsprogs-dev v4.7.0 by commit
86769b3 ("xfs_db: allow recalculating CRCs on invalid metadata").

The special argument "--" is only used to end option-scanning
in getopt().  getopt() was introduced since xfsprogs-dev v3.2.3 by
commit c9f5e3d ("xfs_db: Allow writes of corrupted data")'.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 common/xfs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/xfs b/common/xfs
index 45b84a0..ab58364 100644
--- a/common/xfs
+++ b/common/xfs
@@ -658,8 +658,11 @@ _scratch_xfs_set_metadata_field()
 	for arg in "$@"; do
 		cmds+=("-c" "${arg}")
 	done
-	_scratch_xfs_db -x "${cmds[@]}" -c "write -d ${key} -- ${value}"
-	echo
+
+	local wr_cmd="write"
+	_scratch_xfs_db -x -c "help write" | egrep -q "(-c|-d)" && value="-- ${value}"
+	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)" && wr_cmd="${wr_cmd} -d"
+	_scratch_xfs_db -x "${cmds[@]}" -c "${wr_cmd} ${key} ${value}"
 }
 
 _scratch_xfs_get_sb_field()
-- 
1.8.3.1



