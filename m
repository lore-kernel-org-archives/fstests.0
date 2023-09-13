Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DFCA553C
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Sep 2023 16:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjIMQjD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Sep 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjIMQjC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Sep 2023 12:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D7C19A7
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694623094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEz5bCFA1d9MnTu248AmU6Q9265Ke5K8aWslSCsXYDI=;
        b=euzLoVQ6nnYzEEpSC20pvknBHysRbpiqYwtP8jB4fJbQZ5CNFh6PKfSATEilOnsf7lQ4ds
        PGqPv2cDuMrF3zi45S1f9IOIjqGeSVxVcoLj/+NeCUdrVfApe85GV/E5P6N43qCsSQBycV
        8d5XrsRlfWt8L2vfXn280yGXH2JMPxc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ryHq4dLXOfeuxx3JrJcHow-1; Wed, 13 Sep 2023 12:38:13 -0400
X-MC-Unique: ryHq4dLXOfeuxx3JrJcHow-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf39e73558so102020155ad.2
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623091; x=1695227891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEz5bCFA1d9MnTu248AmU6Q9265Ke5K8aWslSCsXYDI=;
        b=qDWmfTLWx5tT1LCYdGK+S7CWOEvMfvdq4cBo/s8d1Nx7y57Kf38urDCgJsUUnHT71K
         Hc4YTSN2rg0nHB1XP2HzhSIm2qb2HQ85q1cQeazmaSykCVYEvCz3Pn4p6Mjp9rOPV1/Z
         BkaoDeskYzTO2WSq7YEBImh1a5+KA78k9qiqOvOinsrPvmotkN4fNJ+LWYNgPjZwx/lj
         I4p6K8A8jaNm2aZwUq8ixrjgcuUwYQOV/CU8YKJmXD7UZFxLY5OirImwsX2S/Z08RnD5
         HDAgDw7gOuJTufcTjvne1T3NYSTZCyvkUzVL6tvy9Ulw7OGwGSXp/T6rSTG885SDRXrO
         eDUw==
X-Gm-Message-State: AOJu0YzOpW8FLT5MGKtImiS7bnzEKPLze8n+zeHGnDn4ssXaWIW6Dip2
        o5zKVpCyHfFzwrZDfcA1Zh3K6NgHIqHZ8x6DdwgYiY9xJ7MeNCM5l/ar77cHJs8tiSU865wzfDs
        g+TYqCjlofZmfqGFluW9Qmr+4dvOx2PE=
X-Received: by 2002:a17:903:491:b0:1c3:9544:cf51 with SMTP id jj17-20020a170903049100b001c39544cf51mr3178642plb.1.1694623091643;
        Wed, 13 Sep 2023 09:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtT6qhUWqe9oFbH8qfZTBjuw3T/V3gVvlPH6hP40UqiOzZIOXDjXvG+pAaQV6R3UEj7D4lGg==
X-Received: by 2002:a17:903:491:b0:1c3:9544:cf51 with SMTP id jj17-20020a170903049100b001c39544cf51mr3178631plb.1.1694623091335;
        Wed, 13 Sep 2023 09:38:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b86e17ecacsm10648375plf.131.2023.09.13.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:38:10 -0700 (PDT)
Date:   Thu, 14 Sep 2023 00:38:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/261 fix failure if /var/lib/btrfs isn't
 writable
Message-ID: <20230913163807.qn3dp57gzn76vbxz@zlang-mailbox>
References: <3e6b018ef39babe84d3a307e547b480b4834c4e1.1693312220.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6b018ef39babe84d3a307e547b480b4834c4e1.1693312220.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 29, 2023 at 08:34:06PM +0800, Anand Jain wrote:
> We don't need scrub status; it is okay to ignore the warnings due to
> the readonly /var/lib/btrfs if any. Redirect stderr to seqres.full.
> We check the scrub return status.
> 
>     +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.42fad803-d505-48f4-a04d-612dbf8bd724: Read-only file system. Progress cannot be queried
>     +WARNING: failed to write the progress status file: Read-only file system. Status recording disabled
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/261 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> index b33c053fbca0..50173de351f3 100755
> --- a/tests/btrfs/261
> +++ b/tests/btrfs/261
> @@ -68,7 +68,9 @@ workload()
>  	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
>  
>  	# Make sure above scrub fixed the fs
> -	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
> +	# Redirect the stderr to seqres.full as well to avoid warnings if
> +	# /var/lib filesystem is readonly, as scrub fails to write status.
> +	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>  	if [ $? -ne 0 ]; then
>  		echo "scrub failed to fix the fs for profile $mkfs_opts"
>  	fi
> -- 
> 2.39.3
> 

