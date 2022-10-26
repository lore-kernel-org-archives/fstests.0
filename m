Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3957FA3742
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Oct 2022 07:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiJZHEl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiJZHEk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 03:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707BAEE3C
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666767875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qy6jRwuJera0Dg1UeCpGaUhg/SbswZwpnzi0R1uHwAw=;
        b=Vt2RSsYDPntr1VPEoC1XUyiJAZTZcE07V4Zi/cLpeC77cctd/G8zoLsOEjBBWca6VpDiSZ
        fLXtK0F+gEWwTjHe/bW7+UV4Tj0GCDDKh9moY9nj96Ap+ELmN/AL+1welWJY1bROhMzwwW
        ded6q3DYuSTO7PxUZTccohgyP6GYcOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-Iw_7BFTVOw2yb3f8BgOO-Q-1; Wed, 26 Oct 2022 03:04:31 -0400
X-MC-Unique: Iw_7BFTVOw2yb3f8BgOO-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14D20858F13;
        Wed, 26 Oct 2022 07:04:31 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D87D11415117;
        Wed, 26 Oct 2022 07:04:27 +0000 (UTC)
From:   xiubli@redhat.com
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org, lhenriques@suse.de,
        ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2] encrypt: add ceph support
Date:   Wed, 26 Oct 2022 15:04:16 +0800
Message-Id: <20221026070418.259351-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Xiubo Li (2):
  encrypt: rename _scratch_mkfs_encrypted to _scratch_check_encrypted
  encrypt: add ceph support

 common/encrypt | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.31.1

