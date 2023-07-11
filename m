Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C0EB64DC
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Jul 2023 10:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGKKJj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jul 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKKJg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jul 2023 06:09:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E84A9
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lmPrliL9/DZw2AVbU1dsW5Q+Kb1nNBxiG7XeG1r/NRg=; b=QWgLMs3NY2KQrZmrelgVSXcUIW
        rSi3ffWdKJQONruo6W1/O7KBi9feVEC837Fs298MpTefFSrWGow/o1Kd4CYlhQ9+y6/MndoQ15rtR
        HqWM/HTMsSpDoYFFbpbDxe3AMo3Jdm5ypP5WhAU04geKu7QCAEeC1bO+rG/qgArY4103C2XQjXBBw
        VkicsMV95+uLzVsmoEP2OYDYUSsrlmry0+efy+nmA2PIp5lagbjSsVrIWrpYEpnxqO3WtFJpBS71b
        sULp9P2vlLNGGQAjprUUUY1n6vUxRlslyhcZdgB+NLtQHD0ekrh/GutB/h3a/rP2pGRysGIx42C2t
        KxkKkaSA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJAJL-00EP7q-0q
        for fstests@vger.kernel.org;
        Tue, 11 Jul 2023 10:09:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Subject: add device removal test v2
Date:   Tue, 11 Jul 2023 12:09:29 +0200
Message-Id: <20230711100931.175680-1-hch@lst.de>
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

Changes since v1:
 - renumbered the tests
 - add a check that the tests are only run on block based file systems
