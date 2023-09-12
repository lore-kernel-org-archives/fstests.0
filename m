Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B41CA0EC3
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Sep 2023 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjILMfQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjILMfP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Sep 2023 08:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A651C4
        for <fstests@vger.kernel.org>; Tue, 12 Sep 2023 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694522070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBu8QFGGHrniD5fjvhovYgFP6bR6XUKKyXBiNreekfs=;
        b=GoBWwXBwd7T69hZGa/rCejB4D0Nhi0c4bMFvBoCLps8+fjVL/XKHMq75PIWGqgmkrD0nsX
        uFozS4ATY3WEWadbnoYCELZ6OZOaPAZh5J0huLZ4pVt60pI0mHV/JSANPeWqZBm3DZp7Wj
        H03kdOn/hbS+6FQrCiM8QgU6kWwhnZY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-hWL0Mu6ANXKhVqk1k3ABuQ-1; Tue, 12 Sep 2023 08:34:28 -0400
X-MC-Unique: hWL0Mu6ANXKhVqk1k3ABuQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d5970cbdbso8085248a91.0
        for <fstests@vger.kernel.org>; Tue, 12 Sep 2023 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522068; x=1695126868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBu8QFGGHrniD5fjvhovYgFP6bR6XUKKyXBiNreekfs=;
        b=LrjjusMTjVNacgQ1feZemdqyhnC8FygvwhyP87Qp/HmI0Yf9doV7ixKgPZ/k+rlV1B
         /KUgUr9anrYHlR81sIp34uqlvZ5yGpcXn98gbO4DD3jfVWM/im1x+tRJ06NMwvIEe7tu
         fckU8C+yzS7ydkYoV6wQrbjGG/A+rrfyCMBvu0RDjiG5p5NTphOthFe1E0HdgLxpcRvz
         GmyKRouyXQPJ/85wEoyxQkc9ynw7I/NV34bIXr3tajYoeNr74P5thlExnQh5bhh3n/BV
         msQ+QVw+bPDaqvEjrqyVIw0Ckg3W2uvrfj/T5yaaNh1+HKHpscsvfRy1/plbyIh19Zcd
         gfoQ==
X-Gm-Message-State: AOJu0YxXZxI+qayKylZqA6RugpPsitAuYfIqgIYvIw4qzc7n778qg0/a
        iAkvKMJ7I7/nNrl3CEzGv6jphw0JSMljSjiqARcbCyCWTp5yqECJ0Mqg/JekDnzDvhqPINqUcrx
        ouYGfCjXBcmTOVOtsaw==
X-Received: by 2002:a17:90a:c58e:b0:268:ca76:64a with SMTP id l14-20020a17090ac58e00b00268ca76064amr9974715pjt.49.1694522067940;
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGviPz0Iq3LT0P0x565RoZ7xF05LEfSe0Pcnp73e1gSCRYxbAYywh8un9FwH6hhLpmZS/N+tQ==
X-Received: by 2002:a17:90a:c58e:b0:268:ca76:64a with SMTP id l14-20020a17090ac58e00b00268ca76064amr9974704pjt.49.1694522067619;
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001bb1f0605b2sm8341066plg.214.2023.09.12.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
Date:   Tue, 12 Sep 2023 20:34:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Message-ID: <20230912123424.cy2bnpu3zbmbzxcy@zlang-mailbox>
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
> As we are obliterating the need for the device scan for the single device,
> which will return success if the basic superblock verification passes,
> even for the duplicate device of the mounted filesystem, drop the check
> for the return code in this testcase and continue to verify if the device
> path of the mounted filesystem remains unaltered after the scan.
> 
> Also, if the test fails, it leaves the local non-standard mount point
> remained mounted, leading to further test cases failing. Call unmount
> in _cleanup().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Make sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/185 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index ba0200617e69..c7b8d2d46951 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	$UMOUNT_PROG $mnt > /dev/null 2>&1
>  	rm -rf $mnt > /dev/null 2>&1
>  	cd /
>  	rm -f $tmp.*
> @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
>  	echo ..:$? >> $seqres.full
>  done
>  
> -# Original device is mounted, scan of its clone should fail
> +# Original device is mounted, scan of its clone must not alter the
> +# filesystem device path
>  $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
> -[[ $? != 1 ]] && _fail "cloned device scan should fail"
>  
>  [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
>  						_fail "mounted device changed"
> -- 
> 2.39.3
> 

