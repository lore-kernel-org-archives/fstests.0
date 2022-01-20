Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE63C43219
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Jan 2022 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiATLFX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiATLE7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Jan 2022 06:04:59 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BCC061401
        for <fstests@vger.kernel.org>; Thu, 20 Jan 2022 03:04:59 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id w21so10075537uan.7
        for <fstests@vger.kernel.org>; Thu, 20 Jan 2022 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devo.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bn7mqHIi6Rs0C9Fu2E6W0TZYU8fmzSKBgsdNjYJlIMc=;
        b=MsJpcvm4zlUeH7gl6cAY0hr4RGy9pit7m0tBRzXYigsJYj88eA3wp/IIT7VdBfp9hX
         /ognALq5GcsofU/M5MRL/IGRtEBSxpb0c9PXeVrVznxjqccW6Kos4oy5SkxqsFsuyxCK
         wvhacNfrJvKtTB9eki8M3UppIzzwtCGVDF/fu8SxHvpy8HT0r7+qD8xuAKIBfBhJZpL9
         hLKEH4UHJpqrpJaTTFAhWybRPvsgcGLMYYsKiYUgBbpgoMmNgJzPewA22LhouS/ru2Mt
         zRdcGrZ08cajkxSTqj2sLcVmLpmfS1BHMCuJkF7fyt883H/JDKccwNN/j5sgFNajwa0B
         4VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bn7mqHIi6Rs0C9Fu2E6W0TZYU8fmzSKBgsdNjYJlIMc=;
        b=5qCTbvwzMRggVKKqLkSTO468fxqkh7A8Vai/5fm+AHwcZ/MDI0kt0AdBm3cYZ3/YRR
         s4Ud9VJ44N4+8nf3zrCmZTJmw9OEUrFwhGWfUaUYbSZ8oyv0fhHbR/yvl/6tOK2ELc2W
         ntEKlvEjC401akNbqLaivHwbqwN0ldjxSRpFeWzGH+Gm2eQl8cLsvLDtkN0f6ndqW3fs
         68XBMXn8LLSQFArqvkzi1YCWzdJE+YaDgljP+qaN2g9L+CKTQx/Iky/8XZa7bs/8wapk
         BqUTH6DjTtKFTGiLgzB4RHwTYSLrWAZNoOdsMaCDqjQHgDTzfyD5yYCZRDMbraTbgvdP
         ZQNA==
X-Gm-Message-State: AOAM530yQjzuLswjhGyZ/1JtHRIIrAoWa3t0OFUXPEtEsrGAcYnJKgRK
        B2ZaTFpttVD6LOSMiLzojcMK87yPKc4SG0ZXRAbTt/K6xfsLg6WQvlrRfmWIHsx/wkZlakDwe6x
        6T2LZ0t1qeiIzULZ/2gDAVzF627mfwKlV+i67
X-Google-Smtp-Source: ABdhPJwBgCLkEEuyRQijjJ4fBU75UxFYzUI42MF8zZA+pIVEOm3/JNOuRQ+tgLT72avQCeQHKx0Ms4eaF9GkHLyQvAg=
X-Received: by 2002:ab0:6f13:: with SMTP id r19mr7455426uah.132.1642676698425;
 Thu, 20 Jan 2022 03:04:58 -0800 (PST)
MIME-Version: 1.0
From:   Andrea Tomassetti <andrea.tomassetti@devo.com>
Date:   Thu, 20 Jan 2022 12:04:47 +0100
Message-ID: <CAG2S0o-wJc-2_wm=35mE5Lt0e4idXwb3g5ezc9=LdWrLHfRM_Q@mail.gmail.com>
Subject: xfs/311 test pass but leave block device unusable
To:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,
I was using the (x)fstest utility on the Kernel 5.11 to try to
reproduce some xfs-related issues:
  INFO: task xfs-conv/dm-3:1360 blocked for more than 120 seconds.
  Workqueue: xfs-conv/dm-3 xfs_end_io [xfs]
   Call Trace:
    __schedule+0x44c/0x8a0
    schedule+0x4f/0xc0
    xlog_grant_head_wait+0xb5/0x1a0 [xfs]
    xlog_grant_head_check+0xe1/0x100 [xfs]

When I realized that xfs test n. 311 was passing correctly but every
further attempt to use the block device (e.g. mount it) was failing.
The issue is reproducible after reboot.

Test passed:
  ./check xfs/311
  FSTYP         -- xfs (non-debug)
  PLATFORM      -- Linux/x86_64 test 5.11.0-1021-aws
#22~20.04.2-Ubuntu SMP Wed Oct 27 21:27:13 UTC 2021
  MKFS_OPTIONS  -- -f /dev/xvdz
  MOUNT_OPTIONS -- /dev/xvdz /home/test/z

  xfs/311 25s ...  25s
  Ran: xfs/311
  Passed all 1 tests

Fail:
  # mount /dev/xvdz /home/test/z/
    mount: /home/test/z: /dev/xvdz already mounted or mount point busy.
    [ 2222.028417] /dev/xvdz: Can't open blockdev

lsof does not show anything that is using either /dev/xvdz or /home/test/z

Any idea why is this happening?

The `xlog_grant_head_wait` race issue has been resolved in a later
Kernel version, am I right?

Best regards,
Andrea

--=20







The contents of this email are confidential. If the reader of this=20
message is not the intended recipient, you are hereby notified that any=20
dissemination, distribution or copying of this communication is strictly=20
prohibited. If you have received this communication in error, please notify=
=20
us immediately by replying to this message and deleting it from your=20
computer. Thank you.=C2=A0Devo, Inc; arco@devo.com <mailto:arco@devo.com>;=
=C2=A0=C2=A0
Calle Est=C3=A9banez Calder=C3=B3n 3-5, 5th Floor. Madrid, Spain 28020

