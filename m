Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAEAC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1AB61929
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCUPca (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Mar 2021 11:32:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCUPcH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Mar 2021 11:32:07 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lO03e-0008Vk-DC; Sun, 21 Mar 2021 15:32:02 +0000
Date:   Sun, 21 Mar 2021 16:32:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/4 REBASED] fstests: add idmapped mounts tests
Message-ID: <20210321153200.t6cgg3sfm4m2aea3@wittgenstein>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <YFdXmwkoZnN5uEH/@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFdXmwkoZnN5uEH/@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 21, 2021 at 10:26:35PM +0800, Eryu Guan wrote:
> On Tue, Mar 16, 2021 at 11:36:23AM +0100, Christian Brauner wrote:
> > Hey everyone,
> > 
> > /* v9 */
> > Rebased onto current master.
> > Hopefully we can merge this soon so we can have regular testing asap and
> > the rebasing is getting a bit tedious too. ;)
> 
> Sorry for the late review.. You don't have to rebase on every release if
> updating the test seq number is the only thing changed. Seq number
> conflicts all the time, usually I can fix it on commit.
> 
> Patch 2 is missing from the list, maybe it's too big to post, could you

_Sigh_, this seems like another vger issue. The individual Ccs/Tos
should've all gotten the patch but it's missing from the list. This is a
pattern I've seen quite a few times recently with vger. There's nothing
to do apart from complain about it to the vger maintainer. :)

> please provide a git repo so I can pull from there?

For sure. It's available in three locations:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/log/?h=idmapped_mounts_v2
https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts_v2
https://github.com/brauner/xfstests/tree/idmapped_mounts_v2

(Are you fixing the things you pointed out in the individual patches
yourself or should I resend a new version?)

Thanks!
Christian
