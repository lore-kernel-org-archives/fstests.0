Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102EC433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Feb 2021 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0A464F3F
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Feb 2021 12:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhBDMzl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236166AbhBDMzk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Feb 2021 07:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612443253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZsqpqNIMV4OMAjmUhKHFPkTrZ4jOumwZE6Cn+aC2Zw=;
        b=V9qMteKd4FswrZtoTm7zA+n2llnG4ULG/BIxZXAkQN6BKB2bdULHYPs8UvcfvuAqxmj6sf
        G3GFI6zz632pNgLhort30PAiyaibHz84Y1rbd3zyt6jTUUzHJ7Irw3m0TISG8C+dpxhsIX
        uvxg8V1Sqlh/Cfk7PWCJqbrqw7dZCQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-nRRagIVBMHShRAoX-9Z6Eg-1; Thu, 04 Feb 2021 07:54:11 -0500
X-MC-Unique: nRRagIVBMHShRAoX-9Z6Eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 934BE100A8E8;
        Thu,  4 Feb 2021 12:54:09 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB04610023B9;
        Thu,  4 Feb 2021 12:54:08 +0000 (UTC)
Date:   Thu, 4 Feb 2021 21:11:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, yangerkun@huawei.com, tytso@mit.edu
Subject: Re: [xfstests PATCH v3] ext4: Add a test for rename with
 RENAME_WHITEOUT
Message-ID: <20210204131118.GG14354@localhost.localdomain>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org,
        yangerkun@huawei.com, tytso@mit.edu
References: <20210202123956.3146761-1-sunke32@huawei.com>
 <20210202160527.GB14354@localhost.localdomain>
 <53ef6abe-d01c-8ecd-d20d-1b2fc172676e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53ef6abe-d01c-8ecd-d20d-1b2fc172676e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 04, 2021 at 03:59:52PM +0800, Sun Ke wrote:
> Hi, Zorro
> 
> 在 2021/2/3 0:05, Zorro Lang 写道:
> > On Tue, Feb 02, 2021 at 08:39:56PM +0800, Sun Ke wrote:
> > > Fill the disk space, try to create some files and rename a file, mount
> > > again, list directory contents and triggers some errors. It is a
> > > regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
> > > rename with RENAME_WHITEOUT")
> > > 
> > > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > > ---
> > > v3: use _check_dmesg_for() and modify the group.
> > > ---
> > I helped to re-write this case(without loopdev, dmesg check and ext4 specific
> > things) as below[1]. It can reproduce that bug[2], and test passed on fixed
> > kernel[3].
> Thanks for your help. Yes, it can reproduce the bug on ext4 test.
> > 
> > But I found another problem, we can't 100% make sure that renameat2 hit ENOSPC,
> > even if we can't create any empty file. That renameat2 line still succeed on
> > my XFS test. And Eric Sandeen even can't trigger that rename ENOSPC on his
> > machine.
> 
> The same as  Eric,  I can not trigger that rename ENOSPC on my machine on
> xfs test.

No, I mean that rename not always hit ENOSPC on ext4 either. Due to that way
to fill filesystem can't make sure there's not space to do once
rename(RENAME_WHITEOUT).

But even if we can't make sure the ENOSPC 100%, I think high probability is
acceptable. So I asked if we can test a chunk of files (not only test
a single one file) in my last email[1], hope to get some suggestions from
fs experts.

[1]
https://marc.info/?l=linux-xfs&m=161233233321478&w=2

Thanks,
Zorro

> 
> Thanks,
> 
> Sun Ke
> 
> 
> > .
> 

