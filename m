Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B1C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2AD6117A
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbhKIJF5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244639AbhKIJD2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Nov 2021 04:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636448405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CY3jqv3YSGKbc5j2xYW6TKYKd+inGMU3VBhAsImFb3I=;
        b=NqiH1iFm2GeMI4De+5yJGfJJVoFwNwYZlZ+C080Jzc9/BgUOkNdeJzPmEcezbATpesnlZo
        v/JSJh1nqFmMwC6nSEEAUq2hG2ouIZFq15rTcfBqCqiNeRWexMVklmJGRw1kSQiTDZDNma
        fjppSWzkGmQsE8wr3bgNK8jEasBrFU4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-xWzKCCx6OyikpF6BN2GRfw-1; Tue, 09 Nov 2021 04:00:03 -0500
X-MC-Unique: xWzKCCx6OyikpF6BN2GRfw-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b003e2bf805a02so16839551edd.23
        for <fstests@vger.kernel.org>; Tue, 09 Nov 2021 01:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=CY3jqv3YSGKbc5j2xYW6TKYKd+inGMU3VBhAsImFb3I=;
        b=rtfxmIDphgim4uRuBjS+hdOiqGoqXwdUL6zaT/XTU7lphq/a9cJtVkjhqb1Nwn28FK
         kFZkB34s1aVdytdENOZjI274CcAxpo7WYBTGkvU1eJnOOM9UGPupi5qFH/xpAQK7TBOB
         Aa5PeUG0FpddAQZ1CChavyIZxUcPL8lNXF0Y+/dZjHOYWQpCRPnQWByiqA37QSlXCDlO
         LIROj0pS8i3hSx6rzg+bEHzXOtzdJ0nd38+z44xQEcR3rcX/Q+7Z9mO10smKHj2M7r//
         nH91WrCm6yldEJ/q1MXUYVvJqq6C2zOS6lYajHJCuzzR8iZFXTv+7Ky17tiQr91gzuJM
         xbMA==
X-Gm-Message-State: AOAM533XEGdJlBm5U+XVTWN6P4ztf4brViXewqSnqDClBTyzSfjNrHkP
        5LnTdP8yLdKBTVYAG2BuEKYmA8hDGy+/CPC/u6xOYg6r5pGrSSf5Rue4CfZKMSUO4zDFee+vMfn
        QT9r2T6sFB5MWew4QakRy37CADskyWb6fl+ZFUXvsRcybhaROILWc0MTPiO3/TijHS7FWfz0=
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr7887782ede.267.1636448401995;
        Tue, 09 Nov 2021 01:00:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9AA7gqAz0ci0QnHJxM8XEf/6KRhiAt74npyGu1mI6p3lcwMd9oy3ZPoJW+yo0/TptBe5lyg==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr7887732ede.267.1636448401702;
        Tue, 09 Nov 2021 01:00:01 -0800 (PST)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id hr11sm3660274ejc.108.2021.11.09.01.00.00
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:00:01 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:59:59 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: Enable _format_swapfile to return the
 swap size
Message-ID: <20211109085959.w5e5w3a6fhcs7ikl@andromeda.lan>
Mail-Followup-To: fstests@vger.kernel.org
References: <20211102152828.26895-1-cmaiolino@redhat.com>
 <20211102152828.26895-2-cmaiolino@redhat.com>
 <20211108042618.2lezcpdhwfs6tlav@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108042618.2lezcpdhwfs6tlav@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > +	# return created swap size
> > +	echo $swap_log | grep -oP '(?<=size = )\w+'
> 

Hi Zorro.

> I saw you've changed generic/643 to suit this change, but there're many cases
> call _format_swapfile() [1], now it print something to stdout by default, did
> you make sure it won't break other cases' golden image?

Yes, I did change generic/643 to use the value returned by _format_swapfile(). I
did test a few other tests which use _format_swapfile(), just in case, and they
passed normally for me, that's why I added the following comment to my patch's
description:

--
Tests using _format_swapfile() that do not require the swap file size do not
need to be modified, as the return value will be simply ignored.
--

Did you find something failing that wasn't supposed to? If not, I'll try to
rephrase that above on my V2, to be a bit more clear.

Thanks for the review!
Cheers.

> 
> Thanks,
> Zorro
> 
> [1]
> $ grep -rsn _format_swapfile tests/
> tests/btrfs/173:22:# We can't use _format_swapfile because we don't want chattr +C, and we can't
> tests/btrfs/173:34:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> tests/btrfs/177:66:_format_swapfile "$swapfile" $((32 * 1024 * 1024))
> tests/btrfs/174:23:_format_swapfile "$swapfile" $(($(get_page_size) * 10))
> tests/btrfs/175:21:     _format_swapfile "$SCRATCH_MNT/swap" "$sz"
> tests/btrfs/175:50:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> tests/btrfs/176:32:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> tests/btrfs/176:50:_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> tests/generic/643:39:_format_swapfile $swapfile 1m >> $seqres.full
> tests/generic/357:42:_format_swapfile "$testdir/file1" $((blocks * blksz))
> tests/generic/493:30:_format_swapfile "$testdir/file1" $((blocks * blksz))
> tests/generic/494:29:_format_swapfile "$testdir/file1" $((blocks * blksz))
> tests/generic/356:42:_format_swapfile "$testdir/file1" $((blocks * blksz))
> tests/generic/569:34:_format_swapfile $testfile 20m
> tests/generic/495:24:# We can't use _format_swapfile because we're using our custom mkswap and
> tests/generic/554:33:_format_swapfile $SCRATCH_MNT/swapfile 16m
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
> > 
> 

-- 
Carlos

