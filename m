Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD8C433E2
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0EF21D6C
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 10:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANTU27x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgILKUH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 06:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgILKUB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 06:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599905999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+1vf5iFSfsgRyg6jATQbz2V5D1DP/yC2kc3rwqUGn5g=;
        b=ANTU27x8AjjVN1LnoS/2rEt3AovWrz/j7PsvP2F2BpqCYu7YwvMxSysuPbsM0E+j2ofm8h
        e1S6ASdMtJExJTVQ4dol8Fr/RaUKk2tV3rqYE7zv7h+DO4S02EaOCy75TJJ+XXj8SKAonh
        07DdgRwM3Dq6pxLOCku4syxBarbadaU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-U3SaMFu2Ne2m4pkaDDqUaA-1; Sat, 12 Sep 2020 06:19:57 -0400
X-MC-Unique: U3SaMFu2Ne2m4pkaDDqUaA-1
Received: by mail-wr1-f72.google.com with SMTP id l9so4222294wrq.20
        for <fstests@vger.kernel.org>; Sat, 12 Sep 2020 03:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1vf5iFSfsgRyg6jATQbz2V5D1DP/yC2kc3rwqUGn5g=;
        b=hZ999q2DnMdArR3XB9CnydI6oKDFqa3Z5fQFDAxOhfOUeHeaBtdjNqiFNATQh3purd
         dWsZVwUZ3luULaDccijavj/f1hWmZAVQX9ppZPGUHbHB36Ew1w/A8AMhfkLQ7G1oradZ
         7gF/vuCeLiviB4GC+2LfTn/SDuJOj3E+HjKY2g3pzMi/euMa6DWN0+Mrd05eT/lwXbTA
         gEXH27DnFesPfjMLwYRELfnGGaAryqzneK2i7RNxnITv4nMxT/10VDQvxBD3Wzc9hfCh
         5izIg+seaYomgT8N18/vJCJ1V9x9n6tyRSVPfj/Wuvz6nIS8ofcWVPmSe/tg4ENl6+Eu
         MNpw==
X-Gm-Message-State: AOAM532mmkjnmEfIO3Fg5c7Iul0+qR5tp42eM6hSCqmf9rPvexiMr/Rb
        Gb08UE8p80X4yV3gnPKiNzxJpbqdIRRkRyAhahExi/bryeEu9RWhdLNCyQ6vgASze5rneWjrANG
        Kj1cT+DywWWqmsYE9Qg==
X-Received: by 2002:a5d:5583:: with SMTP id i3mr6033210wrv.119.1599905996279;
        Sat, 12 Sep 2020 03:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Il3UwXSQaDr18Yxqx56sS0cxWORhEtB3ypvg9Qd4rmn5GVWqPsboLdukNOI+4lW+iGnMYw==
X-Received: by 2002:a5d:5583:: with SMTP id i3mr6033203wrv.119.1599905996112;
        Sat, 12 Sep 2020 03:19:56 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id 8sm10089805wrl.7.2020.09.12.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 03:19:55 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhad.com
Subject: [PATCH v3 0/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Sat, 12 Sep 2020 12:19:52 +0200
Message-Id: <20200912101953.114089-1-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add test for XFS bug that corrupted metadata if extended attribute name
of length 1 was used.

Pavel Reichl (1):
  generic: add test for boundary in xfs_attr_shortform_verify

 tests/generic/609     | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  4 +++
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

-- 
2.26.2

