Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B74EB64DC
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Jun 2023 18:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjF0Se7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjF0Seh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Jun 2023 14:34:37 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 11:34:10 PDT
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066C1715
        for <fstests@vger.kernel.org>; Tue, 27 Jun 2023 11:34:10 -0700 (PDT)
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by forward204b.mail.yandex.net (Yandex) with ESMTP id 8813E6786E
        for <fstests@vger.kernel.org>; Tue, 27 Jun 2023 21:28:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160b:0:640:acd0:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 29048600A7
        for <fstests@vger.kernel.org>; Tue, 27 Jun 2023 21:27:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uRQg252Da4Y0-Sf5H6dXY;
        Tue, 27 Jun 2023 21:27:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687890477;
        bh=KJSfqBMqWCCUl6t0L6QeA1IPZPj4uPbhU3NQNEY5NoY=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=c6bV4Rio7xYbRgZYqMuoyOuNPP83Bg/LYoVYm5hPhxOHbb0dAnCcKbq68+a7vpWys
         c5Rj0FkZPDV45u4vsmDKW6/IKN3/QyNQ67g90M/prmMqydO7J3JOEY9ZV0zd2XTIIF
         3iQ7wOzZqzPsLPaCeN2pso4CuO5Ow+fkqu4O7Pmg=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     fstests@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>
Subject: [PATCH] support busybox modprobe
Date:   Tue, 27 Jun 2023 23:27:31 +0500
Message-Id: <20230627182731.3428042-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This modprobe writes help to stderr.
We need to redirect it to stdout, or it will end up in a test results.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index e479df8d..936ac225 100644
--- a/common/config
+++ b/common/config
@@ -261,7 +261,7 @@ export UDEV_SETTLE_PROG
 # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
 # modprobe removal to run forever trying to remove a module.
 MODPROBE_REMOVE_PATIENT=""
-modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"
+modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "remove-patiently"
 if [[ $? -ne 0 ]]; then
 	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
 		# We will open code our own implementation of patient module
-- 
2.39.2

