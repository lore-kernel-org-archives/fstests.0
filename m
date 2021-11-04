Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA0C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Nov 2021 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5544B60EDF
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Nov 2021 13:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKDNEY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229960AbhKDNEY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 09:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636030905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bveaehtbvXqxSHeJt00j8MY4BlZf11ObC+Tgdle8nME=;
        b=cvE9lQo3nAMy9TKOcri1xDiz/xk4QcX6ivE/4JkQfTRV+DiXOW8JtqTviZM0w+8InSZ1Ai
        Wxg1g8CkU0mWUG6CCvTJzxBfUXdfIgf/ko/2hztXYsWtvxVBUycsV4IiHk00Elh437KXuC
        /3HnN7e+kKNun5wqEOFb6Pl8QUi2vi8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-idY8UoAePdOfvKhGo_53lg-1; Thu, 04 Nov 2021 09:01:44 -0400
X-MC-Unique: idY8UoAePdOfvKhGo_53lg-1
Received: by mail-wm1-f71.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so4383360wmd.3
        for <fstests@vger.kernel.org>; Thu, 04 Nov 2021 06:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bveaehtbvXqxSHeJt00j8MY4BlZf11ObC+Tgdle8nME=;
        b=eZ0WldBUZwLFa62Z2xTh8ZRMfoBw2zv2eT5yUANr/8lOY1MxH1as3gWXSVgbEY8yEK
         ud8zYx1uf/xgGrptWA3pVxzkimgoo/UPPZjXQx0h14x3Mu+djPOIc+fmhVOlVGYdS6Lw
         ILO44y5e7rAkHVuhA92qBg0ovRLReWq604xUd1SZYBKEKQh11XTzsIlSs3c1AwaCNgnX
         2Z+yY/woQjT1Xynk96z/FJ0ixWc923X086VK8RvGJDBCoAT7Bt7IKcYlmHgANfv0RtqC
         QORTqtGhq6oxX79Xl5CbUhnElXp+2UzisJEqj/X9uJVdY7jQGedSae+SR8jIRDOMZLzb
         0seA==
X-Gm-Message-State: AOAM531cXAXNZKzpCaJ3akSWxSJVd2OlVbpXuMr7XbPttmptqziXZFsY
        CiJPSmNWG3Zeli6d0uE8O5/D8Afsmxp2eP47613pUVrFKo0DO+LqGS5JGXjthmOKzBd6UBEH6AY
        YbzDMqjycE5OlB1/ikw==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr23167560wmb.89.1636030903026;
        Thu, 04 Nov 2021 06:01:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNIvGNFCn/vpCY4EVN4M3gnTnJRMArlkadq4syu7DPws6wdWRIXpqgwy/ZbzujdkZ5wgDgXw==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr23167531wmb.89.1636030902750;
        Thu, 04 Nov 2021 06:01:42 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id p2sm6472039wmq.23.2021.11.04.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:01:41 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:01:40 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: Enable _format_swapfile to return the
 swap size
Message-ID: <20211104130140.mkeqrlhcqlwbbewq@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        fstests@vger.kernel.org
References: <20211102152828.26895-1-cmaiolino@redhat.com>
 <20211102152828.26895-2-cmaiolino@redhat.com>
 <20211104125226.7kozp45e2ifvmiyw@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104125226.7kozp45e2ifvmiyw@work>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > +	# return created swap size
> > +	echo $swap_log | grep -oP '(?<=size = )\w+'
> 
> I think you need take into account the fact that the units of the mkswap
> output will change depedning on the actual size. It might be better to
> grab the size in bytes which is in the output as well.

Sounds fair. I'll wait a bit more to see if some more people comment it, and
I'll update it.

> 
> -Lukas
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

