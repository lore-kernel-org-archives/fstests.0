Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDFC43461
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05B921D7E
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 15:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbZWre/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIKP70 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:59:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57112 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726577AbgIKP4o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599839803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AVtKUTjc/sydqCUf1iXAk2S+JiCisM2vVzVk3vv+OeY=;
        b=HbZWre/T+M5WG+lUJc1I4vA863LCfcYGMbN+eZyLyuT3BnUM8MFX9nn0DImgUJ94gPRYuE
        4xsaOZvqbhZXi/HfFin+pEalfGTMsOH74IB3F7EfNDS3bRuTvZ7p8yIwkycgguKxF80Kxi
        zs1Wk19DWbqbSDSEpvkMQ0o4h9bwy/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-tVvSdZsCOM6LmZtZ0n2aMw-1; Fri, 11 Sep 2020 09:38:58 -0400
X-MC-Unique: tVvSdZsCOM6LmZtZ0n2aMw-1
Received: by mail-wm1-f71.google.com with SMTP id m20so632488wmg.6
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 06:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AVtKUTjc/sydqCUf1iXAk2S+JiCisM2vVzVk3vv+OeY=;
        b=Bv2+ZyQz3C2IpWGW+hnti52r8tVT1vqcJ8JxsN272dLSkBm56LiVbjLaP6XalcvBhL
         PF0ygQC4n+0YJxUttVW97ExysHewkcHG18Vyi7ExdARBO/3+ksokUQlMoxblJ5lUJpVJ
         i+GYba71G8sRGmZi4FwV4rhxhkPOdqVDtzebRIWZ7TyU33yRAE/ci4Xa6i8gRFNBTcgP
         /80J11yqoRp8MMyA7QNcIpg0uzfW3w4H5vXupqrnqEcoRby1O3Tkt3040Pi8EZIpa6M8
         V7R4n43Osvfqe4T6idfmhTWBKk4ZkCE4tUuvo42Migmrmn7WUrujMcIrgm2QqnDZbkjl
         7Csw==
X-Gm-Message-State: AOAM531sWOZEnGyBx0VtUVGE54k3lLgj7GgtUJxcyXzB3ewlYsGXBZhM
        d1X6IEp+X0Ku8mVx87Garolmt2FMXnLbpiiDmKvmUyBIXj9cHxdml50yq8KnLqHlTami6ZwxHgj
        Mc9BrAhsYhhWH/9Ew0A==
X-Received: by 2002:adf:df05:: with SMTP id y5mr2346621wrl.39.1599831537403;
        Fri, 11 Sep 2020 06:38:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOYdjGDP88otuhVnzLwEXDJ202w3g7MqSqaop4Le9vymEganSKa1QM1EdB87Q0ZX1+HD9UrQ==
X-Received: by 2002:adf:df05:: with SMTP id y5mr2346610wrl.39.1599831537271;
        Fri, 11 Sep 2020 06:38:57 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id t22sm5448342wmt.1.2020.09.11.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:38:56 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH 0/1]: generic: add test for boundary in xfs_attr_shortform_verify
Date:   Fri, 11 Sep 2020 15:38:54 +0200
Message-Id: <20200911133855.38997-1-preichl@redhat.com>
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

 tests/generic/609     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  8 ++++++
 tests/generic/group   |  1 +
 3 files changed, 73 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

-- 
2.26.2

