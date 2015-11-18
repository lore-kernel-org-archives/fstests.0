Received: from mail.kernel.org ([198.145.29.136]:39030 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756AbbKRQK7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Nov 2015 11:10:59 -0500
From: fdmanana@kernel.org
Subject: [PATCH] Add more checks to _check_dmesg
Date: Wed, 18 Nov 2015 16:10:03 +0000
Message-Id: <1447863003-26291-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Teach _check_dmesg to look for improper RCU usage and circular locking
dependency messages. It's useful to check for these as they might point
to a real problem in the filesystem's implementation (or the current
implementation just confuses the checker, probably worth simplifying
the filesystem's implementation).

Currently the test btrfs/071 for example triggers such warnings:

[  912.924839] ===============================
[  912.925617] [ INFO: suspicious RCU usage. ]
[  912.926394] 4.3.0-rc5-btrfs-next-17+ #1 Not tainted
[  912.927274] -------------------------------
[  912.928364] fs/btrfs/volumes.c:1977 suspicious rcu_dereference_check() usage!
[  912.929626]
[  912.929626] other info that might help us debug this:
[  912.929626]
[  912.931197]
[  912.931197] rcu_scheduler_active = 1, debug_locks = 1
[  912.933822] 4 locks held by btrfs/6400:
[  912.934558]  #0:  (&fs_info->dev_replace.lock_finishing_cancel_unmount){+.+...}, at: [<ffffffffa046a193>] btrfs_dev_replace_finishing+0x3e/0x696 [btrfs]
[  912.948929]  #1:  (uuid_mutex){+.+.+.}, at: [<ffffffffa046a24a>] btrfs_dev_replace_finishing+0xf5/0x696 [btrfs]
[  912.950987]  #2:  (&fs_devs->device_list_mutex){+.+.+.}, at: [<ffffffffa046a263>] btrfs_dev_replace_finishing+0x10e/0x696 [btrfs]
[  912.953265]  #3:  (&fs_info->chunk_mutex){+.+...}, at: [<ffffffffa046a278>] btrfs_dev_replace_finishing+0x123/0x696 [btrfs]
(...)

[  912.987973] ======================================================
[  912.989242] [ INFO: possible circular locking dependency detected ]
[  912.990583] 4.3.0-rc5-btrfs-next-17+ #1 Not tainted
[  912.990801] -------------------------------------------------------
[  912.990801] btrfs/6400 is trying to acquire lock:
[  912.990801]  (&bdev->bd_mutex){+.+.+.}, at: [<ffffffff8119d202>] __blkdev_get+0xa3/0x3d9
[  912.990801]
[  912.990801] but task is already holding lock:
[  912.990801]  (&fs_info->chunk_mutex){+.+.+.}, at: [<ffffffffa046a278>] btrfs_dev_replace_finishing+0x123/0x696 [btrfs]
[  912.990801]
[  912.990801] which lock already depends on the new lock.
[  912.990801]
[  912.990801]
[  912.990801] the existing dependency chain (in reverse order) is:
(...)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 4c2f42c..dd50aa9 100644
--- a/common/rc
+++ b/common/rc
@@ -3055,6 +3055,8 @@ _check_dmesg()
 	     -e "Oops:" \
 	     -e "possible recursive locking detected" \
 	     -e "Internal error" \
+	     -e "INFO: suspicious RCU usage" \
+	     -e "INFO: possible circular locking dependency detected" \
 	     $seqres.dmesg
 	if [ $? -eq 0 ]; then
 		echo "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
-- 
2.1.3

