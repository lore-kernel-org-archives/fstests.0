Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BE4C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiDMRqc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiDMRqb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 13:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFF8D6D19A
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649871849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lH0hV3gD6qRTBtPoQBC/7Vat2RdlXA7bzWbab/FAosI=;
        b=VFdE3UbCcFseiT5jGcXdSSMP0DSDqLUlXl8Fr5fPN6+2nPq3wK+vrQV4nI0QE7QHdDvXQo
        evk7pPW7aMRDIKXiwG2QAbElv3By74Jhj78XCoSeIbHShAKTrH3qn6LJkZp5BrQ45wW5Mr
        inhe2d+cKwPLd9k2ZVg+AEePh5v4Tds=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-1V30UEvyNWetNq7mpkS43g-1; Wed, 13 Apr 2022 13:44:08 -0400
X-MC-Unique: 1V30UEvyNWetNq7mpkS43g-1
Received: by mail-qt1-f200.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso1721054qtc.12
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 10:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lH0hV3gD6qRTBtPoQBC/7Vat2RdlXA7bzWbab/FAosI=;
        b=DjntOm69a08a99JCv7pCswm3KcTBr12ecM7np29JWkRjtMNhc+cU9K6XYjPp+RHvZy
         9e1PT/iDBW6mKRWRdIcsjALfapxMW7h16fk775PtJoWxrFKEPyACHCvwfS9DnazxPvAf
         z33cdndE0widwK3xQachD37ZMDg8Q6FyAdO5zDhsEnp2vBkYAPeWFqdWzCvYxBp/uC5H
         f5CbGoah1PlTuzGyocn+bWz4KsDrq/Cj379aFneiakaEbPejurmI40vjLn086ihE09rS
         M3JqBjZ7fbk/mma3AQ4FO+1Cbn+T84EOJFrsVfFodRoHxxe+xl0txBU1gbXUiM946Ai0
         zUAg==
X-Gm-Message-State: AOAM53128sXtqRhkPBpV2isfBTCd+V14Mgashw56rzgDuI8nzUsfqjIk
        Wj8JsCRblITcC3rrCbA+ccKa3cajz/UHGar9QhYfITgGG44W/CEYJq4G4wNZW81g5xCwlqWEmDO
        Wpd4EdJpihAshSMOHFQ==
X-Received: by 2002:ad4:5c6e:0:b0:443:be74:bf4f with SMTP id i14-20020ad45c6e000000b00443be74bf4fmr36345654qvh.56.1649871847017;
        Wed, 13 Apr 2022 10:44:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6qDkCVZF2xBimrYlxE7+tvGQ49qgUg5k9fHbPKLYjtqXPeYhnwnPcatrObsjfX1jufen+RQ==
X-Received: by 2002:ad4:5c6e:0:b0:443:be74:bf4f with SMTP id i14-20020ad45c6e000000b00443be74bf4fmr36345643qvh.56.1649871846835;
        Wed, 13 Apr 2022 10:44:06 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm30212741qtd.24.2022.04.13.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:44:05 -0700 (PDT)
Date:   Thu, 14 Apr 2022 01:44:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/216: handle larger log sizes
Message-ID: <20220413174400.kvbihaz6bcsgz4hy@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971769710.170109.8985299417765876269.stgit@magnolia>
 <164971771391.170109.16368399851366024102.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971771391.170109.16368399851366024102.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 03:55:13PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> mkfs will soon refuse to format a log smaller than 64MB, so update this
> test to reflect the new log sizing calculations.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/216.out |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/tests/xfs/216.out b/tests/xfs/216.out
> index cbd7b652..3c12085f 100644
> --- a/tests/xfs/216.out
> +++ b/tests/xfs/216.out
> @@ -1,10 +1,10 @@
>  QA output created by 216
> -fssize=1g log      =internal log           bsize=4096   blocks=2560, version=2
> -fssize=2g log      =internal log           bsize=4096   blocks=2560, version=2
> -fssize=4g log      =internal log           bsize=4096   blocks=2560, version=2
> -fssize=8g log      =internal log           bsize=4096   blocks=2560, version=2
> -fssize=16g log      =internal log           bsize=4096   blocks=2560, version=2
> -fssize=32g log      =internal log           bsize=4096   blocks=4096, version=2
> -fssize=64g log      =internal log           bsize=4096   blocks=8192, version=2
> +fssize=1g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=2g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=4g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=8g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=16g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=32g log      =internal log           bsize=4096   blocks=16384, version=2
> +fssize=64g log      =internal log           bsize=4096   blocks=16384, version=2

So this will break downstream kernel testing too, except it follows this new
xfs behavior change. Is it possible to get the minimal log size, then help to
avoid the failure (if it won't mess up the code:)?

>  fssize=128g log      =internal log           bsize=4096   blocks=16384, version=2
>  fssize=256g log      =internal log           bsize=4096   blocks=32768, version=2
> 

