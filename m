Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4448C2B9F7
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F02261378
	for <linux-fstests@archiver.kernel.org>; Wed, 26 May 2021 03:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEZDXk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 23:23:40 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48525 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231157AbhEZDXj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 23:23:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ua82V2N_1621999237;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Ua82V2N_1621999237)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 11:20:37 +0800
Date:   Wed, 26 May 2021 11:20:37 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Jakob Unterwurzacher <jakobunt@gmail.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/286: fix integer underflow on block sizes != 4096
Message-ID: <20210526032037.GF60846@e18g06458.et15sqa>
References: <20210522184814.95802-1-jakobunt@gmail.com>
 <YKoa7dtkdmu8hp+/@desktop>
 <CAPv9ZmkirKWThgE7q2oHFFMtk0bQ7A9xG8i+RGqgyLnCkCJJZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPv9ZmkirKWThgE7q2oHFFMtk0bQ7A9xG8i+RGqgyLnCkCJJZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 07:34:14PM +0200, Jakob Unterwurzacher wrote:
> On Sun, May 23, 2021 at 11:05 AM Eryu Guan <guan@eryu.me> wrote:
> > The total read length should be
> >
> > "The length of this extent is (hole_off - data_off)"
> >
> > according to the comments above do_extent_copy(). Total read length
> > being not a multiple of 4k means 'data_off' or 'hole_off' is not 4k
> > aligned.
> 
> That is correct.
> 
> > But generic/286 creates source files with length of all data extents and
> > hole extents being multiple of 4k. So I still don't understand why this
> > is valid for gocryptfs. Shouldn't that be a bug in seek_data/seek_hole
> > in gocryptfs? Could you please elaborate?
> 
> Yes sure, the situation is a bit complicated. gocryptfs works similar
> to eCryptFS and EncFS (also overlay filesystems).
> The files are stored in encrypted form in regular files on ext4 or xfs
> or whatever "real disk" filesystem.
> Disk space allocation & file holes are handled by the real filesystem.
> A gocryptfs mount shows a decrypted view of these files.
> 
> Now, gocryptfs uses AES-GCM for encryption. This adds 32 bytes of
> overhead to every 4096-byte block,
> which gives a storage size of 4128 bytes.

Ah, that makes sense to me now. Would you please include the detailed
explaination in commit log as well?

Thanks,
Eryu

> 
> The encryption overhead is why the files & holes created by
> generic/286 are not 4k-aligned on disk when viewed through the
> gocryptfs mount.
> 
> Thanks, Jakob
