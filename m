Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:10774 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760069AbbA1Fjf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 28 Jan 2015 00:39:35 -0500
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] ext4/304: ignore EINVAL and ENODATA error
Date: Wed, 28 Jan 2015 13:33:46 +0800
Message-ID: <1422423226-12355-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dmonakhov@openvz.org, tytso@mit.edu, david@fromorbit.com, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

ext4/304 is also ext4 defragmentation stress test, which creates several
threads to perform defragmentation using 'inplace' mode, but there is a
possible race that the donor file has been truncated by thread_A, while
thread_B starts to call ioctl(EXT4_IOC_MOVE_EXT), then we may get a
EINVAL or ENODATA error.

Please see: http://www.spinics.net/lists/linux-ext4/msg46900.html for
detailed information.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 tests/ext4/304 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/ext4/304 b/tests/ext4/304
index b9b4356..01c51a4 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -61,6 +61,8 @@ filesize=${FILE_SIZE}
 size=999G
 buffered=0
 fadvise_hint=0
+continue_on_error=write
+ignore_error=,EINVAL:61
 
 #################################
 # Test4
-- 
1.8.3.1

