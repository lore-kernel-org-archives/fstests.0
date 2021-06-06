Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BAC47096
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 11:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B36136D
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Jun 2021 11:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFMAX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:00:23 -0400
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:60828 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhFFMAW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Jun 2021 08:00:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1264663|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0168349-0.000697045-0.982468;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KOMyUk0_1622980710;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KOMyUk0_1622980710)
          by smtp.aliyun-inc.com(10.147.42.197);
          Sun, 06 Jun 2021 19:58:30 +0800
Date:   Sun, 6 Jun 2021 19:58:29 +0800
From:   Eryu Guan <guan@eryu.me>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if
 mknod not supported
Message-ID: <YLy4ZfXQ08542qoW@desktop>
References: <YLOJ9h734bmR140Z@desktop>
 <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
 <1448892.1622557912@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448892.1622557912@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 01, 2021 at 03:31:52PM +0100, David Howells wrote:
> Eryu Guan <guan@eryu.me> wrote:
> 
> > _require_mknod checks for mknod support by trying to mknod and _notrun
> > the test if mknod fails.
> > 
> > So does afs return any failure like EOPNOTSUPP? If so I think we could
> > refactor _require_mknod into something like
> 
> afs doesn't provide a ->mknod implementation as it doesn't support anything
> you'd create with it, so you get the VFS default in such an instance - which
> would be EPERM.

I think that works too. Currently _require_mknod() doesn't depend on the
errno but just check if mknod succeeds or not.

Thanks,
Eryu
