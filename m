Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFFC07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980E86008E
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGGKWx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhGGKWw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625653212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2PizMLT93bnHxr689Gh6JDKbWHviKRcX1FBzT0isb2A=;
        b=BaBljUdbxstguHNjFcUqr38iFQG+v/Akq4IwmJSOS3l8OhEGvffsp3xgKbL42y7giFK2Aq
        lsNAOw2/GurhFpIE2pE9UTtc+FZeDGbumkaFLSUAmlMVJv4AUtzSsw5rw9tTJ88wretcmh
        d/Kn1u+uZyHWpt7JQ09H6sBl82a2FS0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-2NKFTLYmPOGmRsPiq4h-Xg-1; Wed, 07 Jul 2021 06:20:10 -0400
X-MC-Unique: 2NKFTLYmPOGmRsPiq4h-Xg-1
Received: by mail-ed1-f72.google.com with SMTP id j25-20020aa7ca590000b029039c88110440so1169582edt.15
        for <fstests@vger.kernel.org>; Wed, 07 Jul 2021 03:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PizMLT93bnHxr689Gh6JDKbWHviKRcX1FBzT0isb2A=;
        b=aNL8qbfy1h9Cs9puHtahPDliQPkHhvxJNXO9O8lpb+vHsaopON2Pr2PGwF3LXn0+En
         ziJ4GPeYi2leTaUjbDE5Zdcv1sigU7eEENdGAZMbNuUwkOZg+F85Arddnr/LHSi3AsPR
         OsAuzCA7LBHW1CmSx5GFlv0EGAIWJM8l1zip/Kbkk9o/ntKL79XxoE5GwW2gdG9FvHH0
         0/au7YiJnkbzVVTy05k+OjWAkx9Fp6ZM6aHsnxWhg74jn4KrsKJ4b6yx+8lsf1xxVhrD
         2/BYRR5PKMywZJkD6DnOXLgXzmJTHTnBgoDp4DrlXUv+jbNwt3ucwnrso4z7He9prkez
         9HIQ==
X-Gm-Message-State: AOAM531Z5eDCg3+deZigvBT5IOuCWUhhHkq8Z18eK5bsQH1saNTFAlpS
        ywwTH1gJRWNFEd4HlG/ECv7FgrrNiYBoe7aw17hGPOf1wd69lge0mMTpNXU+GY5VHk8DAohXb6E
        rgRj6wJ/vUbvCiUZ7L8e5NuJgQcRMeVVelp2dUFmiqdITJtsT4wheuNO5+VSIrWYsds78
X-Received: by 2002:a17:907:86a8:: with SMTP id qa40mr22902184ejc.385.1625653209232;
        Wed, 07 Jul 2021 03:20:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxVGluUwhxuoWFU9qiqzwbtALEM5t4mczT1T5rIXdEiTpFV1VSM+Abndk+LC29CfgFdmbonQ==
X-Received: by 2002:a17:907:86a8:: with SMTP id qa40mr22902169ejc.385.1625653209072;
        Wed, 07 Jul 2021 03:20:09 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id t11sm4095087edr.34.2021.07.07.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:20:08 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     shreeya.patel@collabora.com, djwong@kernel.org
Subject: [PATCH 0/1]: generic/453: Do NOT run for FSs restricting names
Date:   Wed,  7 Jul 2021 12:20:06 +0200
Message-Id: <20210707102007.66774-1-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

this is a quick attempt to finish what was discussed in thread:
	generic/453: Exclude filenames that are not supported by exfat
	https://www.spinics.net/lists/fstests/msg16328.html

Based on Darrick's comments:

"""
TBH I think these tests (g/453 and g/454) are probably only useful for
filesystems that allow unrestricted byte streams for names.
"""

and

"""
Nowadays with wider testing of other filesystems (thanks, Red Hat!) we
should hide these behind _require_names_are_bytes or move them to
tests/xfs/.
"""


Pavel Reichl (1):
  generic/453: Do NOT run for FSs restricting names

 common/rc         | 11 +++++++++++
 tests/generic/453 |  1 +
 2 files changed, 12 insertions(+)

-- 
2.31.1

