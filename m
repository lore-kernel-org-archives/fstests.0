Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96187C43334
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Jun 2022 02:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiFZCKL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 22:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiFZCKJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 22:10:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F313E85
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 19:10:06 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25Q29xmO025234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jun 2022 22:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656209401; bh=AUrmVzktZxGbc/BmKs/VMqwPaoxzWVIDStTzX+kGWJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ph0ieLSlMeljl3pT86j8TR+HoM7ROxKx8AXpD7TsKGf67MDGNZNWkqz0+xFWZhQdS
         KWssHfUmwreddGeZoxPTPkuqp3jvWzl+iJazTVwhmPhAh8GHoivrFP076Zx4KiIx5q
         l2mxc5drzg3JrgVlxr9bzuD+03O7t/ocU7XdBI4o0cM/31vuYK7+ZrMlUHxJMaq7+H
         F2Tg1CyEYuTtSd36GuQ2sG2aEYWc/KvlLXRXSVlraeq9UXH4Efba6iJcVEnS0FleV2
         mVA8RmgBO3UWsjcRlPfYK1oiLjVJmUieul+0gfwP1voLAEVX0jVd2VYnpq9Kqt2IhQ
         79BS+htFnFj/g==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id C87638C32D6; Sat, 25 Jun 2022 22:09:58 -0400 (EDT)
Date:   Sat, 25 Jun 2022 22:09:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     An Long <lan@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <Yre/9qV62dtVyCvn@mit.edu>
References: <20220623160825.31788-1-lan@suse.com>
 <Yrc6Pz67mL56ML6j@mit.edu>
 <20220625224708.GJ1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625224708.GJ1098723@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 26, 2022 at 08:47:08AM +1000, Dave Chinner wrote:
> > If we want to go down that approach, perhaps another approach would be
> > to specify the desired blocksize diretly in the fs config.  Something
> > like "FS_BLOCK_SIZE=1024"?  We can then have the fs-specific mkfs
> > commands translate that into the appropriate "-b 1024" or whatever
> > else might be appropriate for a particular file system.  And then
> > tests that want to override the block size can just override
> > FS_BLOCK_SIZE and then the _mkfs function can use it as appropriate.
> 
> This is the right way to fix the problem.
> 
> My plan was that once there was a single point of checking of
> MKFS_OPTIONS, I'd use that to extract the default value ifor the
> entire fstests run and convert everything else to use it. And then
> add config section support for the variable so that it can easily be
> specified on a config section by section basis.

Nice, that sounds like a good way to go.

And if we start down this path, for those file systems that support a
clustered allocation mode, what I'd then propose adding is a
FS_CLUSTER_SIZE parameter, so that the cluster size could be specified
in the config, hich could then get translated by the _mkfs_XXX
function into the appropriate mkfs option --- AND, so that generic
tests that are testing quota can just check the value of
$FS_CLUSTER_SIZE, and if it's set, use that to determine the
granularity of quota tracking.

This avoids having tests need to use fs-specific tools (such as
dumpe2fs) to determine if (a) clustered allocation is enabled, and (b)
what the cluster size is.

More generally, for any file system feature which is supported by more
than one file system[1], instead of explicitly specifying it via
MKFS_OPTIONS and/or MOUNT_OPTION, we could specify it abstractly,
which will make it easier for those tests who either need to override
that setting, or test to see what that setting might be.  This should
allow us to reduce the number of instances of "case $FSTYPE ..." in
tests/generic/*, which would be a very good thing.

[1] Examples of file system features that could use this include
fscrypt, case folding and maybe DAX.  We're mostly doing this for
external log devices already.

					- Ted
