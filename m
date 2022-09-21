Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A540ECAAD8
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 06:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIUGCK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 02:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIUGCK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 02:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7979EF8
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663740128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRQ7dPFSxnZyhDoRMUASYstMU006z2ypayMLzCB8OyA=;
        b=LYEpCb/AXZtLW8gKmR/Yya4YKZ2lsWbl0FYO8GN4ueSmIxAozqCuB9HA72vbg/TVShcNiG
        M8cNKZl8olZRZsihaUTVHPzPvkDX1zA7V+ivQ5yyMwLjj81hL7sijeSWfCylLJZKNpLAds
        6cYLiwjuH18cc7jKRB7LS3elNLywhZo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-571-B2P-09GQO4u52CKch9FWWw-1; Wed, 21 Sep 2022 02:02:02 -0400
X-MC-Unique: B2P-09GQO4u52CKch9FWWw-1
Received: by mail-qv1-f71.google.com with SMTP id g4-20020ad45424000000b004a9bb302c85so3606934qvt.22
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 23:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dRQ7dPFSxnZyhDoRMUASYstMU006z2ypayMLzCB8OyA=;
        b=1oguh3wsYtJyb0W1M9QvOXa/KgCA+RbtRP5QWqZ7LFjA4OfNVQWSXwDNuP7EGu6hZb
         837ZH+2L9x05DOlBaDpj9i5Xzn714jDSE785343bm75YxyYh6i8G7EmareMCB/B0aPTJ
         v7Qy0ahylsPnhkfUyBxtTkBHp5kDSh+qRgwgCneza9exT2proxh+zETfhE7sPUCyE5oo
         mo0AyhYF61/fEIawGZGiQ7660zMPgx7YbVgVO4VkAyEUxUa4fkwmWLsMx58ejUGbH0xy
         Kd12J09T4KpdN1zH9K/dmm6X6Ri9jJTFvh+m6I+34L8Je6I1Dd3LGY1eSbJjTtCBpFHA
         lb8A==
X-Gm-Message-State: ACrzQf1tD8SRVJ5TROfd757IY6zfOqNi24oXR3oya/HIqT+NhNCbKQGJ
        OlbQtfpZAmU35FzpKgwlrFESId5oYuS2FOSgffqyiUc4iOPbYudiej1INuL7TM29EFaHLw/rpA9
        kSxFMBeLud/Y82SaZ2Q==
X-Received: by 2002:a05:622a:60d:b0:343:808:f55c with SMTP id z13-20020a05622a060d00b003430808f55cmr21968448qta.438.1663740121462;
        Tue, 20 Sep 2022 23:02:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43QX5mel8MWnAWpoAfdrBmjK2rPii7DmZQvfaslwt+SxMqCjh36J8QCb30KHFqM7uCpbd1Fg==
X-Received: by 2002:a05:622a:60d:b0:343:808:f55c with SMTP id z13-20020a05622a060d00b003430808f55cmr21968440qta.438.1663740121215;
        Tue, 20 Sep 2022 23:02:01 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a415000b006cbe3be300esm1427527qko.12.2022.09.20.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 23:02:00 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:01:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 1/2] common: new helper to alloacate fixed size files
Message-ID: <20220921060156.2glkfo26tx2fktnm@zlang-mailbox>
References: <20220920073514.285136-1-preichl@redhat.com>
 <20220920073514.285136-2-preichl@redhat.com>
 <20220921024857.yyqrxniqfhvihyyx@zlang-mailbox>
 <Yyp8wE63C1IdtBd1@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyp8wE63C1IdtBd1@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 07:53:52PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 21, 2022 at 10:48:57AM +0800, Zorro Lang wrote:
> > On Tue, Sep 20, 2022 at 09:35:13AM +0200, Pavel Reichl wrote:
> > > Helper that creates files of specified size using falloc if supported,
> > > otherwise pwrite is used.
> > > 
> > > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > > ---
> > >  common/rc         | 13 +++++++++++++
> > >  tests/generic/694 |  2 +-
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index a25cbcd0..77866582 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4925,6 +4925,19 @@ hexdump()
> > >  	_fail "Use _hexdump(), please!"
> > >  }
> > >  
> > > +# Helper to write a file containing specified number of bytes using
> > > +# falloc if supported, otherwise use pwrite
> > > +_create_sizedfile()
> > > +{
> > > +	length=$1
> > > +	file=$2
> > > +
> > > +	$XFS_IO_PROG -F -fc "falloc 0 $length" $file 2>&1 | grep -q "Operation not supported"
> > > +	if [ $? -eq 0 ]; then
> > > +		$XFS_IO_PROG -F -fc "pwrite -W 0 $length" $file >/dev/null
> > > +	fi
> > > +}
> > 
> > I think about it more, above code might ignore a failed falloc, if it's not failed
> > by "Operation not supported" but really fails, this function won't print or return
> > any valid things.
> > 
> > So how about we write it like below (for reference only):
> > 
> > # Try to create a file which inode->i_blocks = $length (maybe a little bigger
> > # than expect)
> > _create_file_sized()
> > {
> > 	local length=$1
> > 	local file=$2
> > 	local tmp=`mktemp -u`
> > 	local ret=0
> > 
> > 	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
> > 	ret=$?
> > 	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
> > 		# fallocate isn't supported, fallback to general buffer write
> > 		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
> > 		ret=$?
> > 	fi
> > 	[ $ret -ne 0 ] && cat $tmp.out
> > 	rm -f $tmp.out
> > 	return $ret
> > }
> > 
> > Even though, I think this function might still not good, feel free to tell me if
> > anyone has better idea/suggestion about how to get a file with specified
> > inode->i_blocks.
> 
> Looks reasonable enough to /me...

Thanks for your review, Darrick.

Hi Pavel, the [PATCH 2/2] looks good to me. I'll merge this patchset after you
making this change.

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > +
> > >  init_rc
> > >  
> > >  ################################################################################
> > > diff --git a/tests/generic/694 b/tests/generic/694
> > > index dfd988df..64c3dd9a 100755
> > > --- a/tests/generic/694
> > > +++ b/tests/generic/694
> > > @@ -30,7 +30,7 @@ junk_dir=$TEST_DIR/$seq
> > >  junk_file=$junk_dir/junk
> > >  mkdir -p $junk_dir
> > >  
> > > -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> > > +_create_sizedfile 4G $junk_file
> > >  
> > >  iblocks=`stat -c '%b' $junk_file`
> > >  
> > > -- 
> > > 2.37.3
> > > 
> > 
> 

