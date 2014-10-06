Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33492 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbaJFIm6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 6 Oct 2014 04:42:58 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so4886871pab.23
        for <fstests@vger.kernel.org>; Mon, 06 Oct 2014 01:42:57 -0700 (PDT)
From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH] xfstests/common: fix to test if ltp/fsstress valid
Date: Mon,  6 Oct 2014 12:42:10 -0400
Message-Id: <1412613730-53245-1-git-send-email-wangshilong1991@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: wangshilong1991@gmail.com
List-ID: <fstests@vger.kernel.org>

test if FSSTRESS_PROG is a null string dosen't make sense because
it has just been set.

Here fix it by testing if it is an executable file.

Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index d68d4d0..64506a2 100644
--- a/common/config
+++ b/common/config
@@ -135,7 +135,7 @@ export UMOUNT_PROG="`set_prog_path umount`"
 [ "$UMOUNT_PROG" = "" ] && _fatal "umount not found"
 
 export FSSTRESS_PROG="./ltp/fsstress"
-[ "$FSSTRESS_PROG" = "" ] && _fatal "fsstress not found"
+[ ! -x $FSSTRESS_PROG ] && _fatal "fsstress not found or executable"
 
 export PERL_PROG="`set_prog_path perl`"
 [ "$PERL_PROG" = "" ] && _fatal "perl not found"
-- 
1.8.3.1

