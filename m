Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C8C001DC
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjG0Pvh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0Pvg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 11:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BF2701
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690473049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLs83qTR2/0M8JlpqdviUB1R+uDjEqNfqfLlllpaFzc=;
        b=cBE2b1RC8Td2rQgganP0fksybcWpaI6h0sdthBDPGZTP7RzNDH4WQyTj1lFlftzlOYqiAL
        nGHlzjaiugvBHpA0uAOIEkrNDtgaM+g2jQ1Beeeq/okA19JHd4bGNdtQQeilwFpMRO0yDd
        5iy2PORLcuGi55zn8S8zIA3gFnalSaM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Kjc1hIiqNB6hvcuPxwSNhw-1; Thu, 27 Jul 2023 11:50:47 -0400
X-MC-Unique: Kjc1hIiqNB6hvcuPxwSNhw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-687071894eeso218392b3a.3
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 08:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473046; x=1691077846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLs83qTR2/0M8JlpqdviUB1R+uDjEqNfqfLlllpaFzc=;
        b=T4IFS7ML28LmqikUbqvfXkJz2ck9pjV092ZFbcX18Wkn+unqTR9K1ucyLK3goDTGhV
         S9lyUR7ymF0Zxn+HWsZ/1FmnV9WeM0lXdRk+Oj7NpvRDVPF3NT+6qo6uK0IO+p2gOpBO
         9D5rjDWQWQr8scCDsnN3L8pmC2qc4AX/3+P2TSJRl7QjELV8mD3XoXVCI/YSB+FAcA+i
         0eQ1Pe0y+KXRefldMPb1IhMJwIyBbE0j88aXO8jACYvMfiUvz1vt/PtUzaUaKIqj6m41
         5oRGc0zRp2ajDV+ZM8+ZaDgfxGOCVJ4qxMqqzm/ldpdnxld8kOd0/2FWz0XJUOgzG9Qo
         hapQ==
X-Gm-Message-State: ABy/qLa6CVDDoH0Rmi/K20p4knYUx+ikdPizR5U2M0fxr8u56RzpnjCk
        4cfJIuzUXrrKtTfbhrSGvPATim1exBkiyPVpffHn3mwgLgpJfWihTqTu+qRlo+ce0nHQZOITi3d
        9VgB2etdPA1vO/y7DwrCScgobx0Ka
X-Received: by 2002:a05:6a00:1a12:b0:686:25fe:d575 with SMTP id g18-20020a056a001a1200b0068625fed575mr5447189pfv.11.1690473046109;
        Thu, 27 Jul 2023 08:50:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzhLOdO4trU6+1ulijyC0esbB7AZHkuCQWaSKU7KZGTmNFu5dlH+/lT9Lkzk8pqiJw98KVpw==
X-Received: by 2002:a05:6a00:1a12:b0:686:25fe:d575 with SMTP id g18-20020a056a001a1200b0068625fed575mr5447175pfv.11.1690473045812;
        Thu, 27 Jul 2023 08:50:45 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b0065da94fe917sm1657277pfn.36.2023.07.27.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:50:45 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:50:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <20230727155041.u5yr3rtxneqhq2vl@zlang-mailbox>
References: <20230724030423.92390-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724030423.92390-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> The test case itself is utilizing RAID5/6, which is not yet supported on
> zoned device.
> 
> In the future we would use raid-stripe-tree (RST) feature, but for now
> just reject zoned devices completely.
> 
> And since we're here, also update the _fixed_by_kernel_commit lines, as
> the proper fix is already merged upstream.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Just check before next fstests release. This patch has been reviewed, but looks
like there're still more review points from btrfs list. So will you send a new
version to replace this patch?

Thanks,
Zorro

>  tests/btrfs/294 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/294 b/tests/btrfs/294
> index 61ce7d97..d7d13646 100755
> --- a/tests/btrfs/294
> +++ b/tests/btrfs/294
> @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +
> +# No zoned support for RAID56 yet.
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
>  _require_scratch_dev_pool 8
>  _fixed_by_kernel_commit a7299a18a179 \
>  	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +_fixed_by_kernel_commit cb091225a538 \
> +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
>  
>  _scratch_dev_pool_get 8
>  
> -- 
> 2.41.0
> 

