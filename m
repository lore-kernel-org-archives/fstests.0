Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FEBC4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Dec 2022 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiLQJya (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 17 Dec 2022 04:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLQJy3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 17 Dec 2022 04:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5D1704C
        for <fstests@vger.kernel.org>; Sat, 17 Dec 2022 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671270820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e/WomciymL2X4E+5f5U9jo4ZPTfwKDj7RmiS9eCUHQ=;
        b=JI9aq+dBhFm166I5EOrsEpFjDHVcqNIXw7LtuBbkD1hBg6cThBjsFzC8wHKaT7dDezdESD
        qfaP2vpdtFo/WLdtJXTfVLgowoGxW20OdZmXGyzgZJziHU8KwVLEZY3S5crJV9jj1LfOf2
        acdFOzNYqdAhuEKhWkxP03FL/wfbB5w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-IcU8oVjhO0ylOfZY_0Z9MQ-1; Sat, 17 Dec 2022 04:53:38 -0500
X-MC-Unique: IcU8oVjhO0ylOfZY_0Z9MQ-1
Received: by mail-pj1-f72.google.com with SMTP id o18-20020a17090aac1200b00219ca917708so5485970pjq.8
        for <fstests@vger.kernel.org>; Sat, 17 Dec 2022 01:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e/WomciymL2X4E+5f5U9jo4ZPTfwKDj7RmiS9eCUHQ=;
        b=UWjLZQGwyz5S7V/yAa5Bdawc6WzEEr5e8eberhbpFUx0twEsWvNEo0wvIiuGd2EYfo
         HD0rIJ2RaYhyNeiTFOGz3Tn3iGGKPUHC8mk1AQNiUry5V7uGn0/Ngk0aD8u9r7pIdYCp
         h2ejxIlnDvRuRiINkArUe+g1JBsVA4ZEUiTGbSPt9iTRgfXnVmyAWzIrEGn3jCEqJb9a
         e1GGT3Ms/wzbySXOBX5FGUwxPSE8tOnoTeSYqja4sX4mtoOZb+26MqybZ4t3oLxTl65l
         sr7B4Eo8UR6WCXxHJDWYWuwb/wnvJYXqs+KM9WUKBH1VcJmPjPrdfZM6WUEyk9HgFykY
         HYZw==
X-Gm-Message-State: AFqh2kr48AFLbC0Br0EOhLNyLrWWTNzgPKDvm+IsZoOyjDu7g+qe+ZdS
        +27CEg43M/XkZbzCRWcQN59Oqi8mhPEI3LaLnrEFt63DalR2baiFWF4MYH+YiSvKK2uEJ9J7ye5
        /RxYSwq0Ba81Hgn04NQ==
X-Received: by 2002:a17:90b:1895:b0:223:9e00:85bd with SMTP id mn21-20020a17090b189500b002239e0085bdmr4341140pjb.40.1671270817446;
        Sat, 17 Dec 2022 01:53:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu26CO41gsu4V55MhpQrkkT1+//M7TIHOSYIvQsd7qVHl8Mt4BXohvzbRUbYrurIF4vH4FrWg==
X-Received: by 2002:a17:90b:1895:b0:223:9e00:85bd with SMTP id mn21-20020a17090b189500b002239e0085bdmr4341128pjb.40.1671270817187;
        Sat, 17 Dec 2022 01:53:37 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gw14-20020a17090b0a4e00b00218a7808ec9sm2631369pjb.8.2022.12.17.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 01:53:36 -0800 (PST)
Date:   Sat, 17 Dec 2022 17:53:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/243: add _require_scratch_delalloc()
Message-ID: <20221217095333.eu7suyf7xb2mhyja@zlang-mailbox>
References: <1669198883-16-1-git-send-email-yangx.jy@fujitsu.com>
 <20221123162708.5odsnr7woikadldn@zlang-mailbox>
 <OS3PR01MB9499ADBBFC0524B5FB43982983E79@OS3PR01MB9499.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB9499ADBBFC0524B5FB43982983E79@OS3PR01MB9499.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 17, 2022 at 09:33:41AM +0000, yangx.jy@fujitsu.com wrote:
> Hi zorro,
> 
> Is it OK to merge the patch?

Thanks for ping me, I'll merge this patch.

Thanks,
Zorro

> 
> Best Regards,
> Xiao Yang
> 
> -----Original Message-----
> From: Zorro Lang <zlang@redhat.com> 
> Sent: 2022年11月24日 0:27
> To: Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com>
> Cc: fstests@vger.kernel.org
> Subject: Re: [PATCH] xfs/243: add _require_scratch_delalloc()
> 
> On Wed, Nov 23, 2022 at 10:21:23AM +0000, Xiao Yang wrote:
> > xfs/243 requires the delalloc feature of XFS so return [not run] when 
> > XFS with enabled DAX doesn't support it.
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> > ---
> 
> Looks good to me, this case starts to fail from xfs dax supports reflink.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> >  tests/xfs/243 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/xfs/243 b/tests/xfs/243 index 8f0c5939..739efe4a 
> > 100755
> > --- a/tests/xfs/243
> > +++ b/tests/xfs/243
> > @@ -27,6 +27,7 @@ _begin_fstest auto quick clone punch  _supported_fs 
> > xfs  _require_xfs_debug  _require_scratch_reflink
> > +_require_scratch_delalloc
> >  _require_xfs_io_command "falloc"
> >  _require_xfs_io_command "cowextsize"
> >  _require_xfs_io_command "fpunch"
> > --
> > 2.34.1
> > 
> 

