Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46477C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 05:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiFBFDj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 01:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiFBFDi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 01:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00ECE3A
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 22:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19173B81E75
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 05:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBF1C385A5;
        Thu,  2 Jun 2022 05:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654146214;
        bh=jYGwGTAUKC1ywAqTToere8TjZ1FDb5J+E7kYZViy3zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lb9IwmTciqLIiZ4jaQNJrZh0fQfJdvmoPVrBzL2k3MefkmWkazIvj0Hkd3nDFjiCo
         T1kiKvR+jx80bhP2Gy/F5rfG/OpzH2poHsDf/RAQc/29mdg46uG2MANouMNmGQCotN
         dxml6WNe4cuOS4Qnl78VqbJlqCrIFg7nLqUX3lx9YkMPI4CwdpaBSjHvjwVqoaa6JH
         j1ik5UQwf6MEEi5dLj5zC1rskaJhSJ2dU0ekr6FyfZMPpmGj7ZVRYl+4+9uN5BM3i/
         yoln8qHYEb3kd9WLiHuqi//zKj4rKNNeQRbs0QM/D/flOpqrvwY3uPKLhrZJJMAcQY
         VTK80Pv9YEU0g==
Date:   Thu, 2 Jun 2022 13:03:28 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gitignore: ignore missed binary files in src
Message-ID: <20220602050328.aabwfvjj57tz7q5g@zlang-mailbox>
References: <20220601063730.1726879-1-zlang@kernel.org>
 <20220601063730.1726879-6-zlang@kernel.org>
 <YpelF6kKlbxd6K7i@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpelF6kKlbxd6K7i@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 01, 2022 at 10:42:47AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 01, 2022 at 02:37:30PM +0800, Zorro Lang wrote:
> > Add  src/dmiperf and src/t_locks_execve into .gitignore file
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  .gitignore | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 88c79412..24bde45c 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -77,6 +77,7 @@ tags
> >  /src/dirhash_collide
> >  /src/dirperf
> >  /src/dirstress
> > +/src/dmiperf
> 
> Removed in commit c13150fe ("src/dmiperf: Remove obsolete dmiperf")
> 
> >  /src/e4compact
> >  /src/ext4_resize
> >  /src/fault
> > @@ -146,6 +147,7 @@ tags
> >  /src/t_getcwd
> >  /src/t_holes
> >  /src/t_immutable
> > +/src/t_locks_execve
> 
> Removed in commit fd2366c6 ("fstests: remove generic/484")

Oh, sorry, so they're only left in my local directory:) Please ignore
this patch.

> 
> --D
> 
> >  /src/t_mmap_collision
> >  /src/t_mmap_cow_race
> >  /src/t_mmap_dio
> > -- 
> > 2.31.1
> > 
> 
