Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5946FEB64DD
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 14:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGDOXl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGDOXk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Jul 2023 10:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95BE76
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688480575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1FCPb3UjjIlq2IWt6mOqtBbhOF0NVRHcyVgC1SCltI=;
        b=I1T/MvJT36Mj0tFBU4mvKmikbFrfae6k1R0zw+5WsQzRpcHWtYey+xU9Hv5O7rdmPV1a0h
        nAtG/j3l3dpS24rETksWgzgnl8rj+En7akr76xSjnpNsqEnZCNe1rm1Ue0C3QLBWZIzyIx
        IE8Ei7W4dpOvRhDl6mYeMw3l7DE/jBw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-poG8PrBDOZC8TeZqeAyucA-1; Tue, 04 Jul 2023 10:22:53 -0400
X-MC-Unique: poG8PrBDOZC8TeZqeAyucA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e0889cc5so57415466d6.2
        for <fstests@vger.kernel.org>; Tue, 04 Jul 2023 07:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480573; x=1691072573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1FCPb3UjjIlq2IWt6mOqtBbhOF0NVRHcyVgC1SCltI=;
        b=RSKVZFlCk7T06wYeKx09FhlAjWA09ckQ5pqBFeEaNDg1+aS1+C1XfWdwe2qt/37KHI
         AAUhvhgWJ+Zg0iDgKTBWYcQXlBciAMjluBQB8R2zBtLf6p65bTy5qku5sEi0dluL7CQv
         Q/1sKjEww+Xf3AQ8FGqqOxHN6SiqVnbD1+mmitqI5iKA/bPuOk1Vv0g+dSKrz4smY4Bl
         0n1dbjYpwV7oH7AjtGBn61YkG2C30Kja76f95JMvGwrlLzh2M6fjBaYm2V0n33JV3j8C
         aPsBQe1chLs3Qpvya0tji8BXFisryDOEsHwkLYAwhjJckqsg1tPXsL3nfOtVxMmYmIuS
         trfw==
X-Gm-Message-State: ABy/qLbpyjMjcch3UWEdyBvM6tdCW5T7GxIM+jczyf7wwgxXkro6rppD
        auIia/A1n+bdzeWWuPHSXwA7Ep1uafjT4Je3aHywhHr5P9POtuTGZDOzYolo1H85bE8Fv9nNUb8
        rls0NZMQpMordMbvK
X-Received: by 2002:a0c:e9c7:0:b0:636:326c:2288 with SMTP id q7-20020a0ce9c7000000b00636326c2288mr12383835qvo.63.1688480573150;
        Tue, 04 Jul 2023 07:22:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYJpjPl+vnISLGOYuZbKtA3iFPoWqRqx3Mh8H/4OubiFCW6y6Vu6lsb/Al71+lykFlcUBRDQ==
X-Received: by 2002:a0c:e9c7:0:b0:636:326c:2288 with SMTP id q7-20020a0ce9c7000000b00636326c2288mr12383823qvo.63.1688480572932;
        Tue, 04 Jul 2023 07:22:52 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id dk13-20020a056214092d00b005dd8b9345besm12611293qvb.86.2023.07.04.07.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:22:52 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:22:49 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 4/5] xfs/041: force create files on the data device
Message-ID: <20230704142249.bys4vlk5iryewd3z@aalbersh.remote.csb>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840383563.1317961.17059869339313726876.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168840383563.1317961.17059869339313726876.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-03 10:03:55, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since we're testing growfs of the data device, we should create the
> files there, even if the mkfs configuration enables rtinherit on the
> root dir.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/041 |    3 +++
>  1 file changed, 3 insertions(+)
> 
> 
> diff --git a/tests/xfs/041 b/tests/xfs/041
> index 05de5578ff..21b3afe7ce 100755
> --- a/tests/xfs/041
> +++ b/tests/xfs/041
> @@ -46,6 +46,9 @@ bsize=`_scratch_mkfs_xfs -dsize=${agsize}m,agcount=1 2>&1 | _filter_mkfs 2>&1 \
>  onemeginblocks=`expr 1048576 / $bsize`
>  _scratch_mount
>  
> +# We're growing the data device, so force new file creation there
> +_xfs_force_bdev data $SCRATCH_MNT
> +
>  echo "done"
>  
>  # full allocation group -> partial; partial -> expand partial + new partial;
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

