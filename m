Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6AFC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431636108F
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhKAOcE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhKAOcE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635776970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqs0DL2Z682zusk9zfvT4lgf85Qm3zFZIpCfO4uP3pc=;
        b=HpzDWZPOxTxdON60N92SakkujPWc/vxYFvWiZuFT8N+hx3wa6bi5tHFVz5fxx0FDetdj2N
        9Uw6blgaLwJ1ez07BxZPTGDOuqYGQJF+TDg0abEi7BLr7wScCuxj20xc1BEmJVmzLztxDU
        2ZQwYyXQLpse1HSi8KZdGykv9FaB+7k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-YuVmFkBKO0yebCCtjmrwew-1; Mon, 01 Nov 2021 10:29:29 -0400
X-MC-Unique: YuVmFkBKO0yebCCtjmrwew-1
Received: by mail-pj1-f70.google.com with SMTP id r13-20020a17090a1bcd00b001a1b1747cd2so9363313pjr.9
        for <fstests@vger.kernel.org>; Mon, 01 Nov 2021 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jqs0DL2Z682zusk9zfvT4lgf85Qm3zFZIpCfO4uP3pc=;
        b=x2RGmnpT6RdaRyO+hrjU+GRQj+vE8Ugr+JZ9QDta95KzG3EsGNKVhHVE3ZYPS4OS82
         jEFmX/PLNoKoHVaKyWpAPH2klwgvx64sdksiwOeZP7KjVlTnYRAPeIZIvZ/dzcGv7Xqn
         Xv2QucAbWi4RqICzilEHhAYowzwV6MtP02lt6r5GKHD5Sdp9H62JhfbevSnVUjMNVAHb
         I7sFh9FiWHVglhaMf6hSZwSpTIqpu3aL5yYGfJTl0+ffLp8s7sjTbNR8Qe6DMxitefm0
         oxFPuEtB9rpaXOWlGJldTQh30r91PxcIvpgVcs48HoPhM1nZp4oYuMn89RVKUKnSAl1n
         qwww==
X-Gm-Message-State: AOAM533p/32OcrRLPTUmZErnIewnWO0Godz66YlqNqe2FW0whMwKs8Yi
        4x3njylUu1NdpN81GHPQ2o1dasZg3TffmzeOytHPq2fr34ySyGhL+1i7c1J50QqkCsSwbyMIAKR
        F3RfCqvQPymPwA8QSdA==
X-Received: by 2002:a63:495c:: with SMTP id y28mr11970861pgk.375.1635776967939;
        Mon, 01 Nov 2021 07:29:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX5tWcTMK/cdSUHDe/XYrUkmHHpdQ4pZEKNapoO2crdnZDL2ex8zRmpnIwCwTgacJbVMcnEQ==
X-Received: by 2002:a63:495c:: with SMTP id y28mr11970840pgk.375.1635776967638;
        Mon, 01 Nov 2021 07:29:27 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7sm17062319pfu.139.2021.11.01.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:29:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 22:42:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: Fix check for SCRATCH_DEV_POOL presence in
 _scratch_dev_pool_get
Message-ID: <20211101144227.ytiy54jz7mhfksa2@fedora>
Mail-Followup-To: Nikolay Borisov <nborisov@suse.com>,
        fstests@vger.kernel.org
References: <20211101133511.383232-1-nborisov@suse.com>
 <20211101135658.385131-1-nborisov@suse.com>
 <20211101142656.cgsxbanon2nvozqa@fedora>
 <49c85719-88ca-b621-eab9-983237cc3cc8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c85719-88ca-b621-eab9-983237cc3cc8@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 01, 2021 at 04:15:15PM +0200, Nikolay Borisov wrote:
> 
> 
> On 1.11.21 г. 16:26, Zorro Lang wrote:
> > On Mon, Nov 01, 2021 at 03:56:58PM +0200, Nikolay Borisov wrote:
> >> Current check is buggy because it can never trigger as even if
> >> SCRATCH_DEV_POOL is not defined config_ndevs will get a value of 0 from
> >> 'wc -w', this in turn makes 'typeset -p config_ndevs' always return 0,
> >> triggering the existing check a noop.
> >>
> >> Fix this by explicitly checking for the presence of SCHRATC_DEV_POOL
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> >>
> >> Eryu,
> >>
> >> Please use this patch as it's a more proper fix
> >>
> >>  common/rc | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 7f693d3922e8..07b69880eea6 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -917,15 +917,15 @@ _scratch_dev_pool_get()
> >>  		_fail "Usage: _scratch_dev_pool_get ndevs"
> >>  	fi
> >>
> >> -	local test_ndevs=$1
> >> -	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
> >> -	local -a devs="( $SCRATCH_DEV_POOL )"
> >> -
> >> -	typeset -p config_ndevs >/dev/null 2>&1
> >> +	typeset -p SCRATCH_DEV_POOL >/dev/null 2>&1
> >>  	if [ $? -ne 0 ]; then
> >>  		_fail "Bug: cant find SCRATCH_DEV_POOL ndevs"
> >>  	fi
> >>
> >> +	local test_ndevs=$1
> >> +	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
> >> +	local -a devs="( $SCRATCH_DEV_POOL )"
> > 
> > Yes, the logic of:
> >      "local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
> >       typeset -p config_ndevs >/dev/null 2>&1"
> > looks weird.
> 
> I can only speculate the idea was that `echo $SCRATCH_DEV_POOL| wc -w`
> would fail to declare config_ndevs hence typeset -p config_ndevs would
> return != 0, however that's not what is happening.

Yes, "typeset -p $var" can help to check if a variable is declared, the original
logic "typeset -p config_ndevs" always return 0. I think they might want to
check if [ $config_ndevs -eq 0 ], or check "typeset -p SCRATCH_DEV_POOL" as you
did above.

Thanks,
Zorro

> 
> > 
> > Checking SCRATCH_DEV_POOL makes sense to me.
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > 
> >> +
> >>  	if [ $config_ndevs -lt $test_ndevs ]; then
> >>  		_notrun "Need at least test requested number of ndevs $test_ndevs"
> >>  	fi
> >> --
> >> 2.17.1
> >>
> > 
> 

