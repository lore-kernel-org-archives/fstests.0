Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F7C433FE
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A52610A6
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhKIJF6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244655AbhKIJF1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Nov 2021 04:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636448561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXAfnQ+jxoRCpWvcoQxSpPURAr1vjqDoPuhI9FAkef0=;
        b=alJUijGYtsua9NuhMYta1pnD75ZTm0RuuPAOrXnj05dmvN1O9gk2XdxrB2MY1+lf+KxbCm
        9UqYQmpQq/hQT0P4+zfkeCgK2bhxv1nI3oaIQeMHF8eujJkziaK5LDjWRm+lkOgGnP4XVR
        NE6JT6mMg2QcTqrK3EEHyJ2lk3paUkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-kZkG8JYdMQuU30DoqPwyLA-1; Tue, 09 Nov 2021 04:02:40 -0500
X-MC-Unique: kZkG8JYdMQuU30DoqPwyLA-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so17319517edf.5
        for <fstests@vger.kernel.org>; Tue, 09 Nov 2021 01:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GXAfnQ+jxoRCpWvcoQxSpPURAr1vjqDoPuhI9FAkef0=;
        b=GKz+OY74BvUNe/uktd/aCFSO5LjLy+v8m9AER2b3Bzx1mYPoqyEAvRFdUMFAkpchU4
         lAIqJw3Wrsgbcgcw9OQ1h3qySkrBiESa05MWsiY2wpA+909q7s5PB4aE+XVCZQD4iwcZ
         sJoTvp2khTh45Veg1cDUtkAdT19fPbhwV3LzajelhHf5JRn6Oc8Cmi40mOlruHgrNNZf
         UIthNgUFAeGlsoR32j8UpPzKX7K3TcAcVMa9zpexkvCwwH5EZVCdOkKfYRzGdBUSE+Ql
         IRHyi8Dg3/3j+4D9otkE3SXH92LtudXfGnkmhbS6urRcfYp3cwv0ZaZfvmTC/jilRqwc
         pfgg==
X-Gm-Message-State: AOAM530XkZi9uE8Wb/yCABC97ZhlLUBEBaaZLwyYnzuZxmHIvVRtLm6A
        fYof+AguC3cJUwzFTAd+KMzGlfYCL378HVvqsLwYQz/w3JPtozvfg+/GTYkn62H8uaJ4zLf26P/
        XPv4GIm+c6B2xOr9xQA==
X-Received: by 2002:aa7:c846:: with SMTP id g6mr8086552edt.75.1636448559107;
        Tue, 09 Nov 2021 01:02:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWlvByh9RD60/NBqPHq3/M7Gq+UlTmQ8mXh4FJ65M9kLK2BAmEQAXm/voJdhNyKVgdk4MAJg==
X-Received: by 2002:aa7:c846:: with SMTP id g6mr8086517edt.75.1636448558887;
        Tue, 09 Nov 2021 01:02:38 -0800 (PST)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id sb19sm9527175ejc.120.2021.11.09.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:02:38 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:02:36 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: Enable _format_swapfile to return the
 swap size
Message-ID: <20211109090236.q7pg6cwuvm2r4kkm@andromeda.lan>
Mail-Followup-To: Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
References: <20211102152828.26895-1-cmaiolino@redhat.com>
 <20211102152828.26895-2-cmaiolino@redhat.com>
 <YYfRRO7RHkNyobxF@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYfRRO7RHkNyobxF@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu.

> > @@ -2595,8 +2596,11 @@ _format_swapfile() {
> >  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
> >  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
> >  	# Ignore permission complaints on filesystems that don't support perms
> > -	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
> > -		grep -v "insecure permission"
> > +	swap_log=$($MKSWAP_PROG "$fname" 2>&1 | grep -v "insecure permission")
> > +	echo $swap_log >> $seqres.full
> > +
> > +	# return created swap size
> > +	echo $swap_log | grep -oP '(?<=size = )\w+'
> 
> It's now returning the size of the swap space, it'd be better to add
> some comments before the helper to describe/explain the behavior.

Thanks for the review. You mean another comment on the top of function
definition, despite the one I added inlined? I think it would just make it
redundant, but I'm not against moving my comment from above the echo call, to
the top of the function definition.

Cheers.

> 
> Thanks,
> Eryu
> 
> >  }
> >  
> >  _swapon_file() {
> > @@ -2628,7 +2632,7 @@ _require_scratch_swapfile()
> >  	_scratch_mount
> >  
> >  	# Minimum size for mkswap is 10 pages
> > -	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> > +	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
> >  
> >  	# ext* has supported all variants of swap files since their
> >  	# introduction, so swapon should not fail.
> > -- 
> > 2.31.1
> 

-- 
Carlos

