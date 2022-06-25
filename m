Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696CC433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiFYQik (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiFYQij (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 12:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EB74140CC
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656175117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCUtSUzCHnEfGfK0za5qfgk1vUv/CB3CbTgx8bH6p50=;
        b=SSnfpLl8f6wrcoM592fNXxa7jqf4e6A97QT9o5vFo6WXxMK9R2M0v4vkTXluIT0klq4FcH
        T+p9j1UQ6pC+i5q7gxyWaBDq/O3IWxIhWvfrYXyedTlMYgrsL8SUksk1kyE7I2XhNHcgvN
        UQyz0Mr1+BDbq7WL51JbuIyAhAudyi0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-iGD2w4sLOD-6gFl-eB9KyQ-1; Sat, 25 Jun 2022 12:38:36 -0400
X-MC-Unique: iGD2w4sLOD-6gFl-eB9KyQ-1
Received: by mail-qv1-f69.google.com with SMTP id 7-20020a0562140d0700b0046bd3ff4a9dso5513481qvh.10
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 09:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BCUtSUzCHnEfGfK0za5qfgk1vUv/CB3CbTgx8bH6p50=;
        b=dJai7Fsju11lq1MyBLRA96iKssFL/PYWSQwXtSej2aXWiBYMcqQ7RDXgFzZ6iukz2a
         8Vw1YTeCE4ombzTGq0jN4sbVXCzkxtnlml2KmBhsyoZSNPsd5oQwI4xqObL6gJQHlWE8
         AAnADBvJJzRRj4zX6xXKHnj+QVEL8QxrXcFps3Iq448tapkKBZ8W61dVSQNuLbz/KqlK
         PWrPtiZ08UIALS2oXpOdtt1aaTM9niXpfZ59O5hDko/AQ8GUFFjrI3ofsPjy21ZJeFrx
         7QAvNRzkZrTANCxjR8DtQf16k/P91FABXOtXoTAxbaHX0a0POdsnf93GHGTbOh4+56xl
         ocwg==
X-Gm-Message-State: AJIora9khat6tCkldyc8pmfLBrooE7wwn1aW+Kz9RlAqnxeSEz30u2eM
        HJ0L5lFQKI29ABVuLS5RNKwt+pQ3BpJq+/X5Dc7n+jlSAXQVIPF72tZ0+MHqReFHfVsnVNeZ4Li
        xC3N+pMAsHuFBvIQ71A==
X-Received: by 2002:a05:620a:370c:b0:6a6:d364:fc with SMTP id de12-20020a05620a370c00b006a6d36400fcmr3299526qkb.720.1656175115581;
        Sat, 25 Jun 2022 09:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsyQK1KNV53grEH0DIxzkkVEFH/wBqCqVLQY6i/OdmH4+9chWdQqPOZomkW76tCh6J27fiCA==
X-Received: by 2002:a05:620a:370c:b0:6a6:d364:fc with SMTP id de12-20020a05620a370c00b006a6d36400fcmr3299503qkb.720.1656175115216;
        Sat, 25 Jun 2022 09:38:35 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j12-20020ac874cc000000b00304e29c9a6asm3454596qtr.91.2022.06.25.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 09:38:34 -0700 (PDT)
Date:   Sun, 26 Jun 2022 00:38:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, david@fromorbit.com
Cc:     Long An <lan@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <20220625163828.nq7sy5gvx5vvuk6n@zlang-mailbox>
References: <20220623160825.31788-1-lan@suse.com>
 <YrSuSKLKA6LMjyf/@magnolia>
 <20220624024141.GI1098723@dread.disaster.area>
 <d7d49af51014829438bab8c30da3f8c2e5fedd1d.camel@suse.com>
 <YrZ9z/vok66YwMYn@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrZ9z/vok66YwMYn@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 08:15:27PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 24, 2022 at 03:29:43AM +0000, Long An wrote:
> > On Fri, 2022-06-24 at 12:41 +1000, Dave Chinner wrote:
> > > On Thu, Jun 23, 2022 at 11:17:44AM -0700, Darrick J. Wong wrote:
> > > > On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
> > > > > _scratch_mkfs_sized() only receive integer number of bytes as a
> > > > > valid
> > > > > input. But if the MKFS_OPTIONS variable exists, it will use the
> > > > > value of
> > > > > block size in MKFS_OPTIONS to override input. In case of
> > > > > MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096.
> > > > > This
> > > > > will give errors to ext2/3/4 etc, and brings potential bugs to
> > > > > xfs or
> > > > > btrfs.
> > > > > 
> > > > > Therefore, add validation check to force MKFS_OPTIONS to use pure
> > > > > integer in bytes for any size value.
> > > > > 
> > > > > Signed-off-by: An Long <lan@suse.com>
> > > > > ---
> > > > >  README        | 3 ++-
> > > > >  common/config | 5 +++++
> > > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/README b/README
> > > > > index 80d148be..7c2d3334 100644
> > > > > --- a/README
> > > > > +++ b/README
> > > > > @@ -241,7 +241,8 @@ Misc:
> > > > >     this option is supported for all filesystems currently only
> > > > > -overlay is
> > > > >     expected to run without issues. For other filesystems
> > > > > additional patches
> > > > >     and fixes to the test suite might be needed.
> > > > > -
> > > > > + - If MKFS_OPTIONS is used, the size value must be an integer
> > > > > number of bytes
> > > > > +   without units. For example, set MKFS_OPTIONS="-b 4096" but
> > > > > not "-b 4k".
> > > > 
> > > > IDGI.  mkfs.$FSTYP does its own input validation, which means that
> > > > fstest
> > > > runners are required to set MKFS_OPTIONS to something that mkfs
> > > > will
> > > > accept.  It's not the job of fstests to add /another/ layer of
> > > > validation...
> > > 
> > > It's not validating it - it refelecting the fact that fstests parses
> > > the block device size out of MKFS_OPTIONS and does integer math on
> > > it and does not handle human readable units....
> > > 
> > > > >  USING THE FSQA SUITE
> > > > >  ______________________
> > > > > diff --git a/common/config b/common/config
> > > > > index de3aba15..ec723ac4 100644
> > > > > --- a/common/config
> > > > > +++ b/common/config
> > > > > @@ -896,5 +896,10 @@ else
> > > > >  	fi
> > > > >  fi
> > > > >  
> > > > > +# check the size value in $MKFS_OPTIONS is an integer
> > > > > +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
> > > > 
> > > > ...because this regex will break /any/ MKFS_OPTIONS with a number
> > > > followed by a letter.  mkfs.xfs handles units just fine, so I don't
> > > > understand why you're adding this blunt instrument.
> > > > 
> > > > MKFS_OPTIONS='-b size=1k' works just fine for XFS.
> > > 
> > > Except it where it doesn't.
> > > 
> > > For example, _scratch_mkfs_sized does unexpected stuff
> > > because it assumes filesystem block sizes are all in bytes when it
> > > tries to parse the custom test block sizes out of MKFS_OPTIONS to
> > > set the default block size.
> > > 
> > > https://lore.kernel.org/fstests/20220616043845.14320-1-lan@suse.com/
> > > 
> > > In this case, using "1k" in the XFS mkfs specifications results in
> > > the default block size is incorrectly calculated:
> > > 
> > > $ echo "-bsize=1024" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
> > > 1024
> > > $ echo "-bsize=1k" | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'
> > > 1
> > > $
> > > 
> > > So it sets the block size to 1, not 1024.
> > > 
> > > But then this bug is covered up later on by this code:
> > > 
> > >                 # don't override MKFS_OPTIONS that set a block size.
> > >                 echo $MKFS_OPTIONS |egrep -q "b?size="
> > >                 if [ $? -eq 0 ]; then
> > >                         _scratch_mkfs_xfs -d size=$fssize $rt_ops
> > >                 else
> > >                         _scratch_mkfs_xfs -d size=$fssize $rt_ops -b
> > > size=$blocksize
> > >                 fi
> > > 
> > > Which omits the poorly calculated block size because there's
> > > already a block size specified in the MKFS_OPTIONS so it ignores the
> > > fact it calculated the block size incorrectly from MKFS_OPTIONS.
> > > 
> > > But it also means that if the test specifies a block size via
> > > 
> > > _scratch_mkfs_sized $((256 * 1024 * 1024)) 2048
> > > 
> > > Then _scratch_mkfs_sized does the wrong thing for XFS if there is
> > > a MKFS_OPTIONS specified block size.....
> > > 
> > > Other filesystems, like ext4, don't have this magic "don't override
> > > MKFS_OPTIONS" code that XFS does here, so they are exposed to the
> > > block size calculation bugs when human readable units are used. But
> > > then they don't have the "ignore test specified block size" bug and
> > > <head explodes>
> > > 
> > > The whole thing is a mess of bugs and technical debt. Randomly
> > > adding more complex regexes and string parsing to random bits of
> > > fstests to support doing integer math on human readable units in
> > > random variables doesn't improve this situation at all.
> 
> Ah, ok.  I hadn't realized there was /more/ history to this patch than
> just some random change that looked weird on its own.
> 
> > > Hence my suggestion that we set a requirement that all block size
> > > specifications in MKFS_OPTIONS are in byte units, and we check and
> > > enforce that once at startup. With that requirement in place, we can
> > > clean up all this mess knowing that we only have to support integer
> > > units...
> > > 
> > > What I expected to see was a function like:
> > > 
> > > _check_mkfs_block_options()
> > > {
> > > 	case $FSTYP:
> > > 	xfs)
> > > 		# check for -b?size= option in integer format
> > > 		# exit if not valid
> > > 	ext4)
> > > 		# check for -b <num> option in integer format
> > > 		# exit if not valid
> > > 	.....
> > > }
> > > 
> > Hello Dave,
> > 
> > Actually, I have tried the above methods. It's works, but we have to
> > add specific function for specific type of size?
> > Such as node size, sector size, device size or cluster size.
> 
> Personally I thought the v2 approach of fixing _scratch_mkfs_sized was
> better, since it's a much smaller change than making fstests reject all
> unit-having numbers and then everyone has to update their fstests
> wrappers.  I know we like to pretend that nobody wraps fstests, but
> everyone wraps fstests in even more bash goo.
> 
> Also I didn't like the fact that (I think) this patch would reject
> something like MKFS_OPTIONS='-m dirhandling=3bsd' or something like
> that.

