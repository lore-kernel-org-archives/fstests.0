Return-Path: <SRS0=lR6x=4L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E0C35671
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBA6206ED
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQRH2Tfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgBWOWS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 09:22:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34468 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWOWS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 09:22:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so3628452pgi.1
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2020 06:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y95Py1iH6Pfz/mn3L4A9gwWpjF2eeRR9SbJT/7u52pw=;
        b=kQRH2TfrPiekoMYwRdAyyforoW5PonUj9aZyT8GHOooI82RQZu999oKZmN/cXpP5JG
         kx3cP2jKETwRN4VJiVGKE2SJDmIdF4kGjAE48sThr5amp3qfSe8p1lxhr2kZxMeaOhez
         XB63MT77KNGWfuSJfKQuEgt4ryXfGJpNAn3kW36Hu0+SsrZ72EC2V+RkIyFF8QZeWmcM
         zHXlaeeoJth8cPGTLMBHXtJkj1xYOelyhzj6sogQrBuuLM6F3Vjs+Q+5So3mQInmW7nW
         DRCPRXV99z1lQ7LLLSPHzWHgbFsYVKgjLMrBsMccb89Gj3L+fBHR3IZ4/Ic+XV8vzuy1
         Pykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y95Py1iH6Pfz/mn3L4A9gwWpjF2eeRR9SbJT/7u52pw=;
        b=acA/h5CGitP4RN3kGC61h+aNlhT4AOxaycxMcuYZHEElTIqdS1WVD9sUVNrW/CKlIx
         /jSGYjKUuF7ec9QlYdElUMQgdolqmtYkcCuTqn2RXZ+L2hMTaZZedCq7k46zJteCAYcB
         6ln0E/mSl+0jynXBZNd3Xilk2x8UdwT/UpWF7HgbQh37jmuievsqSEE0k+U0dRWAsFeh
         z8BT6L+Muzy2KF1mn4Im+LgXXLORlhCnuY7N0X9ZzNSTaAXTPaBxmJp0zhoG3aZ0sl2q
         zxFm3Ec9sFN5kYSgeutRvCW2neuiCX/XDKhqbi6XVJvxReqiCR6s4zrO0KAEilAqWC8P
         akhA==
X-Gm-Message-State: APjAAAV/LSuS17sYimjCWNyHT5QUu5Wiv5fGgikD6nU9/U0KzvAECfG9
        LcZ5IojS1wA+o+deK6hpg64=
X-Google-Smtp-Source: APXvYqzvq678TYDH9aeP274o9b1XU62rDQGQit9cefeM9Hos5sGDznTyJ8FrDftZpXe69B4MKEP7uA==
X-Received: by 2002:a63:e20d:: with SMTP id q13mr15662963pgh.6.1582467737300;
        Sun, 23 Feb 2020 06:22:17 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id c5sm9328097pfi.10.2020.02.23.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 06:22:16 -0800 (PST)
Date:   Sun, 23 Feb 2020 22:22:10 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>, darrick.wong@oracle.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/log: add -l su option in _xfs_log_config
Message-ID: <20200223142208.GD3840@desktop>
References: <20200220021709.GF9504@magnolia>
 <1582177081-6235-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582177081-6235-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick,

On Thu, Feb 20, 2020 at 01:38:01PM +0800, Yang Xu wrote:
> Currently, if we don't specify -l sunit or -l su option, mkfs.xfs
> will get the stripe size from underlying device.
> 
> It works file on most situations. But on some machine, the size of
> underlying device greater than logbsize of mount options, it will
> report error like "logbuf size must be greater than or equal to log
> stripe size". We can specify -l su=4096 to meet this requirement and
> case can still run normally.
> 
> Also, from xfs manpage, version 2 also supports 16k log buf size for
> mount option and case passed(only generic/054,055 used this api) on
> my machine. So delete 32k and 64k with different sunit to be consistented
> with ext4 test num(10) and we can test all logbuf size.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Would you like to review this v2 patch again? I feel more confident if
xfs maintainer could ack it :)

Thanks,
Eryu

> ---
>  common/log | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/common/log b/common/log
> index c7921f50..9b5a2f6d 100644
> --- a/common/log
> +++ b/common/log
> @@ -546,15 +546,15 @@ _xfs_log_config()
>  {
>      echo "# mkfs-opt             mount-opt"
>      echo "# ------------------------------"
> -    echo "  version=2            logbsize=32k"
> +    echo "  version=2,su=4096    logbsize=16k"
> +    echo "  version=2,su=16k     logbsize=16k"
>      echo "  version=2,su=4096    logbsize=32k"
> -    echo "  version=2,su=32768   logbsize=32k"
> -    echo "  version=2,su=32768   logbsize=64k"
> -    echo "  version=2            logbsize=64k"
> +    echo "  version=2,su=32k     logbsize=32k"
> +    echo "  version=2,su=4096    logbsize=64k"
>      echo "  version=2,su=64k     logbsize=64k"
> -    echo "  version=2            logbsize=128k"
> +    echo "  version=2,su=4096    logbsize=128k"
>      echo "  version=2,su=128k    logbsize=128k"
> -    echo "  version=2            logbsize=256k"
> +    echo "  version=2,su=4096    logbsize=256k"
>      echo "  version=2,su=256k    logbsize=256k"
>  }
>  
> -- 
> 2.18.0
> 
> 
> 
