Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B3C6FA82
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 02:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIUCyP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 22:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUCyN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 22:54:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9B7E316
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 19:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB4FCB82E0D
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 02:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C2C433D7;
        Wed, 21 Sep 2022 02:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663728832;
        bh=zEHAtRCvftxqN6Z3DsqnzMl+f3oROauZECM8gW7fts4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPd/GGwuKEs7t37y3++k66fqi6dfs0azkH8IFHv25XL5FQGjAlyMY6Rqyfy3jPNTe
         MV0VtIxaBJNIzcJ+lkSHhdL/AWIuTQF0usrfM+qellgw2XFH1R2VBRSKmU2rYj2Km7
         8tN+VYhqpa75cLLNiU/8bUXs//tFhzlqLqkcfYHLkQ9SkiOKST123ZbAY0KGPO1RMb
         QMOHZdR8nz/mgYHEehG1jwQpswsUScbDOr4k24akdbqiI/0aHs8ShPBazzP1RWNfyv
         s3QGxM70Y/mZzJZxtDSg+veZ7IxEfhO+u/Ba/wtLb9x5yP0DUV07joD4RqIvW5x/Kv
         Kiwuj02EuPybg==
Date:   Tue, 20 Sep 2022 19:53:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/2] common: new helper to alloacate fixed size files
Message-ID: <Yyp8wE63C1IdtBd1@magnolia>
References: <20220920073514.285136-1-preichl@redhat.com>
 <20220920073514.285136-2-preichl@redhat.com>
 <20220921024857.yyqrxniqfhvihyyx@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921024857.yyqrxniqfhvihyyx@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 21, 2022 at 10:48:57AM +0800, Zorro Lang wrote:
> On Tue, Sep 20, 2022 at 09:35:13AM +0200, Pavel Reichl wrote:
> > Helper that creates files of specified size using falloc if supported,
> > otherwise pwrite is used.
> > 
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> >  common/rc         | 13 +++++++++++++
> >  tests/generic/694 |  2 +-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index a25cbcd0..77866582 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4925,6 +4925,19 @@ hexdump()
> >  	_fail "Use _hexdump(), please!"
> >  }
> >  
> > +# Helper to write a file containing specified number of bytes using
> > +# falloc if supported, otherwise use pwrite
> > +_create_sizedfile()
> > +{
> > +	length=$1
> > +	file=$2
> > +
> > +	$XFS_IO_PROG -F -fc "falloc 0 $length" $file 2>&1 | grep -q "Operation not supported"
> > +	if [ $? -eq 0 ]; then
> > +		$XFS_IO_PROG -F -fc "pwrite -W 0 $length" $file >/dev/null
> > +	fi
> > +}
> 
> I think about it more, above code might ignore a failed falloc, if it's not failed
> by "Operation not supported" but really fails, this function won't print or return
> any valid things.
> 
> So how about we write it like below (for reference only):
> 
> # Try to create a file which inode->i_blocks = $length (maybe a little bigger
> # than expect)
> _create_file_sized()
> {
> 	local length=$1
> 	local file=$2
> 	local tmp=`mktemp -u`
> 	local ret=0
> 
> 	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
> 	ret=$?
> 	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
> 		# fallocate isn't supported, fallback to general buffer write
> 		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
> 		ret=$?
> 	fi
> 	[ $ret -ne 0 ] && cat $tmp.out
> 	rm -f $tmp.out
> 	return $ret
> }
> 
> Even though, I think this function might still not good, feel free to tell me if
> anyone has better idea/suggestion about how to get a file with specified
> inode->i_blocks.

Looks reasonable enough to /me...

--D

> Thanks,
> Zorro
> 
> > +
> >  init_rc
> >  
> >  ################################################################################
> > diff --git a/tests/generic/694 b/tests/generic/694
> > index dfd988df..64c3dd9a 100755
> > --- a/tests/generic/694
> > +++ b/tests/generic/694
> > @@ -30,7 +30,7 @@ junk_dir=$TEST_DIR/$seq
> >  junk_file=$junk_dir/junk
> >  mkdir -p $junk_dir
> >  
> > -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> > +_create_sizedfile 4G $junk_file
> >  
> >  iblocks=`stat -c '%b' $junk_file`
> >  
> > -- 
> > 2.37.3
> > 
> 
