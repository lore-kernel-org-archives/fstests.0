Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014FC05027
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Feb 2023 06:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBNGH6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBNGH5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 01:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F7C658
        for <fstests@vger.kernel.org>; Mon, 13 Feb 2023 22:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676354830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yk+M4Z4PaucQjW1zh/2a/6uNCN1ynNxAYqJ1mJfTkAk=;
        b=jSG8f8UIONLsXHPOXyNJbi1yvGd02DQLlA9bGngtEzjD04nIjoJAll+QlIpEy6QVNRLXwA
        QDIcIyEgsBNmK8Y0j9BTyi+HuY+/1r/kdDxuz7Nk4PORU0jDwmD9+aqijiX64lbd3nBKds
        dRtRVa8S7pGyKgk32+twVU69P4qQb+o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-0wTHG0D9NAOTZGwMSWU64g-1; Tue, 14 Feb 2023 01:07:09 -0500
X-MC-Unique: 0wTHG0D9NAOTZGwMSWU64g-1
Received: by mail-pl1-f198.google.com with SMTP id h5-20020a170902748500b0019aacd1fb04so1573212pll.2
        for <fstests@vger.kernel.org>; Mon, 13 Feb 2023 22:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk+M4Z4PaucQjW1zh/2a/6uNCN1ynNxAYqJ1mJfTkAk=;
        b=ussNXj5DRVkuJPhoFMUY+oAzMpyMD/yy7/bRYhrXdTPy+yDPJGjX34EtbUlFXQo9q9
         gpBGKBmlBM4bp9pU2vfzDiwzwiO6HV6SGInzJl5GowlxFmLrOymGJ06s8OB5jByVfS/W
         4V1sgZq8eu+5y5lHd2rDdbWW/KuB2CFHEiqobOyqiphHm2X9TJ+HK//sq0JARvzrkY7T
         Sx5UJhJXfvg0rIcZ+NuTCA9Vfn+sdAY7KYBs5q5/6qfLaP9aUP1JOJRwLrrX+uOgz8bP
         oNx7JNJtA6WBzJ845iscyibCKe5Tj8nvI3qZzurvwEc7ssxx9ctZm2XATz1osVYUUnpw
         fXfw==
X-Gm-Message-State: AO0yUKWBasGAsaaHZDXIyRQpk7q9XZ6lj6iCB0vupNeLPGVbmvSf2N/C
        Zt8GLeM4OLYD3p04PiamTyILNsQHpgFBvrVYIwqzBFFRSCbyzPJYNVE6vjjJQH9+6XAPMWwESDm
        2+912M+COjG/aidic0duUnJBTVd7R
X-Received: by 2002:a17:903:2806:b0:19a:b427:230a with SMTP id kp6-20020a170903280600b0019ab427230amr1317801plb.63.1676354827531;
        Mon, 13 Feb 2023 22:07:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9UuLrF+CyDtS6bxYajhRJlIHFea+YmXvej7+adlx3Hzefr+vGEDd0XD3sJUgQIRcOO6EfCoA==
X-Received: by 2002:a17:903:2806:b0:19a:b427:230a with SMTP id kp6-20020a170903280600b0019ab427230amr1317780plb.63.1676354827062;
        Mon, 13 Feb 2023 22:07:07 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s1-20020a63dc01000000b004fab4455748sm8258405pgg.75.2023.02.13.22.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:07:06 -0800 (PST)
Date:   Tue, 14 Feb 2023 14:07:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, zlang@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fstests: btrfs/219, add _fixed_by_kernel_commit
Message-ID: <20230214060702.5jiajtxcogixruqj@zlang-mailbox>
References: <cover.1676034764.git.anand.jain@oracle.com>
 <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 10, 2023 at 09:41:20PM +0800, Anand Jain wrote:
> btrfs/219 is in the auto group so add the _fixed_by_kernel_commit
> tag for the benifit of the older kernels. The required commit is not yet
> in the mainline so there is no commit id yet.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/219 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index 528175b8a4b9..79ba31549268 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -8,7 +8,7 @@
>  # to make sure we do not allow stale devices, which can end up with some wonky
>  # behavior for loop back devices.  This was changed with
>  #
> -#   btrfs: allow single disk devices to mount with older generations
> +#	btrfs: free device in btrfs_close_devices for a single device filesystem
>  #
>  # But I've added a few other test cases so it's clear what we expect to happen
>  # currently.
> @@ -42,6 +42,8 @@ _supported_fs btrfs
>  _require_test
>  _require_loop
>  _require_btrfs_forget_or_module_loadable
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: free device in btrfs_close_devices for a single device filesystem"

It was just merged ;)

commit 5f58d783fd7823b2c2d5954d1126e702f94bfc4c
Author: Anand Jain <anand.jain@oracle.com>
Date:   Fri Jan 20 21:47:16 2023 +0800

    btrfs: free device in btrfs_close_devices for a single device filesystem


>  
>  loop_mnt=$TEST_DIR/$seq.mnt
>  loop_mnt1=$TEST_DIR/$seq.mnt1
> -- 
> 2.31.1
> 

