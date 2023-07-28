Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF6EB64DD
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Jul 2023 20:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjG1Uar (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Jul 2023 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjG1Uar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jul 2023 16:30:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB4422B
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2023 13:30:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-23.bstnma.fios.verizon.net [173.48.113.23])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36SKUeWN005603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690576242; bh=6liHUk9ThIyM7S6uHQBys96LpNCNt8JCirwK+Yj25+0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=f8jTL8REDEpJVZh2p5FvGYhTwm8IxXbYnNCQ1bzF1c1xZLz37gMqh0t0KsZaXq8ED
         tRt042CbQk3p0I3NxD2Q1NN8L3fNoTf3pNcZtQpLawFprpf+7tidqa8P8xikoWhZUt
         6iuXacooyqxIDqK0oLcP1fBPC8viiKNcxSTFM+0YKXzrqHKi7GPB5KSuGr4Vk6zJEC
         /w6jDt1gKHGXKEe9ZjCnVWdTpvU+lRKK+dhq+JKxfC4ELzzv5tOJrki7jx39T5fgYs
         DVzK/r+NVNd/egD+soc/c02QxTxOzpxJ3jljlxoTDQ8HS97md/bPIsdt+aoA05EMMV
         43WBJmGmL9JWQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AA8AE15C04EF; Fri, 28 Jul 2023 16:30:40 -0400 (EDT)
Date:   Fri, 28 Jul 2023 16:30:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20230728203040.GA610919@mit.edu>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <20230207182656.ekjt2lhbid6xf2cs@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207182656.ekjt2lhbid6xf2cs@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 08, 2023 at 02:26:56AM +0800, Zorro Lang wrote:
> fstests has merged below change 2 month ago:
>   [PATCH] fstests: update group name according to xfs_io command requirement
>   https://lore.kernel.org/fstests/20221108183242.3362013-1-zlang@kernel.org/
> 
> So I'd like to check if it helps for the problem you described above?
> If not, I think we can think about the patch you metioned above.

Oops, sorry, this got lost in my inbox.  :-(

It definitely helped, thanks.  My one observation about this patch is
that it's a one-time fix-up.  I tried rerunning the script referenced
in the patch, and there were 11 tests that it "fixed up".  Now, they
were all adding tests to the "prealloc" group, which I think you had
deliberately excluded, because they weren't actually testing prealloc,
but it's the worry that future fstests developers might forget to set
the group name correctly, which is why I still have "common: introduce
XFS_IO_AVOID env var"[1] as an out of tree patch.

[1] https://lore.kernel.org/all/1445107518-32022-1-git-send-email-tytso@mit.edu/

It's a small change, it almost never conflicts with upstream changes
(generally the only time I have to deal with a conflcit when rebasing
is when a new environment variable is added to the documentation in
README), and it means that when I run "kvm-xfstests --no-collapse", my
wrapper scripts do this:

    no_collapse)
        ALL_FSSTRESS_AVOID="$ALL_FSSTRESS_AVOID -f collapse=0"
        ALL_FSX_AVOID="$ALL_FSX_AVOID -C"
        ALL_XFS_IO_AVOID="$ALL_XFS_IO_AVOID fcollapse"
        FSTESTSET="$FSTESTSET -x collapse"
        ;;

and I'm *guaranteed* to make sure that any tests involving
collapse_range will be skipped.  Do I strictly speaking need the
out-of-tree patch in [1], probably not, assuming the group list is
always kept up to date, and to be honest it's been a *long* time since
I've never needed to use gce-xfstests --no-collapse or --no-insert.

However, the cost of keeping the out-of-tree patch in my local
xfstests git repo is quite low, so I've just kept it.  But do I *need*
it?  Arguably, no, which is why I haven't been bugging you about it.
:-)

						- Ted
