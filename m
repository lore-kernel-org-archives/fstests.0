Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D8C4320E
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA061027
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhHaNWI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235450AbhHaNWH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 09:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630416071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWgDofm2lQwAVp2JFf8mJek8vp7jVIyJQ+MPGzQGfeo=;
        b=L9YbJHILDxgF0i9he8pDY/r66lBPJdBJ5eLdJLdRJh1T9qca/FG62A+7VYC8KOXlekEjPO
        OFv6vfYjyYFW5O0h34bKYv3EsdZLUOxzlQS/HHJ5G2jivEsvXCY1zsWUmcszP1RqA66qkC
        EH2HPNCv/vwpLeDBaFb+EKE+fb2pwlc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-Kep6xJtrOu2b_LomROSsCg-1; Tue, 31 Aug 2021 09:21:09 -0400
X-MC-Unique: Kep6xJtrOu2b_LomROSsCg-1
Received: by mail-pg1-f197.google.com with SMTP id j16-20020a63fc10000000b00255d6f81e23so3874460pgi.13
        for <fstests@vger.kernel.org>; Tue, 31 Aug 2021 06:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nWgDofm2lQwAVp2JFf8mJek8vp7jVIyJQ+MPGzQGfeo=;
        b=ZXsiuBmWHVG76YzmqLuuvCqIrozMfDfq7FV4d9nrntjDM+8ZgdzfONH+2Vf4zwpueK
         ZUmpMQX+o9Tm94LqCz81g8gcyvr37pmNs6+2txmyjjMFaUzqsEIGMNOvIN9jNaEHL2Jx
         XQjzi/WI6vUcv/Bsw+Fi8IEPyqvBma6DoEy3Iba381+GdKoUK4ktbxja260viOklepks
         WPvOJkuxtwCdo3SDC3EqAlw0TwkzYSIXBpA/JALMpcaK+LdWB0MSvHFJ4nvUwDirXEb8
         eBhaDjs6A89MIvVVFPLoPmUYsPkWG7c+auwlqbmPYMvSydT08K6RvVu0jWVXsMtxsx9p
         Dj0A==
X-Gm-Message-State: AOAM533lyVgLm13tsmASeF5TjVXS3F34UFi2Jp9hFQfOxir7S/Doqo1k
        NXIZ2tCLAj96cxX9cU/OZ3PxB5pUJHbzj8BxPjrPmtrzXsF6pCa7w+CBVG17YwfrJR/YB3XMWi2
        EYx1Zvq/9+7M+HAa/Ig==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr5464319pjg.229.1630416068785;
        Tue, 31 Aug 2021 06:21:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf6BWI///LV9LaHT5YD9iOW2xMIXdJmVtjiGPdwXgWOF4FjneG5hYYYegdMCQFvAdwP0gzzA==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr5464283pjg.229.1630416068344;
        Tue, 31 Aug 2021 06:21:08 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w188sm17154151pfd.32.2021.08.31.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:21:08 -0700 (PDT)
Date:   Tue, 31 Aug 2021 21:42:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210831134207.aa4e26xuyji4npia@fedora>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 31, 2021 at 09:38:25AM +0200, Pavel Reichl wrote:
> 
> On 8/31/21 7:26 AM, Zorro Lang wrote:
> > On Tue, Aug 31, 2021 at 11:04:26AM +0800, Murphy Zhou wrote:
> > > After commit
> > >    0e4dd8b9 common/rc: fix ignoring of errors on
> > > we are getting this error message when running swapfiles tests:
> > >    +./common/rc: line 2553: MKSWAP_PROG: command not found
> > > 
> > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > ---
> > >   common/rc | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 46b6b220..0597de13 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2550,7 +2550,7 @@ _format_swapfile() {
> > >   	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
> > >   	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
> > >   	# Ignore permission complaints on filesystems that don't support perms
> > > -	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> > > +	($MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> > The change history is:
> > 
> > Commit 0c95c8ac tried to "hide permision warning", so did:
> > -       $MKSWAP_PROG "$fname" >> $seqres.full
> > +       # Ignore permission complaints on filesystems that don't support perms
> > +       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
> > 
> > Then commit 0e4dd8b9 said "it broke older versions of bash such as 4.4.23", so tried
> > to use "a $(foo) to run the executable":
> > -       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
> > +       $(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> > 
> > Now this patch try to do ($FOO_PROG):
> > ($MKSWAP_PROG "$fname" .....)
> > 
> > I'm *not* a bash expert, if I'm wrong feel free to correct me:) If the original problem
> > is trying to hide permision warning from stderr, and to avoid new syntax breaking old
> > bash, Why we must struggle with this complex syntax which isn't compatible. How about:
> 
> Hi, sorry I do suck at bash, but:
> 
> > 
> > $MKSWAP_PROG "$fname" >> $seqres.full 2>&1 | grep -v "insecure permission"
> 
> >> redirects stdout to the seqres.full and the 2>&1 redirects stderr to
> wherever stdout goes...so $MKSWAP_PROG "$fname" >> $seqres.full 2>&1 sends
> both stdout and stderr to the file so nothing is piped to grep. Or do I miss
> something (which is entirely possible)?

Sorry, I reversed the order. I mean:

$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | grep -v "insecure permission"

Thanks,
Zorro

> 
> 
> Thanks!
> 
> 
> > 
> > Or other better and compatible way ?
> > 
> > Thanks,
> > Zorro
> > 
> > >   }
> > >   _swapon_file() {
> > > -- 
> > > 2.20.1
> > > 
> 

