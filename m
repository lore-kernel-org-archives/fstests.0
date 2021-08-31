Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A0C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 05:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461706103D
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 05:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhHaFHd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhHaFHc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 01:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630386397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeQB/ktJH1nLq9UHfD0tqQhl7nudnllhqtvERNCIuHU=;
        b=XaEbZPPuCGQ5aLyw6fNEeS7YIOJLYjsh7o8mCsKlOT5S/fr/eyMu8h3lC70tmpkwS3Cvu7
        k2+70jTEFrhB7rPIJeUaJsuWbJS3KP4M5gMbsmCJ74Ub3skV/uEggLgTs6rk/fyq9yeWnP
        o/IFP7B+puRqPWfc125rDMYoqhbnGVI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-eHRil5iVMISR4iAvHxu9Vw-1; Tue, 31 Aug 2021 01:06:35 -0400
X-MC-Unique: eHRil5iVMISR4iAvHxu9Vw-1
Received: by mail-pg1-f200.google.com with SMTP id 32-20020a6315600000b029023caa2bfec4so881779pgv.20
        for <fstests@vger.kernel.org>; Mon, 30 Aug 2021 22:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MeQB/ktJH1nLq9UHfD0tqQhl7nudnllhqtvERNCIuHU=;
        b=SviajioDcqdqb5+VA9Mai0G5NIVUpx5T7x77ObM9vDjHAQ1F/3V/xWO6yquzgv27jR
         JvxopZ+Nbw7qec5M65Rd1d1sgwtkjxxABZssYXexSml9P/WpkPUwmGc5Dba2yTUBqVvJ
         MAzfd1Wm99S7s32bozBOzVL4e33pjBuaBW13IWmBUPE+O49G4vDnPzEk7VlzdZpZjXD9
         /ZD/ba4nzHLdU9Z0iTA48rT16UqU1mT9B4AyzrIGGTgsyTVrTi+pB0FERe+pLbCQHxEW
         tLOUcImI5wrHHWToRAah+PKM6JWO33xyZRDXjThPG8qQMMgIRRzPMxrDRgQZTa4IeUIA
         8Kvg==
X-Gm-Message-State: AOAM530BjqZ4ZF4yvtR8511zdPheU5rs+uMS13rXj/qwDVcTSodPEppH
        VoDI/lW0o1j5Ee2JNXOETK++MSs69hk545Ndtk6NNdD/K6x9DUaPvhJTqm5KxcN+FhaSN4Odz4F
        TDCnEv5zdGyosgAS2Mw==
X-Received: by 2002:a05:6a00:189f:b0:3e1:b92d:5ef6 with SMTP id x31-20020a056a00189f00b003e1b92d5ef6mr26754868pfh.81.1630386334434;
        Mon, 30 Aug 2021 22:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysPdyN7mo98uQQF3QJoLI5kLpEALt0ihU9u8vYHqDrRHQmrFaLbyjJaX6GEmn6hR48fW91EA==
X-Received: by 2002:a05:6a00:189f:b0:3e1:b92d:5ef6 with SMTP id x31-20020a056a00189f00b003e1b92d5ef6mr26754840pfh.81.1630386334043;
        Mon, 30 Aug 2021 22:05:34 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 15sm15902801pfl.186.2021.08.30.22.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 22:05:33 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:26:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210831052632.p4kaygjeujipo4w5@fedora>
Mail-Followup-To: Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 31, 2021 at 11:04:26AM +0800, Murphy Zhou wrote:
> After commit
>   0e4dd8b9 common/rc: fix ignoring of errors on
> we are getting this error message when running swapfiles tests:
>   +./common/rc: line 2553: MKSWAP_PROG: command not found
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 46b6b220..0597de13 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2550,7 +2550,7 @@ _format_swapfile() {
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>  	# Ignore permission complaints on filesystems that don't support perms
> -	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> +	($MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full

The change history is:

Commit 0c95c8ac tried to "hide permision warning", so did:
-       $MKSWAP_PROG "$fname" >> $seqres.full
+       # Ignore permission complaints on filesystems that don't support perms
+       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full

Then commit 0e4dd8b9 said "it broke older versions of bash such as 4.4.23", so tried
to use "a $(foo) to run the executable":
-       $MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
+       $(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full

Now this patch try to do ($FOO_PROG):
($MKSWAP_PROG "$fname" .....)

I'm *not* a bash expert, if I'm wrong feel free to correct me:) If the original problem
is trying to hide permision warning from stderr, and to avoid new syntax breaking old
bash, Why we must struggle with this complex syntax which isn't compatible. How about:

$MKSWAP_PROG "$fname" >> $seqres.full 2>&1 | grep -v "insecure permission"

Or other better and compatible way ?

Thanks,
Zorro

>  }
>  
>  _swapon_file() {
> -- 
> 2.20.1
> 

