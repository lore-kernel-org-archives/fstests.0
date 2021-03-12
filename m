Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79602C433DB
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438EE64FA7
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCLNYI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:24:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhCLNXo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Mar 2021 08:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615555422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eqk2ewTMtmrT8wZQr3P/BizmB1Yzno25N3/VZwVg/1Q=;
        b=UfuLyOHU3ixOwUnFalFj3itTr9z/Iw3H3stInU9sAqDRAGDwpz3IUea/j5vUAXAFj4SIb7
        RjGgJKQ4fzqCt85ds7L7DKgEAprC345RpC5IqfvgW1y4lJfFC9xi+dBU9K6XN2KoQE/4U5
        8k3doxVesBPGRwgDNGWC20TJFZxk/4Y=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-9-W6Red0OT-Vv7NcfWjs5Q-1; Fri, 12 Mar 2021 08:23:39 -0500
X-MC-Unique: 9-W6Red0OT-Vv7NcfWjs5Q-1
Received: by mail-pf1-f198.google.com with SMTP id v6so14468605pff.5
        for <fstests@vger.kernel.org>; Fri, 12 Mar 2021 05:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqk2ewTMtmrT8wZQr3P/BizmB1Yzno25N3/VZwVg/1Q=;
        b=UyjhQ7dGqK2gm2h3j8O/BwxLYH9FWwVL2nYwdKC1R2VcIvDZCO6XTsx3DfCg9OCQ4l
         yVaEejj5HMoS9cFPH0GwAKncxl9yLt4AxsULI5mmjMxn3CEhhs/exGXWll0Wj+rp3tih
         t/rje7rWOAVOTyuUFy7YgXMYXCiQX6zMm8Zu6mKx1GrxFrYlLV6cLq+BghaeDQfU2nXe
         C8LxzDzBvv9BdaZ/ksiPLB0+yt0bnH6jAagARVSLuMDkwzAXYwkliRxUaQ99YEcnJ0tp
         K0VQYmA/fSItSO7x+ioWk//HNLioOUcb2JiyO1mlQZBAYrsZVBU6KNo61xyIx5Ob0r8C
         v9bw==
X-Gm-Message-State: AOAM532xkTy4YJUuUs/3EejOYG3GlHzcwtjPrQOHNNWOeALYIcL1/UCe
        aQhIlOMzWvTrUStHFioMZXQ5/Z9gaxRVT4gLeAF6uCD7lzBRtkt1rdfQJg2eqMW06BG2INh2GDI
        RI6HjeSWAe26Y6709Jg==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr14205722pjo.97.1615555418422;
        Fri, 12 Mar 2021 05:23:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU4XRNXbOyhXd6AJAQKDeXogeOSSpSQD5AohNDMSDWGruMk4aq3p9MQH838EEHCdRRyEG7KA==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr14205705pjo.97.1615555418217;
        Fri, 12 Mar 2021 05:23:38 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j17sm5428234pfn.70.2021.03.12.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:23:37 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Gao Xiang <hsiangkao@redhat.com>
Subject: [RFC PATCH v2 0/3] xfs: testcases for shrinking free space in the last AG
Date:   Fri, 12 Mar 2021 21:22:57 +0800
Message-Id: <20210312132300.259226-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

This version matches
kernel v8: https://lore.kernel.org/r/20210305025703.3069469-1-hsiangkao@redhat.com
xfsprogs RFC: https://lore.kernel.org/r/20201028114010.545331-1-hsiangkao@redhat.com

and mainly addresses comments for the previous version.

Thanks,
Gao Xinag

changes since v1:
 - add a _require_xfs_shrink helper (Zorro, Darrick);
 - introduce a basic functionality test (Darrick);
 - drop prefix "_" for all functions in tests (Darrick);
 - introduce TIME_FACTOR and LOAD_FACTOR to adjust the load (Darrick);
 - move $decsize out of the loop (Darrick);
 - use $XFS_GROWFS_PROG instead of xfs_growfs (Darrick);
 - query the running size instead of calculating (Darrick).

 common/xfs        |  10 ++++
 tests/xfs/990     |  59 ++++++++++++++++++++++
 tests/xfs/990.out |  12 +++++
 tests/xfs/991     | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/991.out |   8 +++
 tests/xfs/group   |   2 +
 6 files changed, 212 insertions(+)
 create mode 100755 tests/xfs/990
 create mode 100644 tests/xfs/990.out
 create mode 100755 tests/xfs/991
 create mode 100644 tests/xfs/991.out

-- 
2.27.0

