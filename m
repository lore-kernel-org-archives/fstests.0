Return-Path: <SRS0=vNf0=5C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE2C0044D
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 02:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC68920674
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Mar 2020 02:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cjr.nz header.i=@cjr.nz header.b="IYmQ8fXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCQCDq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:03:46 -0400
Received: from mx.cjr.nz ([51.158.111.142]:6342 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgCQCDq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Mar 2020 22:03:46 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 22:03:45 EDT
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 4EDEB80B79;
        Tue, 17 Mar 2020 01:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1584410130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yRXTp0jblktMjt9atXUkEG1/GYKPmQFKuJWCML32was=;
        b=IYmQ8fXlLNAREBUjsbQWDB+sVQ5HBY4wB/Q4Q43TPVOjWoswU5COtYIsRDpNaJnu0koLke
        GiH2bIYtmHG1y6PUiQkLbZ7//BVBpoJIz/NIX4HXj1N7SHCzLAHqdB+5j7GVm20KGW1TuQ
        g7atD3aFafbUTlhnIBirKyhyiEPqbKxHA+kx79sUdgMqI1nY9YYNgmiZz6AGKg2q6HCZq0
        P9BfJaD3szi7QtyyLrnP3RC8PKM+30/DVnXsycW2K4JgMXnD3j/iAWbfw3FGToStHHmZym
        uU11AwPCYDvjAzASb8gcsf/Z0rKAZnUUNZVQGXv14BrQf1lz4AYD32hsZezIrQ==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     fstests@vger.kernel.org
Cc:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH] generic/310: slightly improve check for dmesg error
Date:   Mon, 16 Mar 2020 22:54:39 -0300
Message-Id: <20200317015439.7406-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The 'grep -c "error"' check was causing false positive results for
cifs.ko when running it with 'echo 1 > /proc/fs/cifs/cifsFYI'.

That is, the test would fail when cifs.ko prints out a non-error
message like this:

  [ 2320.903987] fs/cifs/smb2maperror.c: Mapping SMB2 status code
  0x80000006 to POSIX err -61

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 tests/generic/310 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/310 b/tests/generic/310
index 1fcd517e4e6f..504f7c44c177 100755
--- a/tests/generic/310
+++ b/tests/generic/310
@@ -49,7 +49,7 @@ _require_command "$KILLALL_PROG" killall
 dmesg -c > /dev/null
 
 nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_error=`dmesg | grep -c "error"`
+nr_error=`dmesg | grep -c "EXT[234]-fs error"`
 nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 nr_warning=`dmesg | grep -c "^WARNING"`
 nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
@@ -58,7 +58,7 @@ nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 check_kernel_bug()
 {
 	new_bug=`dmesg | grep -c "kernel BUG"`
-	new_error=`dmesg | grep -c "error"`
+	new_error=`dmesg | grep -c "EXT[234]-fs error"`
 	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 	new_warning=`dmesg | grep -c "^WARNING"`
 	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
-- 
2.25.1

