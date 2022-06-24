Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A838BC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 02:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiFXCOy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 22:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFXCOw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 22:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E6A5131A
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 19:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656036891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sWosHOu+epx4S+qpdqSR0Uu9vvQZkMC5mrZwpG0848U=;
        b=iYDXu+ytYl1ARhAReBIM3WQmqHTIvs5+pQqcPmxaKMICv/nDjE5jTNTBPYJFHhWQX9GK+H
        m8WQH6Qzuyt96OfacEjcjuSWUZjMrtaYT5ICjwQ7K3f9Ql1kLCBpBQqyADSmrG4OZ2I03r
        SlyK4DLkgHNXQ7o5XwRpIYkazeRCwsA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-k00GGrKJNlGpEY6TxpVcqQ-1; Thu, 23 Jun 2022 22:14:47 -0400
X-MC-Unique: k00GGrKJNlGpEY6TxpVcqQ-1
Received: by mail-qk1-f199.google.com with SMTP id ay8-20020a05620a178800b006a76e584761so1155243qkb.13
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 19:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWosHOu+epx4S+qpdqSR0Uu9vvQZkMC5mrZwpG0848U=;
        b=gi1jXPsrjJ5d48GCf4CG0cWnC6rrDZZLbzIJO8fSV3zx8pwSqTiuGjAhnHctu6OJEV
         T+Zkh2jiaavdyd1MMJglC2ZAIC/jINSqAHc2pbnsJ9V1nQSW0EYnENVdf104KjzvN/aQ
         zmSpEPFAjAZqrTSRh4iu+kwm+IGRys+3jOqr816WblHU6nfBvuccJVZSq7/ZzA5oR/TC
         dOTvA213UxCAeIURWxBEkGKyJ1dlbS0cTj2lsP0lhsm7ZHh1OjCX9Ce1vtm3NP1kklaw
         vBW6QrQzRJb1ZLmUhSfy9CsJfRFR0knF25GdptyObcYyDD4aQiWrf3MVcNBORvYIGkRu
         F0zQ==
X-Gm-Message-State: AJIora+CFMsMVrqvFUG60u2C7YcTH6IdyFKEQeWODTVK7v1uWxHDDzSz
        bznkRsaH8Z7GksO+jnJPpoaaDm4HyPKQv0UBgrWXh38ybz0Y9X7qlbx3KvafOOnsFw4NjOkW3Gt
        wLNYAa54OKoSN5RrkSg==
X-Received: by 2002:ac8:5f8e:0:b0:305:c71:3aa0 with SMTP id j14-20020ac85f8e000000b003050c713aa0mr11221602qta.152.1656036886694;
        Thu, 23 Jun 2022 19:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sj7owTnijciCQRkbyy98nBQk8SJZVfFqAF+p7SFOYPi6jAUMkBar6i2mqWHF0fef0dtdDx/Q==
X-Received: by 2002:ac8:5f8e:0:b0:305:c71:3aa0 with SMTP id j14-20020ac85f8e000000b003050c713aa0mr11221592qta.152.1656036886394;
        Thu, 23 Jun 2022 19:14:46 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a5-20020ac85b85000000b00307cb34aa8asm745911qta.47.2022.06.23.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:14:45 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:14:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     An Long <lan@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <20220624021440.iday5lmkmtuff5if@zlang-mailbox>
References: <20220623160825.31788-1-lan@suse.com>
 <YrSuSKLKA6LMjyf/@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrSuSKLKA6LMjyf/@magnolia>
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
> 
> >  ______________________
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

Hi Darrick,

That's another story from this patch review:
https://lore.kernel.org/fstests/20220616043845.14320-1-lan@suse.com/

Any more review points about that?

Thanks,
Zorro

> 
> --D
> 
> > +        _fatal "error: \$MKFS_OPTIONS: Only number in bytes is allowed, no units."
> > +fi
> > +
> >  # make sure this script returns success
> >  /bin/true
> > -- 
> > 2.35.3
> > 
> 

