Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0169C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiBIWSv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:18:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiBIWSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C9BC1DC2EC
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=l/Fhig5LK8Px5gD6scs5ZH38/Vl1L2oNaoEJnWE/hpQ=; b=Eob4UWuU7rmbzVJ5KAvYzjjuVl
        cg4NAsu3bs0K9zp4J8kR5E+177eizfETayNADyO0Forwbzm7n0vLQIYpn4Pf7i6zjRAqESmuXk4+3
        QGSLPF0QSSu8O2T2cf6mHtPOvg0VCK0VD1VvGRRfQ7U2NSxF38BFuOgKSSb87KazK7pPq4/p/y8fv
        rG4sfmypvjjCc1dtS2CHt4Lsvuu8UqLICUb0g1/oe2l8C/V4+djLZqCNxFyS2FxT1Pxo+OsD1Unv/
        WMm4eGpds3zOQfaoDf+05MyVcvH9fo9+wmB5ncoT38MZSF92dmYpOr2tXT6HUA4nXe9oDn+POGzl0
        8sAtxaRg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvIY-001p4f-KQ; Wed, 09 Feb 2022 22:18:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/4] dbench: few enhancements from mmtests
Date:   Wed,  9 Feb 2022 14:18:45 -0800
Message-Id: <20220209221849.434616-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

mmtests [0] also uses dbench, and they actually carry 4 patch delta
for years. These patches are useful and should not interfere
with existing uses, so just merge these.

As noted before, I've put all this and a few of my own fixes
into my own git tree [1] and I'll be extending dbench there as well
as I see its not up to date and even debian has dropped packaging
it as it doesn't compile anymore. The one on my tree compiles more
than fine now. I'll send a few other fixes after this set.

Mel, feel free to drop those patches if you want to use my tree :)

For lack of a mailing list for dbench, I'm freeloading off of fstests
as it uses dbench as well.

[0] https://github.com/gormanm/mmtests.git
[1] https://github.com/mcgrof/dbench.git

Jan Kara (1):
  Allow reporting of workload execution times

Mel Gorman (3):
  Defer reporting of execution times
  libnfs: Include stdint.h
  Check if parent is alive once per loadfile processed

 child.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 dbench.c |  3 +++
 dbench.h |  1 +
 libnfs.c |  1 +
 4 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.34.1

