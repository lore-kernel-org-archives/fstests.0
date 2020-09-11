Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43FC43461
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F14D21D7E
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo3p1L/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKWP1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:15:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23772 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgIKWPX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 18:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599862519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s0neNMnsQdSBGQo5HaTW9bvy9rcmIMUEfmRsyHxZUpg=;
        b=Fo3p1L/q/XzYpJ46aWDGwo6YtOwAHe7oJav1uKLqHB/IzgtDEmiHHnQabuthgpm8FCCX91
        WOZczynS/i2aiNNZcOWnC712CzltIEWP6d/PCd8JvmAX1WGP/Whyh6nGFW41JrntbQpFRQ
        2fr0HVTL7Jr1bw5FNKgUlbWYvZCLseE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-2Vg96V19Mkio46ZeWt9XqQ-1; Fri, 11 Sep 2020 18:15:17 -0400
X-MC-Unique: 2Vg96V19Mkio46ZeWt9XqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 23so1882069wmk.8
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 15:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0neNMnsQdSBGQo5HaTW9bvy9rcmIMUEfmRsyHxZUpg=;
        b=m5nd1ln3y51M1Jl2Z6e1sSc21+8V9sCqihpP8ITZZYBQNiYCsk903tPllsh9huK6Zw
         7uMx0q+2y2GrqBN3lrqEq9e9HnatxpaLbCTCRLTE1QCBE0mXai3QwL1RE3mZDZkN7jpk
         n/BARmChzqSzY15v6/X989s+3/RWwn+42yNM1YLTP/ofK9j/7Pkkhkl4W/7ryyHA57ZS
         bbD6IUD8lgXsca+xT3v/Hh/WgVujtYlrq2Dg+jrhZO+hGOkbP381lm04mbv9OkeUmWwT
         Gs6/b89OzJ/xDLqsIZxowdxdtsgQjaeDm9VUuDTSMON6Cm/ddpmSfRqSSoDTwcNkfSHZ
         daWg==
X-Gm-Message-State: AOAM533hgzvsgqep0eu5xPxync63WPNuOJGWwJgFmKz1Q5dAOxyvNyfi
        0l0EUTeJqmrZYffAdqo/S1Cq4WXQFWdXqYBvbdzJId4cV78X3FGMqUDIjyTHwlcHgetINeEO+DO
        KnK4CUKl9jnZ3iwQ+IQ==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4349914wrn.57.1599862516071;
        Fri, 11 Sep 2020 15:15:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMI58ginUwxOP7TU83/MYBY1AONXznszGHLOS7GoiAwjSQsxX/CvhesYGknYVqqJ7iY8Qovg==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr4349899wrn.57.1599862515870;
        Fri, 11 Sep 2020 15:15:15 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id t22sm8133913wmt.1.2020.09.11.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:15:15 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH v2 0/1]: generic: add test for boundary in xfs_attr_shortform_verify
Date:   Sat, 12 Sep 2020 00:15:13 +0200
Message-Id: <20200911221514.69318-1-preichl@redhat.com>
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

 tests/generic/609     | 66 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  1 +
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

-- 
2.26.2

