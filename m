Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA00C4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Apr 2022 20:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiDFUOf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiDFUN2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Apr 2022 16:13:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B9219ACF
        for <fstests@vger.kernel.org>; Wed,  6 Apr 2022 11:08:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so3190740pfb.4
        for <fstests@vger.kernel.org>; Wed, 06 Apr 2022 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=MS05tRFBmXvcuR8TxPOeThX9zUILwksExKqE5Z8Dyeo=;
        b=CM0i7rZYNboPcxd74POrUKalzqDh0t0rmblP1vTb/zZMDDqu2n/BTiga5UPLJ8ksEd
         nAy8MKFll7lSUkKdMV9XEL9vkoWsBVFER5oJBi1VMjavH0l4EDXcHVN4S08qp2zrEthY
         24zsm9+LB8sq2X5Kv685ASsUSXF/w4b7+UH1rXyk5L/h7S2MhJZZSDCZetYcD8HG2R9W
         FBbPXLuN2ViTbfwvOTAg+lRnsj+lksun1bfg8moBdAMKgcvYde7YaUE+slZid1EYLoMl
         Pg0dB9p8/WwmJNYKQN2WS5o1qOXKpwGht+Z9BPzsG/Ll/sL4UYY21/g/pMoTBvD5KfvJ
         0g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=MS05tRFBmXvcuR8TxPOeThX9zUILwksExKqE5Z8Dyeo=;
        b=aY26eSADKauI5nNvTIPR1zhliC7oDWy3ih1jSZUJ7HSP7ZBL+gl6O1jF/2HCBS/TZ4
         bfxqt4wNPjcsPWDVg7bzhcKirs2/UPh8YwIq2tcV2LutZ91GWV+OHeyj+NCMUv4290Cm
         9Y/bw/w/58Rt0oLa+PCxLnw640cN0C3MlzlW5qLOsKEWFLlEFqxYvJr7Wz6EjuyjSQL8
         n4qHY42ZTeEvVtNC4SHQQbBVxG1iUFnZxcrjlrKyOdrTjFHRobp839MJp6Nom4sUBDjW
         hyxFP5Zl3HYN26x4LZ0GxR3+VpYziIJWb0BdxL99udCRcviY3nsGQNjvIkBMjOajQylU
         hOyQ==
X-Gm-Message-State: AOAM533AqidOSCssqgH+tYrZ96wmnAIYjs5bEEqA9N6yhbKfk52it6uH
        /+lotA91RhCo1a+k2FdvMxA=
X-Google-Smtp-Source: ABdhPJzREmFIkYPEDQgsSmmw6+xLABiM/Oy9rHLM2+9/VH6cXWvxm72Qh0ktlgv1l6MCJjNz5oh+XA==
X-Received: by 2002:a63:dc44:0:b0:381:5720:88a5 with SMTP id f4-20020a63dc44000000b00381572088a5mr8196934pgj.219.1649268511389;
        Wed, 06 Apr 2022 11:08:31 -0700 (PDT)
Received: from localhost ([2406:7400:63:b4e6:5967:b872:39cd:bdb9])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a1c0200b001c994db1960sm7234891pjs.10.2022.04.06.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:08:30 -0700 (PDT)
Date:   Wed, 6 Apr 2022 23:38:26 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: "Operation not permitted" message with "-g encrypt" in xfstests
Message-ID: <20220406180826.6wdjr3zwzedstbft@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

Needed some help on "encrypt" group tests in fstests.

so when I run "./check -g encrypt". All my tests (ext4) fails with
"keyctl_session_to_parent: Operation not permitted" print.

for e.g.
qemu-> sudo ./check -s ext4_4k tests/ext4/024
SECTION       -- ext4_4k
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 qemu 5.17.0-rc5+ #25 SMP PREEMPT Tue Apr 5 14:10:07 CDT 2022
MKFS_OPTIONS  -- -I 256 -O 64bit -F -b 4096 /dev/loop3
MOUNT_OPTIONS -- -o data=ordered /dev/loop3 /mnt1/scratch

ext4/024 1s ... - output mismatch (see /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/024.out.bad)
    --- tests/ext4/024.out      2022-03-30 21:07:38.117980201 +0000
    +++ /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/024.out.bad     2022-04-06 17:49:25.653513710 +0000
    @@ -1,2 +1,3 @@
     QA output created by 024
    +keyctl_session_to_parent: Operation not permitted
     Didn't crash!
    ...
    (Run 'diff -u /home/qemu/src/tools/xfstests-dev/tests/ext4/024.out /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/024.out.bad'  to see the entire diff)
Ran: ext4/024
Failures: ext4/024
Failed 1 of 1 tests

SECTION       -- ext4_4k
=========================
Ran: ext4/024
Failures: ext4/024
Failed 1 of 1 tests


On further investigation what I notice is -

When I run below command in qemu "sudo keyctl new_session" (which I think is
also done by _new_session_keyring()), it returns "Operation not permitted"

i.e.
qemu-> sudo keyctl new_session
keyctl_session_to_parent: Operation not permitted

Is this because there is already some existing session or something?
So when I do "sudo keyctl show", I see below.

qemu-> sudo keyctl show
Session Keyring
 699777301 --alswrv   1000  1000  keyring: _ses
  63328941 ---lswrv   1000 65534   \_ keyring: _uid.1000

Could you please help with what am I missing here?
So for now I ran with the tests with below diff, which ignores this operation
not permitted print message. With this all the tests passes.

diff --git a/common/encrypt b/common/encrypt
index f90c4ef0..a0920664 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -203,7 +203,7 @@ TEST_KEY_IDENTIFIER="69b2f6edeee720cce0577937eb8a6751"
 # the session keyring scoped to the lifetime of the test script.
 _new_session_keyring()
 {
-       $KEYCTL_PROG new_session >>$seqres.full
+       $KEYCTL_PROG new_session >>$seqres.full 2>&1
 }

 # Generate a key descriptor (16 character hex string)

But is there anything else which I should check to confirm "-g encrypt" tests
actually gets excercised?

Also, do you know why this "operation not permitted" error while running with sudo?
Do I need to change anything at my end? Or does this needs fixing at fstests level?

I agree by spending more time in understanding the encryption stack and how it
is interacting with different kernel subsystems, I should be able to figure this
out. But I assumed, that this test should ideally run out of box, if not then there
is something very basic I am missing. I needed this for testing some basic cleanup
work which I am doing in ext4 related to CONFIG_FS_ENCRYPTION.
And wanted to make sure I test those changes against "-g encrypt" in fstests.

Please feel free to point me to the doc which I can refer for more information
about this.

Thanks for your help!
-ritesh
