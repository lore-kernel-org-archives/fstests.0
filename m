Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F486C05027
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Feb 2023 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBFOxD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBFOxC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2023 09:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761B26CF2
        for <fstests@vger.kernel.org>; Mon,  6 Feb 2023 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675695134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Idd8vB1N+8oCfhaVnUuXCmBzF8bZh1Zofodkf/rLJqs=;
        b=O1ocp837KG3gTa1iUejiN1sRveUNzC8J6U6K926baMILLvSpcmGFlY2qmEfFQJo72euSoQ
        08jyhuP+i4ZGWb7T+hKTtpXctSd968QUE/BWBDOgikyd1SX/4HaR/IP6DIRAdFBpqwpC6y
        piwiY9Ez8oIcKoQcb8/in3wjg61rHYs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-Znti2WOsO7i0WGuFLR_wVA-1; Mon, 06 Feb 2023 09:52:13 -0500
X-MC-Unique: Znti2WOsO7i0WGuFLR_wVA-1
Received: by mail-pg1-f200.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso5195987pgs.7
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2023 06:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idd8vB1N+8oCfhaVnUuXCmBzF8bZh1Zofodkf/rLJqs=;
        b=NwzKxg2mI3IxD09J3LN8HFFa6oOjy93oJ4/ZoXNGGPWKNZHx+sunI30qDPCpBR+syn
         MpkwhTLvxw4QxI4NN6m0W0QsIE0xUdxtu4+zbO4oEorhjhcbKHg9VtmsK6fiJbHwt5QU
         4+A86Wz2DHvsw2SFe6G1FQeAfRBcR4VzzsKYfUtMAOUjKJzmvA6459VrmRCa72LfqKTU
         3lusXVtGbjfW1vaMDndah+bAXBQ4na4lZAg8DlFAqAYjEVe95q5gAbwC6QUuoRn/oLuh
         wdRmd21PD6B/UMYYajDd7irpdvpn5RPkfNd3toDBEI3gy3SC1m1mgX+2x/SVdk2IS5A/
         weqQ==
X-Gm-Message-State: AO0yUKXagoQsDut/nZ9/YW1+c0i7dlujAwpxaO+Kn3eazjkhQeTuEoiK
        3iToCVRNCZ82ffG7gb4VBq2ExqqrFCNJ4rp/iYjL7JRRxy1hBC2qxb2dcfCkVSA5RCnSP+kXlli
        2fTLvgDflvyMbT/OnMg==
X-Received: by 2002:a62:1dcf:0:b0:592:3c0a:39dd with SMTP id d198-20020a621dcf000000b005923c0a39ddmr18444645pfd.28.1675695131702;
        Mon, 06 Feb 2023 06:52:11 -0800 (PST)
X-Google-Smtp-Source: AK7set88+dDZ11lp6OZr3toHBepzzGXz0smp1gxnjizXg2k7pzA5+4F/lJ5ZYwtN5fzU9s1iqAuL4g==
X-Received: by 2002:a62:1dcf:0:b0:592:3c0a:39dd with SMTP id d198-20020a621dcf000000b005923c0a39ddmr18444632pfd.28.1675695131365;
        Mon, 06 Feb 2023 06:52:11 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a77-20020a621a50000000b0058e12658485sm7398647pfa.94.2023.02.06.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:52:10 -0800 (PST)
Date:   Mon, 6 Feb 2023 22:52:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] README: Add tiny note concerning required scratch
 devs for btrfs testing
Message-ID: <20230206145207.kik5cczepdlgmexa@zlang-mailbox>
References: <20230131123839.16084-1-gniebler@suse.com>
 <20230131123839.16084-3-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131123839.16084-3-gniebler@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 01:38:39PM +0100, Gabriel Niebler wrote:
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 008d3875..574cdd34 100644
> --- a/README
> +++ b/README
> @@ -127,7 +127,7 @@ Setup Environment
>      - device contents will be destroyed.
>  
>  4. (optional) Create SCRATCH device pool.
> -    - needed for BTRFS testing
> +    - needed for BTRFS testing (some tests require up to 5 disks of 10GB each)

Not sure about this part, so btrfs recommend 5 disks of 10GB each in
SCRATCH_DEV_POOL, to run all btrfs related tests? Does anyone know that?
Or can you provide the subcase names which need "5 disks of 10GB each",
to help to check and review?

P.S. I'm thinking about if this "(...)" should be moved to below item.
                                                        vvvvv
>      - specifies 3 or more independent SCRATCH devices via the SCRATCH_DEV_POOL
>        variable e.g SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc"
>      - device contents will be destroyed.
> -- 
> 2.39.1
> 

