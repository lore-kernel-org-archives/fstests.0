Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C3C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B0F6103B
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Sep 2021 10:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhIZKCO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Sep 2021 06:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhIZKCN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Sep 2021 06:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632650437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3H7C+QmiCT7k/3yRZhuGhqv67u9ThhnRLSBU09IwjNc=;
        b=d7VGwDo14BGOd0wC6/LOyNNDE18zKe+MbBTqp9IBTL5Fxsormbr3yQUSNhUBBeG6XJBKIu
        nxsve+GVV2dsQft7AMKYhSYXP08rccmLIIZ/4e6/vvygwe+4BTL3gbMUWzOs+8Nq6IGSWa
        NPxVRAHtEVjYJRZtInR7ESHTyCM11e0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-OK6O6VrcPDe3TvdcV2wYcA-1; Sun, 26 Sep 2021 06:00:36 -0400
X-MC-Unique: OK6O6VrcPDe3TvdcV2wYcA-1
Received: by mail-pj1-f72.google.com with SMTP id bk24-20020a17090b081800b0019e5aca5815so9309025pjb.8
        for <fstests@vger.kernel.org>; Sun, 26 Sep 2021 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=3H7C+QmiCT7k/3yRZhuGhqv67u9ThhnRLSBU09IwjNc=;
        b=zP5G+e3yTy/CzVRaowxt2iYuimMQ0RmwH55hv5a0zFb4wQaYzmDuW60Nw9/JWb9mkA
         PjIV1Eokiqwt/TXdaQhzN0afIZ2zSZGuso5AD/b/nnQpYHg7J7Jl4mliWnD7aPzRbsn+
         F1Lpwb/DLz4e+BSxWF8mjYRXKZEjOmetveUNxvm+kgmH2uNpGA4o3oW0/3hnE8sUTL+x
         D9PA5lMCX1enwaC2/sNGyW2BkVhGjQBMxl/1ZqTRVCLJpHA8WNrh0EQ0387WS4HL5KtP
         wzctH+1g4wq8sOJot+htlRZtnd6/JQQgIvt3CY1xSrfA3JMFkm9i+DDlphFiofksjyt3
         CYeQ==
X-Gm-Message-State: AOAM5327pVi5YsxBBfPQINBo6zZOf3Pyyr36FRRvkNGewswSJCeuitXN
        J/GNEofh0/MtK7RNj9NwmOR3Ff4G1aSevRzlx8i8iD4tCu9Ftai9Tsj9mnu4jC1xQyDXwigcl9B
        7ZBQOJfIC+SmgOSMBZA==
X-Received: by 2002:a63:f410:: with SMTP id g16mr11576049pgi.201.1632650434895;
        Sun, 26 Sep 2021 03:00:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiUXUz7wsQUxTd3QSvNUyrwFsN/K/wR9ZQ1ASLNXHL24/R6RdFZvlmGQ7fjzIBHXimLAF6oQ==
X-Received: by 2002:a63:f410:: with SMTP id g16mr11576023pgi.201.1632650434513;
        Sun, 26 Sep 2021 03:00:34 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u12sm13644116pjr.2.2021.09.26.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 03:00:34 -0700 (PDT)
Date:   Sun, 26 Sep 2021 18:22:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>, fstests@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 1/2] common/rc: add _require_user_exists() to check if
 a user exists
Message-ID: <20210926102217.332hdmrhwlvgkrxj@fedora>
Mail-Followup-To: Luis Henriques <lhenriques@suse.de>,
        fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210924091911.19413-1-lhenriques@suse.de>
 <20210924091911.19413-2-lhenriques@suse.de>
 <20210926101354.gniy2ytswm662y5y@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926101354.gniy2ytswm662y5y@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Sep 26, 2021 at 06:13:54PM +0800, Zorro Lang wrote:
> On Fri, Sep 24, 2021 at 10:19:10AM +0100, Luis Henriques wrote:
> > Function _require_user() does check if a user exists *and* if it is able
> > to execute commands.  Add a new function to simply check if a user exists.
> > 
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> >  common/rc | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 154bc2dd7e94..de9ba56eefcf 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2289,18 +2289,27 @@ _cat_group()
> >  	cat /etc/group
> >  }
> >  
> > -# check for a user on the machine, fsgqa as default
> > +# check if a user exists in the system
> > +#
> > +_require_user_exists()
> > +{
> > +	local user=$1
> > +	_cat_passwd | grep -q $user
> > +	[ "$?" == "0" ] || _notrun "$user user not defined."
> 
> As _require_user() does "su $qa_user" after the "grep", so it really make sure
> there's an "user". But if the _require_user_exists() only trys to grep /etc/passed
> to make sure there's an "$user", I'd like to make the "grep" condition be more exact.
> For example, if there's an user "myuser100" in the /etc/passwd, then _require_user_exists
> "myuser" or "user100" or "user1" or "user10" all return 0.
> 
> So how about:
>   _cat_passwd | grep -qw $user
> 
> Or more exact:
>   _cat_passwd | cut -d: -f1 | grep -qw $user
> 
> Or other better command line:)

Oh, the "-w" doesn't work with an user with "_", likes myuser_123. So
how about:

  _cat_passwd | grep -q ^$user:

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > +}
> > +
> > +# check if a user exists and is able to execute commands.
> > +# Uses 'fsgqa' user as default.
> >  #
> >  _require_user()
> >  {
> > -    qa_user=fsgqa
> > -    if [ -n "$1" ];then
> > -        qa_user=$1
> > -    fi
> > -    _cat_passwd | grep -q $qa_user
> > -    [ "$?" == "0" ] || _notrun "$qa_user user not defined."
> > -    echo /bin/true | su $qa_user
> > -    [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
> > +	qa_user=fsgqa
> > +	if [ -n "$1" ];then
> > +		qa_user=$1
> > +	fi
> > +	_require_user_exists $qa_user
> > +	echo /bin/true | su $qa_user
> > +	[ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
> >  }
> >  
> >  # check for a chown support
> > 

