Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F2C05027
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Feb 2023 06:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNGSx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNGSw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 01:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B51205B
        for <fstests@vger.kernel.org>; Mon, 13 Feb 2023 22:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676355475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKIYuss8Y9Uq7QhmG2lxnu554KteJYlPqssqdGyUJks=;
        b=WGohBzSlhz0Z1poOlAGd4i0Ia+EdX/bDXmzQhLAudmXT+i/LkFys+55i4LmQ77JukkdSOi
        LAGPehyfVKWRtZfb5EtgZJdqG/G/eIlbh8teLi5n8S5ejV+72Scx1yKdypPy1axKBzVgKG
        tljrtEydRgtsejKekmUyNN2G7sjQMAk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-2glEpL1CM0S8oy1qxrjP0Q-1; Tue, 14 Feb 2023 01:17:54 -0500
X-MC-Unique: 2glEpL1CM0S8oy1qxrjP0Q-1
Received: by mail-pj1-f70.google.com with SMTP id gn18-20020a17090ac79200b0022bef1f49c9so546380pjb.0
        for <fstests@vger.kernel.org>; Mon, 13 Feb 2023 22:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKIYuss8Y9Uq7QhmG2lxnu554KteJYlPqssqdGyUJks=;
        b=5jj+cRzbrESRImd2SAPxAi5orKf3pQMJ+xHGFGaawfm1Nm5RBagpZjOiJ1IukrLkLC
         Wvt0a+XUAhCq3Ur0yWZo8SUYv1RvWRXlSuP+63ulrPp/M+UrUoVVqJ7zbcaEvfrvlX0A
         xLeeA+hbLsZxIKj8rdmyI9iuRs7iNG47uymAUQfkKt74/UqoaoiKEYDtswQjhkIAw1iC
         Z4GwpnpRFF0+Bmv1G80Y2RsezmpdcHR1V/X9QV8W9CoENQ+4T3h0Bdq1/1Y0eN48J1e/
         1uWwcxYqgblaSGVlhNx15CfF62LoDeXgtFu+fn27P8yMi4gc96Z1dlHxVcXJoxVtQCU+
         6V4Q==
X-Gm-Message-State: AO0yUKWtDaBRQTygxQul6wF81Aei8aukXBMy9VpIuIwt+HWd275yVVV7
        cG8aYohXDwvUAUiuysw5tK1h7vfNctk1oFDAPCX9BNuSjU/YElCXpPRG4avAwR+xAq6SysmhAPe
        UcepB5UOgN25z7jYLq2xn6zeCAZqq
X-Received: by 2002:a17:90b:17c7:b0:22b:f780:d346 with SMTP id me7-20020a17090b17c700b0022bf780d346mr1323519pjb.1.1676355472709;
        Mon, 13 Feb 2023 22:17:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9vXD+0dhaiYwvmHrm8GMqAE78AYfs7aQkLPUycTqbh5tDmj3t2cOjipfb2nG0aFiElwzeXLw==
X-Received: by 2002:a17:90b:17c7:b0:22b:f780:d346 with SMTP id me7-20020a17090b17c700b0022bf780d346mr1323502pjb.1.1676355472342;
        Mon, 13 Feb 2023 22:17:52 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a134500b0023317104415sm6379337pjf.17.2023.02.13.22.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:17:52 -0800 (PST)
Date:   Tue, 14 Feb 2023 14:17:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
Message-ID: <20230214061748.z4to5y6dr4byw3y7@zlang-mailbox>
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 13, 2023 at 05:45:09PM +0800, Anand Jain wrote:
> Add the _wants_kernel_commit tag for the benifit of testing on the older
> kernels.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Besides this patch, you just sent another patchset:
  [PATCH 0/3] fstests: btrfs- add _fixed_by for new tests in the auto group
which try to add _fixed_by for some btrfs cases.

I think we don't need to "fix" these things one by one, by lots of small patch
pieces. If there's not special reason (e.g. someone case need more fix besides
adding _fixed_by), how about combine them into one patch which "clarify the
_fixed_by or _wants commits for btrfs cases (or only for someone group)"

Thanks,
Zorro

>  tests/btrfs/249 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/249 b/tests/btrfs/249
> index 7cc4996e387b..1b79e52dbe05 100755
> --- a/tests/btrfs/249
> +++ b/tests/btrfs/249
> @@ -13,7 +13,7 @@
>  #  Dump 'btrfs filesystem usage', check it didn't fail
>  #
>  # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> +#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
>  #   btrfs-progs: read fsid from the sysfs in device_is_seed
>  
>  . ./common/preamble
> @@ -29,6 +29,8 @@ _supported_fs btrfs
>  _require_scratch_dev_pool 3
>  _require_command "$WIPEFS_PROG" wipefs
>  _require_btrfs_forget_or_module_loadable
> +_wants_kernel_commit a26d60dedf9a \
> +	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
>  
>  _scratch_dev_pool_get 2
>  # use the scratch devices as seed devices
> -- 
> 2.31.1
> 

