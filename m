Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72AC432BE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 09:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AF661052
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhH3Jzv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Aug 2021 05:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233248AbhH3Jzu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Aug 2021 05:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630317297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vP8w5rdO3hSKEP9tjMH02dCMt9ycfHt9i2ByiOnGlNw=;
        b=FtoZeelgMQE1lzdJpW8dDCxLRgIlKZQbROEGJHh2KVJyUtMFzCVqu51MNXqXkTiYH2Db2s
        Ylz109/DS4aEZceLBvwJIyNLUB+dh+RGUD8Dc9/kIOJOTiOr+AQe+Tgbn4HLfKlHEAwLil
        565EsDw5mTwy99pSNx+sTfkh0O4cQik=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-92_p0Gn-Nn-t-3uVRbQyJA-1; Mon, 30 Aug 2021 05:54:55 -0400
X-MC-Unique: 92_p0Gn-Nn-t-3uVRbQyJA-1
Received: by mail-pj1-f70.google.com with SMTP id nn5-20020a17090b38c500b00179d350674aso196699pjb.5
        for <fstests@vger.kernel.org>; Mon, 30 Aug 2021 02:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=vP8w5rdO3hSKEP9tjMH02dCMt9ycfHt9i2ByiOnGlNw=;
        b=lyPwx0jU0x/hPkbMjSlC1pQUKrrT74sujvOWpq9ugB+kyE50dQq6jcB3UmFIgTz2aF
         AlJwin2m4ZlKN9kF2NuAWyKNK0TyCza+hjF2Xs2KwzH4s7wKZ0DrxV5udDC7C1Fy0eWG
         xkMMm8VvWY5GC7s7MyWNcNIgea7tklnPKp0O8wwMGB6Q8EfFbH6q2AemoYgdqtTDZe7S
         pJgFFwQAG1DbH5qh0MeaRv0Lv0hP2IEEzx6kjiJ82/Kn5bdyac0PM6syQaaWIq/Xd3nn
         7JSygeipis9VA9Puker9y6UeZuKE+jx0wCDetKvTt8soRD9/6FhQnofkksVsiFMu+vkY
         0liw==
X-Gm-Message-State: AOAM530af6ZG7dzZj+Q+RB2MbwtFiIl73FvucX1D3LLsFxBW22UQKHIm
        q3M/DnAy5z0+L7YRmU2MvivScwSVDmYmtC1Q/cxDRRJSUwx4j6YV/69BS2CVi2n9n8/1gWTTE4H
        txTBq14v2OzKLUoq0bzO4EX8+AGID5IgXxQvNIVuIk1OzJF5MTaRpt33lGvartxF+0Q==
X-Received: by 2002:aa7:8d0c:0:b029:3e0:2e32:3148 with SMTP id j12-20020aa78d0c0000b02903e02e323148mr22564180pfe.23.1630317294134;
        Mon, 30 Aug 2021 02:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEU//tuvkIwwA+hvbdR/41wvOz5t201uyxQbfJr8fXTS1J9OI2X9jwWdZ8qzWUmw4V/EW+OQ==
X-Received: by 2002:aa7:8d0c:0:b029:3e0:2e32:3148 with SMTP id j12-20020aa78d0c0000b02903e02e323148mr22564147pfe.23.1630317293623;
        Mon, 30 Aug 2021 02:54:53 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm16757216pgh.52.2021.08.30.02.54.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:54:53 -0700 (PDT)
Date:   Mon, 30 Aug 2021 18:15:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/081: clean up snapshot devices correctly
Message-ID: <20210830101551.jcqgfoiasl7cwcvd@fedora>
Mail-Followup-To: fstests@vger.kernel.org
References: <20210830011324.696984-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830011324.696984-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 30, 2021 at 11:13:24AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> I recently updated the userspace on a DAX-capable test VM, and no
> g/081 fails to release the SCRATCH_DEV correctly. g/081 fails on dax
> capable devices because DM rejects one of the setup operations:
> 
> The 081.full output file shows setup failure and then snapshot
> creation failure:
> 
>   Wiping xfs signature on /dev/pmem1.
>   Physical volume "/dev/pmem1" successfully created.
>   Volume group "vg_081" successfully created
>   Logical volume "base_081" created.
>   device-mapper: reload ioctl on  (251:0) failed: Invalid argument
>   Failed to suspend logical volume vg_081/base_081.
>   Device vg_081-base_081-real (251:1) is used by another device.
>   Failed to revert logical volume vg_081/base_081.
>   Aborting. Manual intervention required.
> Failed to create snapshot
> .....
> 
> And dmesg tells us the reload ioctl failed because:
> 
> [ 2977.522306] device-mapper: ioctl: can't change device type (old=3 vs new=1) after initial table load.
> 
> DM table types are:
> 
> enum dm_queue_mode {
>         DM_TYPE_NONE             = 0,
>         DM_TYPE_BIO_BASED        = 1,
>         DM_TYPE_REQUEST_BASED    = 2,
>         DM_TYPE_DAX_BIO_BASED    = 3,
> };
> 
> which indicates that the original table is DAX_BIO based (correct,
> this is a pmem device) but then one of the setup operations is for
> a type that is not DAX capable. Hence it fails and then things go
> bad.
> 
> But the test has actually created the snapshot device and it's COW
> target, so now when the _cleanup() function is called, the vgremove
> command fails because the VG is busy (still has snapshot devices
> attached to it) and at this point $SCRATCH_DEV is now unusable
> without manual cleanup.
> 
> Manual cleanup just needs to remove the snapshot and logical base
> volumes before trying to remove the vg and pv.  With this change, we
> now see the teardown do:
> 
> ....
> Failed to create snapshot
> umount: /mnt/test/mnt_081: not mounted.
>   Logical volume "snap_081" successfully removed
>   Logical volume "base_081" successfully removed
>   Volume group "vg_081" successfully removed
>   Labels on physical volume "/dev/pmem1" successfully wiped.
> 
> And future tests are able to use the SCRATCH_DEV normally.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/081 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 8e552074..9f294c11 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -33,6 +33,8 @@ _cleanup()
>  	while test -e /dev/mapper/$vgname-$snapname || \
>  	      test -e /dev/mapper/$vgname-$lvname; do
>  		$UMOUNT_PROG $mnt >> $seqres.full 2>&1
> +		$LVM_PROG lvremove -f $vgname/$snapname >>$seqres.full 2>&1
> +		$LVM_PROG lvremove -f $vgname/$lvname >>$seqres.full 2>&1

Make sense to me. Although I don't fail on it, this patch doesn't break
my test.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
>  		$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
>  		pv_ret=$?
> -- 
> 2.31.1
> 

