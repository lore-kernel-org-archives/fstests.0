Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18047C77B7A
	for <linux-fstests@archiver.kernel.org>; Thu, 25 May 2023 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbjEYTTn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 May 2023 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbjEYTTb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2023 15:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E05BAD
        for <fstests@vger.kernel.org>; Thu, 25 May 2023 12:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1391638E5
        for <fstests@vger.kernel.org>; Thu, 25 May 2023 19:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A37C433EF;
        Thu, 25 May 2023 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685041993;
        bh=AkMJsTA1aCzWfO+Dfh33mfr2rTBm3RZs2g5VQ1DOqOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWg5uN3+TYy+BaFf6IlJAtLVpiamFf6ovExUjnlrAUXnt2/MuwsxSe+XSix0s1j4q
         sY+uT/hfiA3Oy8bZKzMMGPzSTYo3Q6stfyqdyCvmSpPL4gdPNubcCrt1Lvsdve3RPy
         aCI0AeKqQSNkBOTxc47K46pOvlgcgvxEcYkoMQzFbJR8dvcLgPt05rhyqmmyu0vb/0
         VKWjIBZcb/4qnvAoNw552gZrpWnqBYNV2puXpr1vXatBaandvxfldDjjl3bfLM+QwR
         gBj1yHrSdp93PrhpBYy6Id9d0lUy3zL4jmCth/NqXD7udp7teYbt6p5wH9VkZRkYv3
         nM3BF7n1XHqug==
Date:   Thu, 25 May 2023 12:13:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     cem@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230525191312.GE11607@frogsfrogsfrogs>
References: <20230524134207.38224-1-cem@kernel.org>
 <20230524151650.GC11607@frogsfrogsfrogs>
 <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 25, 2023 at 12:36:05PM +0800, Zorro Lang wrote:
> On Wed, May 24, 2023 at 08:16:50AM -0700, Darrick J. Wong wrote:
> > On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > 
> > > Calling _test_mkfs on an already initialized xfs FS will fail as the
> > > initialization is not enforced by '-f' argument, unless it's included in
> > > MKFS_OPTIONS.
> > > So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> > > for xfs filesystems.
> > > 
> > > So, adding the a specific xfs optiong in _test_mkfs using -f argument
> > > makes RECREATE_TEST_DEV actually useful.
> > > 
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > 
> > Makese sense to me,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Hi Darrick,
> 
> I just noticed that there's not any place use "_test_options mkfs", I remembered
> SCRATCH_DEV support rtdev and logdev, the TEST_DEV looks not support that, but
> the "_test_options()" looks like hoping to support.

Hmmm, that's a very good point -- _test_mkfs() fails to format a test
filesystem with external logs or rt volumes even if the config specified
that.  Perhaps change the patch to add:

    xfs)
        _test_options mkfs
        $MKFS_XFS_PROG -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
        ;;

Does that look right?

--D

> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > > ---
> > >  common/rc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 37074371..dd5d7bc1 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -605,6 +605,9 @@ _test_mkfs()
> > >      ext2|ext3|ext4)
> > >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> > >  	;;
> > > +    xfs)
> > > +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> > > +	;;
> > >      *)
> > >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> > >  	;;
> > > -- 
> > > 2.30.2
> > > 
> > 
> 
