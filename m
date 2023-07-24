Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739CCC001DF
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGXP3a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGXP32 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 11:29:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438891B3
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nVHmtCAE67RgDfFeGtE6eSL6Uy1b74wn6b9K4Og0i6M=; b=CD9emUWX43mUJs/hyvTv8gTi2o
        UkKv8Z1V8a5xMGXxrdREFd9nsugVFkHwyPmuH+n9gwTQg5pgbShXO+a1UAsWkZa66C2gHeA44eldG
        mVe80QzHCG9R6aaCF1iWGMb8XLlJxQTKPxmKT1KLzU+4nXJWOKTv45jPr8qifDCIy2/50NOr0j8LD
        3UPhwOlZLrdQDq0TfLYn+zoO58pglCt06YmZLMC7pLntO0dqP1UAYEY82AY7clgy+6Zauv5Rb7KLC
        MCoKTLYXgAknrGlojFEk5U6fysYYEFedi7i4ix5Finn5ahTxQEzDyI/zJJgLIQ1adPgd03lgDDKXQ
        ILIsPaRg==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNxV2-004k4t-0N
        for fstests@vger.kernel.org;
        Mon, 24 Jul 2023 15:29:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Subject: add device removal test v3
Date:   Mon, 24 Jul 2023 08:29:25 -0700
Message-Id: <20230724152927.33094-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

this series adds two tests for removing a device underneath the
file system.  This covers the new shutdown handling series I'm
posting.

Changes since v2:
 - don't look for specific logical/physical block sizes on SCRATCH_DEV
 - use run_check (Zorro Lang)
 - use SCSI_DEBUG_MNT instead of SCRATCH_DEV (Zorro Lang)

Changes since v1:
 - renumbered the tests
 - add a check that the tests are only run on block based file systems