Hmm.. you're right. That's too radicalized if refuse any "[0-9]+[^0-9\ ]"
in MKFS_OPTIONS ...

Let's back to the original problem we tried to fix:
https://lore.kernel.org/fstests/20220616043845.14320-3-lan@suse.com/

So the real problem is in _scratch_mkfs_sized() function:

  _scratch_mkfs_sized()
  {
        local fssize=$1
        local blocksize=$2
        local def_blksz

        case $FSTYP in
        xfs)
                def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
                ;;
        btrfs)
                def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
                ;;
        ext2|ext3|ext4|ext4dev|udf|reiser4|ocfs2|reiserfs)
                def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
                ;;
        jfs)
                def_blksz=4096
                ;;
        esac

        [ -n "$def_blksz" ] && blocksize=$def_blksz
        [ -z "$blocksize" ] && blocksize=4096
	...
	...

Due to _scratch_mkfs_sized() hope to get blocksize from MKFS_OPTIONS, but it
can't deal with blocksize with an unit (e.g. "k") correctly.

Others _scratch_mkfs_* functions (_scratch_mkfs_ext4, _scratch_mkfs_xfs,
_scratch_mkfs_geom, _scratch_mkfs_blocksized, _scratch_mkfs_richacl) don't
have this problem, due to they don't try to get anything from MKFS_OPTIONS
(_scratch_mkfs_geom just trys to replace something with proper pattern).

If only focus on the issue in _scratch_mkfs_sized() simply. We have three
choices, if MKFS_OPTIONS doesn't use pure integer:

1) As V2 patch, convert it to pure integer.
2) Do _fail or _notrun directly in this function, to warn that pure integer
   is necessary.
3) Do nothing, just document it.

The 1st choice might bring in some performance lose, if the users set something
in local.config likes MKFS_OPTIONS="-b size=1k". But nearly no effect, if the
users use pure integer.

The 2nd choice is similar with the 1st, if use pure integer. But it save some
time if it's not pure integer, due to it exit directly, won't try to calculate.

The 3rd choice changes nothing, push the problem back to users, and depends on if
they read the doc carefully.

I originally would like to take the 1st one. But I can accept the 2nd one too,
if there're strong objections to the 1st one. About the 3rd one, I'm wondering
how to help most of users to notice that.

What do you think?

Thanks,
Zorro

> 
> Anyway, I'll go focus on other things.
> 
> --D
> 
> > Thanks,
> > An Long
> > 
> > > called from get_next_config() similar to how we call _check_device
> > > on every block device for existence after reading them from the
> > > config file.
> > > 
> > > Cheers,
> > > 
> > > Dave.
> 

