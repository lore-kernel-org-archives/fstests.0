Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79658C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Oct 2021 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD2610D0
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Oct 2021 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJTSsE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhJTSsD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Oct 2021 14:48:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF2C061749
        for <fstests@vger.kernel.org>; Wed, 20 Oct 2021 11:45:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h20so4022042qko.13
        for <fstests@vger.kernel.org>; Wed, 20 Oct 2021 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbJmHDQTK+9eV6VZ6ElyTBMAkrkt3WyBRIUgWQKP3Ic=;
        b=QUrOIWp5ymfFPnAvyK0ouUou6z6ifgXQWTuPEhzgtOhnXVWvXRgHE60LtmQO+latJK
         Hj/3vyI1P7bJbrA67zfYeDxj4V0CzL611wWQB2VzeqDo4/dLLxjHC1jhayjhQdfB2mk8
         ovT6mA9ohcVjFahYSLrqMPYzkqQ2JWXDJdaHlxYf8IBVilIM2HOnoROTIF88fwdOJSIu
         1kwLOGtvGEvE+/XoYDfyFrskg3pbHrJ3UGKaoBCOhKEVhSEIclHlUyBsBok9jH2/siF/
         Xi9CPp/XT/EhEey/VQ8E/OT5MYh521Z5NrTLWlu4XBQr7DbdqYX30zeeI+E60InxBZfc
         v9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbJmHDQTK+9eV6VZ6ElyTBMAkrkt3WyBRIUgWQKP3Ic=;
        b=NyguBOO/JI/CgWNkrywTQnwTuopvZgHIhnh67uWklRna4whncyhmbMFgp3w8FekMZu
         VhSPVn2CR4XzL6UHc2I8b8dzqmCqzaL0q4dSdlZTTA6Pl0iSLgI1t3G3EgG/1pSDsxoZ
         FRYm4gjrbfktzqH0CLJoWRFAssK5KnWJ2lq+aNmVAy5w2NuuncQLvsJx9OMIwHAnMkTZ
         jUgh58vf5y7wV9C6C/5FZxM56fCZwRF/I0Vy4SB9oLyqTGughMKjKEdrEC+7CuBfW8iL
         2NrUev/WBPYuTrb7XEvWz9A7X0GzJL8YtpK62DOHFvmm0OXfjZSZR1GJN72na6og2Y/+
         B/UA==
X-Gm-Message-State: AOAM533bswr6UqRJOV+LTYOMojDp/Z1xrLQIiXxzvkNVt9zzUoOC27uS
        giQ10Gkj3dwsbDkM27wMc9KCFA==
X-Google-Smtp-Source: ABdhPJwh+woVPoPlQfFpwvyT4y5LTeFpjEzF9IzibcHe8hCEdiY4arWiH4xCOiOsbwZ5Cb6dsD+8hg==
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr674845qkf.391.1634755548157;
        Wed, 20 Oct 2021 11:45:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm1311219qti.38.2021.10.20.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:45:47 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:45:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests: btrfs validate sysfs fsid and usage
Message-ID: <YXBj2qJ0NlZuFuh7@localhost.localdomain>
References: <cover.1634713680.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634713680.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 20, 2021 at 03:16:41PM +0800, Anand Jain wrote:
> Patch 1 adds a helper to check if the kernel is latest enough to provide
> the fsid from the sysfs.
> Patch 2 validates the sysfs fsid against the fsid from the sb
> Patch 3 is a test case to make sure if the btrfs filesystem usage is
> successful on a sprout filesystem with a seed device missing.
> 
> Anand Jain (3):
>   common/btrfs: add _require_btrfs_sysfs_fsid helper
>   btrfs/248: validate sysfs fsid
>   btrfs/249: test btrfs filesystem usage command on missing seed device
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
