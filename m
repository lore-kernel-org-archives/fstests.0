Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B7DC43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 02:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiFXCls (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFXClr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 22:41:47 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 800F35674A
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 19:41:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C6E8D10E7833;
        Fri, 24 Jun 2022 12:41:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o4ZGP-00AKh9-98; Fri, 24 Jun 2022 12:41:41 +1000
Date:   Fri, 24 Jun 2022 12:41:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     An Long <lan@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <20220624024141.GI1098723@dread.disaster.area>
References: <20220623160825.31788-1-lan@suse.com>
 <YrSuSKLKA6LMjyf/@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrSuSKLKA6LMjyf/@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62b52467
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=dqjxnPYryD76r1QbGpYA:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 23, 2022 at 11:17:44AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
> > _scratch_mkfs_sized() only receive integer number of bytes as a valid
> > input. But if the MKFS_OPTIONS variable exists, it will use the value of
> > block size in MKFS_OPTIONS to override input. In case of
> > MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This
> > will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
> > btrfs.
> > 
> > Therefore, add validation check to force MKFS_OPTIONS to use pure
> > integer in bytes for any size value.
> > 
> > Signed-off-by: An Long <lan@suse.com>
> > ---
> >  README        | 3 ++-
> >  common/config | 5 +++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/README b/README
> > index 80d148be..7c2d3334 100644
> > --- a/README
> > +++ b/README
> > @@ -241,7 +241,8 @@ Misc:
> >     this option is supported for all filesystems currently only -overlay is
> >     expected to run without issues. For other filesystems additional patches
> >     and fixes to the test suite might be needed.
> > -
> > + - If MKFS_OPTIONS is used, the size value must be an integer number of bytes
> > +   without units. For example, set MKFS_OPTIONS="-b 4096" but not "-b 4k".
> 
> IDGI.  mkfs.$FSTYP does its own input validation, which means that fstest
> runners are required to set MKFS_OPTIONS to something that mkfs will
> accept.  It's not the job of fstests to add /another/ layer of
> validation...

It's not validating it - it refelecting the fact that fstests parses
the block device size out of MKFS_OPTIONS and does integer math on
it and does not handle human readable units....

> >  USING THE FSQA SUITE
> >  ______________________
> > diff --git a/common/config b/common/config
> > index de3aba15..ec723ac4 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -896,5 +896,10 @@ else
> >  	fi
> >  fi
> >  
> > +# check the size value in $MKFS_OPTIONS is an integer
> > +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
> 
> ...because this regex will break /any/ MKFS_OPTIONS with a number
> followed by a letter.  mkfs.xfs handles units just fine, so I don't
> understand why you're adding this blunt instrument.
> 
> MKFS_OPTIONS='-b size=1k' works just fine for XFS.

Except it where it doesn't.

For example, _scratch_mkfs_sized does unexpected stuff
because it assumes filesystem block sizes are all in bytes when it
tries to parse the custom test block sizes out of MKFS_OPTIONS to
set the default block size.

https://lore.kernel.org/fstests/20220616043845.14320-1-lan@suse.com/

In this case, using "1k" in the XFS mkfs specifications results in
the default block size is incorrectly calculated:

$ echo "-bsize=1024" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
1024
$ echo "-bsize=1k" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
1
$

So it sets the block size to 1, not 1024.

But then this bug is covered up later on by this code:

                # don't override MKFS_OPTIONS that set a block size.
                echo $MKFS_OPTIONS |egrep -q "b?size="
                if [ $? -eq 0 ]; then
                        _scratch_mkfs_xfs -d size=$fssize $rt_ops
                else
                        _scratch_mkfs_xfs -d size=$fssize $rt_ops -b size=$blocksize
                fi

Which omits the poorly calculated block size because there's
already a block size specified in the MKFS_OPTIONS so it ignores the
fact it calculated the block size incorrectly from MKFS_OPTIONS.

But it also means that if the test specifies a block size via

_scratch_mkfs_sized $((256 * 1024 * 1024)) 2048

Then _scratch_mkfs_sized does the wrong thing for XFS if there is
a MKFS_OPTIONS specified block size.....

Other filesystems, like ext4, don't have this magic "don't override
MKFS_OPTIONS" code that XFS does here, so they are exposed to the
block size calculation bugs when human readable units are used. But
then they don't have the "ignore test specified block size" bug and
<head explodes>

The whole thing is a mess of bugs and technical debt. Randomly
adding more complex regexes and string parsing to random bits of
fstests to support doing integer math on human readable units in
random variables doesn't improve this situation at all.

Hence my suggestion that we set a requirement that all block size
specifications in MKFS_OPTIONS are in byte units, and we check and
enforce that once at startup. With that requirement in place, we can
clean up all this mess knowing that we only have to support integer
units...

What I expected to see was a function like:

_check_mkfs_block_options()
{
	case $FSTYP:
	xfs)
		# check for -b?size= option in integer format
		# exit if not valid
	ext4)
		# check for -b <num> option in integer format
		# exit if not valid
	.....
}

called from get_next_config() similar to how we call _check_device
on every block device for existence after reading them from the
config file.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
