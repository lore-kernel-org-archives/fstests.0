Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D15ECAAD4
	for <linux-fstests@archiver.kernel.org>; Wed, 31 Aug 2022 09:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiHaJcJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaJcI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Aug 2022 05:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD7DCAC56
        for <fstests@vger.kernel.org>; Wed, 31 Aug 2022 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661938326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n9sDWo5d7StxOpV9Tn2iRUhL7upGYy5DsD1f6h8ZxAE=;
        b=h/6qZjBFlLZR14iUuN6ucRKMKm2iTOWUpdgY1mp/ogQvV1mQ88n1IfEbpfA7W8FwIaxudv
        XAL+rL6ccsCrleuodXRtrijErzeXE+EXlr1Y0ZywL5h3Hn7T/5rK3gXi/VKFs9bI3txb12
        dt34KMhJLxqar5bZfriI9PwjQWrR2Rs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-8v6aF6HpO42RIzZTAdnUmg-1; Wed, 31 Aug 2022 05:31:58 -0400
X-MC-Unique: 8v6aF6HpO42RIzZTAdnUmg-1
Received: by mail-qv1-f70.google.com with SMTP id b16-20020ad45190000000b004972d2dbdbcso8748761qvp.1
        for <fstests@vger.kernel.org>; Wed, 31 Aug 2022 02:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n9sDWo5d7StxOpV9Tn2iRUhL7upGYy5DsD1f6h8ZxAE=;
        b=qNAmRRkZmVPI+GFln3ly7d7PaQADKncdj2zpa/Qspb66S6mFdguFi/+M2AfvJnA5es
         O4uh8Jtg5jJIgns5cgs+ZerZGV7cnxDF2Ml+gyMLLntyTh11LgJJuKj7/xnz7xrpFgfW
         ZQ8psJ+kqbx4Tkxk6BUZSjWdOlKjUMM1c5Y2Q/Ac74qkj3PuMzky8LD1Fg4GVOe9G9xG
         Il4V17GbfX0d9RkpFFyD5KlGmK7fLcUA6Of7ClTd0y7kAp8UBFy0zfFuFPXyHJEGP3ET
         jSvoL5A0zz9Zl4PdVLMypp4J2zQ7ikwwPtFGuUeZmKBIJYrWBtVp+f+fmM3g+bG78adf
         CXsQ==
X-Gm-Message-State: ACgBeo1hgT2t2NgD7ohOmvhy0X/z9+uRrIbVIql/3w8eUTqhDJynlZfJ
        o8MFHkyVJ8WEPJ0Aa7HrRihp7Tiv3fLD34IbMhnXUsK71521QK31dBrPub5PBqSyylgsWhGYOu6
        vVbw/apYctNHWfE5mNw==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr17269491qvb.18.1661938317300;
        Wed, 31 Aug 2022 02:31:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TUOpPt16yLfxBTLpHNf6hB8oXsjEuVGBi0TQVXrcV36hhqOh/wOWOo/hUGfvtIYT4tFnCAQ==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr17269481qvb.18.1661938317091;
        Wed, 31 Aug 2022 02:31:57 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d19-20020ac81193000000b0031f0b43629dsm8272326qtj.23.2022.08.31.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 02:31:56 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:31:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com, linux-ext4@vger.kernel.org,
        tytso@mit.edu, lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220831093148.twysch2nhpajrxpq@zlang-mailbox>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
 <20220829100657.wunvx2twhjzuqckk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829100657.wunvx2twhjzuqckk@quack3>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 29, 2022 at 12:06:57PM +0200, Jan Kara wrote:
> On Sun 28-08-22 10:48:58, Zorro Lang wrote:
> > On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> > > Plan to remove noacl and nouser_xattr mount option in kernel because they
> > > are deprecated[1]. So remove nouser_xattr test in here.
> > 
> > What's the [1]?
> > 
> > We'd better to be careful when we want to remove a testing coverage. I'm not
> > sure if they've decided to removed this mount option, the ext4/053 is an
> > important test case for ext4, so I'd like to hear their opinion.
> 
> Yes, the option is long deprecated and we want to remove it from ext4. But
> I think you might want to see official ack from Ted as a maintainer on this
> :). Ted?

It's fine for me, if anyone stand for ext4 list to give this patch a RVB, due
to it's not a bug fix or new testing, it's a testing deduction, and only affect
ext4 testing.

Thanks,
Zorro

> 
> 								Honza
> 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > ---
> > >  tests/ext4/053 | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/tests/ext4/053 b/tests/ext4/053
> > > index 555e474e..5d2c478a 100755
> > > --- a/tests/ext4/053
> > > +++ b/tests/ext4/053
> > > @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
> > >  	mnt oldalloc removed
> > >  	mnt orlov removed
> > >  	mnt -t user_xattr
> > > -	mnt nouser_xattr
> > >  
> > >  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
> > >  		mnt -t acl
> > > -- 
> > > 2.27.0
> > > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

