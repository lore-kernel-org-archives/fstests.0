Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6AC47091
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7271E61107
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhE3MYn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 May 2021 08:24:43 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:57432 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3MYn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 May 2021 08:24:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1550637|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.029694-0.00405737-0.966249;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KKv5OPU_1622377383;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KKv5OPU_1622377383)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 30 May 2021 20:23:03 +0800
Date:   Sun, 30 May 2021 20:23:03 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: remove default 4k blocksize from
 XFS_MKFS_OPTIONS
Message-ID: <YLODpzPeFL7WYlnT@desktop>
References: <20210525044642.552682-1-zlang@redhat.com>
 <20210525160507.GA202095@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525160507.GA202095@locust>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 09:05:07AM -0700, Darrick J. Wong wrote:
> On Tue, May 25, 2021 at 12:46:41PM +0800, Zorro Lang wrote:
> > xfstests set "-bsize=4k" to XFS_MKFS_OPTIONS by default, then give
> > it to MKFS_OPTIOPNS. So MKFS_OPTIOPNS always contains "-bsize=4k"
> > except we set XFS_MKFS_OPTIONS manually.
> > 
> > It's useless to set XFS_MKFS_OPTIONS to "-bsize=4096" by default,
> > especially that will cause all cases with _scratch_mkfs_blocksized()
> > always fail as "-b size option respecified", when test on XFS. For
> > exmaple: generic/222
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> /me wonders what the historical context is (a) for having an
> $FSTYP-specific MKFS_OPTIONS variable, and (b) for setting bsize=4096
> here.  All I can say is that I've tripped over this numerous times and
> wouldn't really mind if it went away. :P
> 
> Acked-by: Darrick J. Wong <djwong@kernel.org>
> 
> (acked in the sense that I'm not /opposed/ but really really wants to
> know the historical reasons)

Looked at the git log, and it was added in 2004 without any
explaination. I'll let the patch pending for another week, to see if
anyone knows the history behind this.

commit cb6beb975950121f0569c5dede6136fb8ae0b8b8
Author: ptools <ptools>
Date:   Tue Jun 15 07:32:36 2004 +0000

    Fixed merge problems

Thanks,
Eryu
