Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04341C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Nov 2022 13:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKUNOa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUNO3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Nov 2022 08:14:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA601DF33
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 05:14:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v8so5145522edi.3
        for <fstests@vger.kernel.org>; Mon, 21 Nov 2022 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hL5iYCNYJT5CdfaY+BylUC9g4Yj0+Fyiqmr6KtQn1vE=;
        b=SJ0n9BGCNHZN7ZTRm2uV3ZVxyT/FY2VQf/AjpGsdiHsBc1oAiTyl6OaxV+My2+DAMl
         Y7pz8wTjyHMwhFAyT6Pf+pMdVNseoOss8yTUgvbNMds9QwHBSSJaUWzXDAatEXnPplVS
         2/9ZwW+Vg5p+SPMmqOmXOhDkih2DJYCXJx8Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL5iYCNYJT5CdfaY+BylUC9g4Yj0+Fyiqmr6KtQn1vE=;
        b=vlooeO/n858tuw5Tr0w3T6YlYGom10LYkm68yFR8JSaw93vHVUaUahkFH8eUcX7OEF
         XbunmdNGNDZPvmiS2x3NhrFuv6by/GSAOpOhquMqg50nBk0J+fZHnEmbhil+iGNBnqnY
         BazA6aQu0dFgfNzXULbMVJgpR1kKURRccjQ5501MumJ08AaarU2dxzwlrlAehiWDoRQp
         PR+iLpL2BeSDsO0P6RR50IhukbHXUD/X/YG6pK60cQp44xzhKiFreDhWEok4RqXoW5Ve
         qhoZEeshs6Ata597iIrXPC4NckWuxjWlPHYeymfvHl7HnTdh/KiBnsHnEdSoxLBDKwqI
         O93Q==
X-Gm-Message-State: ANoB5pmrku0FKT+qCOYnY4g2P4wyrXcUZWt0a1AL1YTWJsAoTDPj4zsY
        H36RTtEOnZvZ/3q8rSWtauTPtMB/cUxU05PtcHNW4A==
X-Google-Smtp-Source: AA0mqf6CkCLlvlbPBG7lbXZwKejw1tqr1gAqg5GXZcO1FPZlNWmSntkUVVVE7G9p9sIApKxgSEl9NVZ78UPr6zIsx+o=
X-Received: by 2002:a50:bb08:0:b0:469:1684:217d with SMTP id
 y8-20020a50bb08000000b004691684217dmr6579098ede.270.1669036464083; Mon, 21
 Nov 2022 05:14:24 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Nov 2022 14:14:13 +0100
Message-ID: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
Subject: sgid clearing rules?
To:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I'm looking at sgid clearing in case of file modification.  Seems like
the intent was:

 - if not a regular file, then don't clear
 - else if task has CAP_FSETID in init_user_ns, then don't clear
 - else if group exec is set, then clear
 - else if gid is in task's group list, then don't clear
 - else if gid and uid are mapped in current namespace and task has
CAP_FSETID in current namespace, then don't clear
 - else clear

However behavior seems to deviate from that if group exec is clear and
*suid* bit is not set.  The reason is that inode_has_no_xattr() will
set S_NOSEC and __file_remove_privs() will bail out before even
starting to interpret the rules.

This behavior is also codified in xfstests.  E.g. generic/683.out:

Test 1 - qa_user, non-exec file falloc
6666 -rwSrwSrw- TEST_DIR/683/a
666 -rw-rw-rw- TEST_DIR/683/a

vs

Test 9 - qa_user, non-exec file falloc, only sgid
2666 -rw-rwSrw- TEST_DIR/683/a
2666 -rw-rwSrw- TEST_DIR/683/a

and

Test 3 - qa_user, user-exec file falloc
6766 -rwsrwSrw- TEST_DIR/683/a
766 -rwxrw-rw- TEST_DIR/683/a

vs

_user, user-exec file falloc, only sgid
2766 -rwxrwSrw- TEST_DIR/683/a
2766 -rwxrwSrw- TEST_DIR/683/a

Should the S_IXGRP test be purged from is_sxid() to make this consistent?

Thanks,
Miklos
