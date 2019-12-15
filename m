Return-Path: <SRS0=+iS3=2F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C2C43603
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E64E20726
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Dec 2019 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzjR/0Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfLOQkP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:40:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40984 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfLOQkP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Dec 2019 11:40:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so4276395pfd.8
        for <fstests@vger.kernel.org>; Sun, 15 Dec 2019 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k89WHPB8irPDylE2KWgzq1pCdJfn0LKmeNkPP5bxzkQ=;
        b=tzjR/0Pl5urfvKeRBv3deSvsGVRRZrNETD0imbmOJ7ljkXb7J+cLmolKjJsebYUkfp
         TJuRJDYhAOflEo7HFxiBr8Vq4i9AJ2z8lXW/oAbOkVPI+xkM5BCZMnbK4IV3qBFpRp2u
         BmVUQIJ1rmql9Th943HeAvFJzfRCM8Y5ZY33v9y4gqbvGOaCVGPyEiagII5Z0k85sucg
         DeXcjGJ6RXp9exx2Wkhyi98sxEcUDgkd3s97QxLUxoU7BClQhDnrD6xCRc8f5UT/TyOa
         dpJb6HrKvztR+LuDx7kxiDZucuMlZIO0lIDZg3CerdQdy2+7tQZx0tKCOBIpelLX5ttd
         tF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k89WHPB8irPDylE2KWgzq1pCdJfn0LKmeNkPP5bxzkQ=;
        b=UX2Fj1xldo3kyH1bbX2RUaXr5Z62LQvc/Vz5Jne7SwGn6ZFofTd3FIjuNECj3UKeXi
         G3Bgu1eNmtEB+xeZy5PqA9XTMwS4iv0oLK1A0ohaT6dMMMXhVj030VgFkbsi8keoE1Sl
         LqaPYbY6MKmsJNCOHEi+24HDLpSVFgiOuRBZFELBLTMg0mMk/8t//SverPPKoFRiFZei
         mcW17wfGU6KCREqk/gTqrqZ/E+Iv7aRtHsJddFkrj0GsY2CzpZQsOu+HOXBAWk9YLomr
         U+SjEy3hrk8Pz6Rp12X/cgotqlJ1/SJARwnnt37NVeTYm8qo7Oy7SpBBVn1nZzR3Nniv
         a5kg==
X-Gm-Message-State: APjAAAUrDwOGzGA03Jm2tnsE1Ux4D1lcvy70wWxL5Yhr9D5gN61JKyaI
        TJ/ZydpQ7UpVkqoD5qt06zQ=
X-Google-Smtp-Source: APXvYqw2Sf0LXZdBIyZDK2r6OY8XpLEwNC/NvgCIVfW444WZ8upwF+BRHjcJJBIu+q+aT6prDfnyXA==
X-Received: by 2002:a63:f901:: with SMTP id h1mr12966608pgi.445.1576428014466;
        Sun, 15 Dec 2019 08:40:14 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y76sm19733336pfc.87.2019.12.15.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:40:13 -0800 (PST)
Date:   Mon, 16 Dec 2019 00:40:09 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] common/rc: fix device size parser
Message-ID: <20191215164007.GC1776323@desktop>
References: <20191211201830.18911-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211201830.18911-1-dennis@kernel.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 11, 2019 at 12:18:30PM -0800, Dennis Zhou wrote:
> If you have multiple devices that share the same regex (eg dm-1, dm10),
> then _get_device_size() can return "$size\n$size" which causes the
> following error for btrfs/011.
> 
>     QA output created by 011
>     ./common/rc: line 3084: [: too many arguments
> 
> So, fix this by making grep check against eol.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 5cdd829b..b819ede1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3583,7 +3583,7 @@ _get_available_space()
>  # return device size in kb
>  _get_device_size()
>  {
> -	grep `_short_dev $1` /proc/partitions | awk '{print $3}'
> +	grep "$(_short_dev $1)\$" /proc/partitions | awk '{print $3}'

I changed it to use "grep -w", which seems simpler.

Thanks,
Eryu

>  }
>  
>  # Make sure we actually have dmesg checking set up.
> -- 
> 2.17.1
> 
