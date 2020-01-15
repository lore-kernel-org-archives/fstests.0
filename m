Return-Path: <SRS0=EYS7=3E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D69C33CB1
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADB7214AF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMVMXqXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgAOPA7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:00:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOPA7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jan 2020 10:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/fTiloHBAPS8Cs1bg/qh1RWyOiQKme98A3pXMx8rMWo=; b=DMVMXqXrql3jtgswju6Iz92Uz7
        QN7s0LVi3y5/7tBMo2ApjbtQPx7tLmgq3GVsEJWU9vFP/ssxO2anoiTtYaZOBuE6mEmAXq3WgNL+Z
        +UGAel68dHIiq9TB1JOvrqxWN8zmmghhjc+5R7xs+9F5gvjGYCJKuwdUKJnzV5bJsHjpDehhYmcNm
        5NFvi5h/vGM8GOiNsasweYFfLkTeyaAZ5I1UGobxwdS3TKc3xrgYB3wLwbIyqvllzJ+c9gtTnS8hT
        JsTbpL2i4Y4h6DWX5fQUkTqm1wOrmCj/188N2scjLnWUfZE5l6dRG3OcjH5mIljF7nRYEHC/vzmRM
        9jHAT5Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irkAF-0006o4-7Q; Wed, 15 Jan 2020 15:00:59 +0000
Date:   Wed, 15 Jan 2020 07:00:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     jlayton@kernel.org
Cc:     fstests@vger.kernel.org
Subject: xfstests generic/484
Message-ID: <20200115150059.GA21201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Jeff,

do you remember the story behind xfstests generic/484?  That test has
been failing for me ever since it was added and on every file system
(which is not surprising given that the functionality isn't file system
specific).  Are we expected to fix the issue in the lock ode?  Or did we
give up on it?
