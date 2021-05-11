Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0DCC433ED
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 23:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0086162B
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 23:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKXd7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 May 2021 19:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEKXd7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 May 2021 19:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620775971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sB807XykC81jeo95j8FkXCmMB3IA8Dimcp1b7gtaS5E=;
        b=KMKz6P7p4C8O89Wj/0mdhYj5WOmtI0grZyCbNomD9pI+2Cpfu0S66pF/W+NOwNCxlkOwXD
        uhvSiMATfXoZxE/X0qHnFH9ecfbKXi2zDfCp9i9L2PiFUb1tT402ZTiRkivEl43xZLhxwI
        i9x3tYkajMopkWys3ABZvsc8cOmVQRg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-cg44K2JIMyiGL7xNlesilA-1; Tue, 11 May 2021 19:32:49 -0400
X-MC-Unique: cg44K2JIMyiGL7xNlesilA-1
Received: by mail-pj1-f70.google.com with SMTP id p8-20020a17090a74c8b02901558c0dbcd5so2463579pjl.2
        for <fstests@vger.kernel.org>; Tue, 11 May 2021 16:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sB807XykC81jeo95j8FkXCmMB3IA8Dimcp1b7gtaS5E=;
        b=N8eMJ58QFT3QP5Q3xLW+2AfUnXeSXgVaR481eR39OUg1+Z9/dxgiBIRRdk8W5WcKn3
         vdatJffrnk/iLbudaNf+7hskzyfNFgW0up17yUdLIwcs+z2e4KlJ/CUaWvIOGor5/14N
         GZ02xVjE7g2Ak+Xm0b9qlcBMEPSPuVhzM83bIrmHL2S0wZXC4s3HkGGAgPnEQPjitvs7
         4BU9nQ74X+3Rtv+DIW2KDXionmzrvxuCdDBPgzwrB3FmmqXcMuR4XYv6s0slwkJCJMy3
         4sfb7XG7QNeK5w95yrxlh1DGlFawJIVZYeK3gGHRnXWUDa9O1MW4pGrx9rdWPEL9ebn7
         ybJg==
X-Gm-Message-State: AOAM530rMW6LRWpFZECPKyaq5i2YlykLNYKHbDmos5Yy0MacwCg3bRaC
        3+gQKNmg5onD1AwmkzWiXEO3Lp5Q+udmidWDYWGjPznzbySAIElfZ4a1HsoOuAnCbcbja8rmj66
        1MQdcgGF5bo6I6qtK0A==
X-Received: by 2002:a63:4553:: with SMTP id u19mr4264129pgk.323.1620775968330;
        Tue, 11 May 2021 16:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyoz0uJwOFqtcnM3tqqwuaX6f7dCSl/WUWIxoAazck/KaWDdRzAmDbTV5vSYX1/mqe0dHnvA==
X-Received: by 2002:a63:4553:: with SMTP id u19mr4264111pgk.323.1620775968016;
        Tue, 11 May 2021 16:32:48 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s3sm15828393pgs.62.2021.05.11.16.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 16:32:47 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Eryu Guan <guan@eryu.me>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v6 0/3] xfs: testcases for shrinking free space in the last AG
Date:   Wed, 12 May 2021 07:32:25 +0800
Message-Id: <20210511233228.1018269-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

v5: https://lore.kernel.org/r/20210511073945.906127-1-hsiangkao@redhat.com

This adds testcases for shrinking free space in the last AG in the
upstream. This version mainly addresses Darrick's previous comments
mentioned in v5.

changes since v5 (Darrick):
 - [1/3] print $errmsg when _fail;
 - [3/3] print $sizeb for better debugging.

Thanks,
Gao Xiang

Gao Xiang (3):
  common/xfs: add _require_xfs_scratch_shrink helper
  xfs: basic functionality test for shrinking free space in the last AG
  xfs: stress test for shrinking free space in the last AG

 common/xfs        |  20 ++++++++
 tests/xfs/990     |  73 +++++++++++++++++++++++++++
 tests/xfs/990.out |  12 +++++
 tests/xfs/991     | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/991.out |   8 +++
 tests/xfs/group   |   2 +
 6 files changed, 237 insertions(+)
 create mode 100755 tests/xfs/990
 create mode 100644 tests/xfs/990.out
 create mode 100755 tests/xfs/991
 create mode 100644 tests/xfs/991.out

-- 
2.27.0

