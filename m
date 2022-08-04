Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A3BC19F2D
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Aug 2022 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiHDPzq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiHDPzp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Aug 2022 11:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 908C75A3F1
        for <fstests@vger.kernel.org>; Thu,  4 Aug 2022 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659628543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pNL0egjBkG+BP0MH7GdjTEPH9+6j5n3QqKqr1VdtFY=;
        b=Cc4arEMd6pvafeNpi0IlaobPJZZYimpl8Mn0wrM9xmxJ3/VSJSJ/337FduSjlKU0Z5xQG/
        EyGfHFDh3fG6NJz15KRx/aPW1eektc4CMekbSXwdAxkroCJWeuKsMHKV3fu/FRj3NxdIoZ
        7rKdSnQIrkSLtka1UuNYJiumU1peYCA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-KLUkQXGqPSyLWQnV_DcNHw-1; Thu, 04 Aug 2022 11:55:41 -0400
X-MC-Unique: KLUkQXGqPSyLWQnV_DcNHw-1
Received: by mail-qv1-f72.google.com with SMTP id p14-20020a0cfd8e000000b004747f93486bso12083788qvr.13
        for <fstests@vger.kernel.org>; Thu, 04 Aug 2022 08:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pNL0egjBkG+BP0MH7GdjTEPH9+6j5n3QqKqr1VdtFY=;
        b=yXRDO98ohVR5o1m+iznX0szlaSTujNXM0hkpq+K2dJcpeyOTtepon+FIN1QnM8EAob
         UTO656PneXmvu1nQ3hafQwSDksjgI5IiSlB85+1MyP/snbyKYpTrUKhk/PqFjtiRbGlC
         vNyzVqvW9v2MMeP4uG1lvepviSSwvk3R5tR4QDl63ne2tt/KGMJjUOW7nC5VmX/h5rWM
         Juz0tVF9RqFJNGEncMaPpiH0938jrGcuC21tOzl71XZmyeWK05x2d8R+Kt0SlaAPHtqW
         1PpnKQiRmrFasqEEyNt4UCO2u4HExNZgLotFf9dCf8/UaQRvp8MBb3x+WU2QaK4gaS/w
         pW0w==
X-Gm-Message-State: ACgBeo3uGckvi0hdWHhTAbrtXbaIeX83bnCruIq1Xrnlzvm3EvysrUZ7
        VWCqg3jkdUtOgIFsLddFQnPdaR+8XSfLBu/D8MHlOGKLqXEi9dYV+AOaw++P6uHIH6SmWaOlFKL
        RnZHDQkd0eSG9O/maRQ==
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id iu3-20020ad45cc3000000b004748ddadfb6mr2109305qvb.82.1659628541311;
        Thu, 04 Aug 2022 08:55:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR75zDCx6FVm3tLPC/OCoRSc3pRW7lEVS2d517s4KefL55ZAY/HaYI3HImU+eGD6M57LELKogw==
X-Received: by 2002:ad4:5cc3:0:b0:474:8dda:dfb6 with SMTP id iu3-20020ad45cc3000000b004748ddadfb6mr2109281qvb.82.1659628540998;
        Thu, 04 Aug 2022 08:55:40 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a187-20020ae9e8c4000000b006b893d135besm858350qkg.108.2022.08.04.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 08:55:40 -0700 (PDT)
Date:   Thu, 4 Aug 2022 23:55:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs/432: fix this test when external devices are in
 use
Message-ID: <20220804155534.7jnplh6e3tuz6sua@zlang-mailbox>
References: <165950048029.198815.11843926234080013062.stgit@magnolia>
 <165950048600.198815.10416873619760657341.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165950048600.198815.10416873619760657341.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 02, 2022 at 09:21:26PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This program exercises metadump and mdrestore being run against the
> scratch device.  Therefore, the test must pass external log / rt device
> arguments to xfs_repair -n to check the "restored" filesystem.  Fix the
> incorrect usage, and report repair failures, since this test has been
> silently failing for a while now.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/432 |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 86012f0b..e1e610d0 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -89,7 +89,8 @@ _scratch_xfs_metadump $metadump_file -w
>  xfs_mdrestore $metadump_file $metadump_img
>  
>  echo "Check restored metadump image"
> -$XFS_REPAIR_PROG -n $metadump_img >> $seqres.full 2>&1
> +SCRATCH_DEV=$metadump_img _scratch_xfs_repair -n &>> $seqres.full || \
> +	echo "xfs_repair on restored fs returned $?"

It's good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

If anyone has more review points, please feel free to tell us :)

>  
>  # success, all done
>  status=0
> 

