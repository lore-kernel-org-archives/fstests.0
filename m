Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A49C4332F
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 20:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKGUKC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiKGUKB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 15:10:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8210BE
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 12:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE7E6129B
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CE3C433D6;
        Mon,  7 Nov 2022 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667851799;
        bh=oEq0LDBrlbPXydmSjEm7gBX1i885EWaV6obKfu8B3zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rvq5KSZyPxHyZol7GvMcfZ8nWtFb8znx2jy0SWVCra0lTT4fkkuhJ0WhSl3Mu1soL
         iMaP3TSXJITA2rvYovW4uw96Myzx9nXrY6f1XSsCaohx3k9RIHo33+k/jbZkX23QXJ
         6jYONqW5YeDUj4SQFUxcIYyP62sMOus4GtZqeip1wMfcrEULLZSbFgAOcNc56Bb2W3
         haAMT9Bpdr21nD9+2TG3ZQDlIMD8kUKKJVajvHjqt6uPwI2AJhKWgvr8Op9aBEwCc/
         nQGGMIF5jM/bHOiTiZpDGdU8f0H+RVKdwTrY6n7mc6bNFJeGjcsQKZiqdFE7yjhg2U
         r1wde2rCjPbmA==
Date:   Mon, 7 Nov 2022 12:09:58 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <Y2lmFoNQ2ByXzCW0@magnolia>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kzxKnYf8CLj49v@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 11:35:16AM -0500, Theodore Ts'o wrote:
> On Mon, Nov 07, 2022 at 10:02:36AM +0800, Zorro Lang wrote:
> > I think it doesn't make sense to use $FSX_AVOID in `fsx --replay-ops` cases.
> > Due to generally the operations which a cases would like to replay are exact
> > steps to reproduce to a known bug. If we skip some operations (e.g. -F), it
> > doesn't make sense for this reproducer.
> > 
> > The recommended way for this kind of cases is making sure current fs/system
> > support the operations will be run by fsx, especially those features are not
> > common on different fs/system....
> >
> > So it uses below _require_* helpers to make sure these operations are supported,
> > before testing:
> > 
> >   _require_xfs_io_command "falloc"
> >   _require_xfs_io_command "falloc" "-k"
> >   _require_xfs_io_command "fzero"
> >   _require_xfs_io_command "fcollapse"
> > 
> > That's my point, hope I didn't misunderstand what you said :)
> 
> No, you didn't understand me.  :-)
> 
> For context, I have an out of tree patch (see attached), which I had
> tried upstreaming a while back, but it got rejected, so I've continued
> to keep it in my personal tree.  The basic idea is sometimes you might
> want to suppress a test even *though* _require_xfs_io_command seems to
> indicate that operation was supported.
> 
> This might either be because the test didn't know about ext4
> bigalloc's cluster alignment requirements, or because a particular
> operation might just be *buggy* and being able to run tests as if a
> particular command wasn't supported was useful.
> 
> It was rejected because the claim was that you could just exclude by
> group instead (e.g., "punch", "collapse") but I didn't trust that the
> group list would be kept up to date, so I never really agreed with
> that line of reasoning.  These days, given that group declaration are
> kept in the test script, it's much less likely to happen, but I've
> kept the patch in my tree because it's occasionally useful.
> 
> At this point, it's admittedly pretty rarely needed since ext4's
> collapse and insert range commands are pretty solid modulo tests not
> understanding cluster alignment, but still, it's not much effort for
> me to keep carrying the patch and I don't expect it will ever get
> upstreamed.

If it's collapse/insert range you're specifically worried about, perhaps
its time to implement _get_file_block_size for ext4 so that
_test_congruent_file_oplen can exclude those tests that will get the
alignment wrong?

--D

> 
> 					- Ted
> 
> commit c9d25475a94d5e53d7f18d247a17088999522862
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Sat Oct 17 14:39:26 2015 -0400
> 
>     common: introduce XFS_IO_AVOID env var
>     
>     Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
>     using various advanced file system features such as "fpunch"
>     "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
>     command which is included in the space-separated list found in the
>     XFS_IO_AVOID environment variable will be skipped using _notrun.
>     
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/README b/README
> index 4c4f22f85..42baff07b 100644
> --- a/README
> +++ b/README
> @@ -245,6 +245,10 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> + - setenv XFS_IO_AVOID, which may contain a list of space separated
> +   xfs_io commands which will be avoided in case you want to exclude
> +   tests that require the use of certain file system operations such
> +   as "fpunch", "fcollapse", "finsert", or "zero".
>  
>  ______________________
>  USING THE FSQA SUITE
> diff --git a/common/rc b/common/rc
> index eb67e0cdc..d1c07a4d0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2485,6 +2485,11 @@ _require_xfs_io_command()
>  	local opts=""
>  	local attr_info=""
>  
> +	if echo "$XFS_IO_AVOID" | grep -wq -- "$command"
> +	then
> +		_notrun "Avoiding xfs_io $command"
> +	fi
> +
>  	local testfile=$TEST_DIR/$$.xfs_io
>  	local testio
>  	case $command in
