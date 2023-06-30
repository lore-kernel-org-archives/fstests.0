Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E7EB64DA
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jun 2023 09:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjF3JvC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjF3JvA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jun 2023 05:51:00 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4B1AE
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 02:50:50 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:9396:0:640:dd2a:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 7577260060
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 12:50:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id moKxLUCDaa60-pt29sftP;
        Fri, 30 Jun 2023 12:50:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688118649;
        bh=QF3waw2sijgT8WfMnZ/mIOCXbEyAtdRp25AnopZI5Dc=;
        h=Subject:From:To:Date:Message-ID;
        b=C1JcZANSkTFgbIXno6huVC2wwrm7VdY8DEk77boT7SxBDJ5G0hjK3X+F3yxBtb9wC
         v/648HIU6UJh9TaESUB7dNJa3QYLObvLoQnLJ1dTCg3ZDiTVkCerylK+EVVmOlNqf0
         WSO2S1F0AQ/iyg0BSQbTjYGt9YUHxkYrcfwhhFt4=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <817817a1-2f2d-1ee1-0898-f86801586d65@yandex.ru>
Date:   Fri, 30 Jun 2023 14:50:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     fstests@vger.kernel.org
From:   stsp <stsp2@yandex.ru>
Subject: generic/478: why eval is so fast?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi guys.

While playing with the test 478, I've
noticed something very strange. Namely,
this small patch, that only adds eval to
the script:

diff --git a/tests/generic/478 b/tests/generic/478
index 480762d2..45b801d0 100755
--- a/tests/generic/478
+++ b/tests/generic/478
@@ -106,24 +106,24 @@ do_test()
         # print options and getlk output for debug
         echo $* >> $seqres.full 2>&1
         # -s : do setlk
-       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
         # -g : do getlk
-       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
                 tee -a $seqres.full
         wait $!

         # add -F to clone with CLONE_FILES
         soptions="$1 -F"
         # with -F, new locks are always file to place
-       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
                 tee -a $seqres.full
         wait $!

         # add -d to dup and close
         soptions="$1 -d"
-       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
-       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
                 tee -a $seqres.full
         wait $!
  }


speeds up the test by 50-60%!
This is quite unbelievable, and probably
means such change breaks something.
But I have no idea what and how.
Can anyone come up with a good guess?

