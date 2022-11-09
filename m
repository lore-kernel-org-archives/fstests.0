Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6511C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Nov 2022 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiKIQCv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIQCt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2022 11:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA81ADB9
        for <fstests@vger.kernel.org>; Wed,  9 Nov 2022 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOi2FGf4rZW4D8n9u2ClcoGsnHVZ0DXtX4Ga2kZ1eHg=;
        b=geAUFKWjLKfVaGpDF3QeKt9eFmmdRLA/e9+VFrXFLGa2iexfYW430ZvoP/GGI7DFr0YByz
        BeFLa+nEfAqG3DPiDggaRl8Au7TaF2zQvFskQ6tMNLdOvF+Wp8uyLFynrI4/t22h7+0RxO
        OhSGAYVn74+/lAw/FVtqa7KOUZeOn34=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-mfX8fySLNJuvFJkypw6LSA-1; Wed, 09 Nov 2022 11:01:50 -0500
X-MC-Unique: mfX8fySLNJuvFJkypw6LSA-1
Received: by mail-pj1-f72.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso7926391pjb.6
        for <fstests@vger.kernel.org>; Wed, 09 Nov 2022 08:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOi2FGf4rZW4D8n9u2ClcoGsnHVZ0DXtX4Ga2kZ1eHg=;
        b=0SDWOvU7eCXyL+VZfoN0sW7y7Vgq0zMmREDcKtBBwdA57ura/Icu98MRfe87HoSAbZ
         kphLoLCxHwwhFP8lGiqEREkKM0a5NcKN1ScE6QdbcjtV2Ctq5FSn7aEcbMnhlACFDXUU
         NUsVCEDLUSzy40eFOzdDgjTiHekrqJdY9CtW03Jlmszn9sEvfZVrLKrea8scCOgunou2
         FCr6UrGMOd9TYXi2iJ2+gNZYoIx6wXmgu4O+B6DjLSOq43+G+aC/egfQxJza0PuTUqnv
         6Vx7Nwn1AXKdR4K6HgOiFJNy3G2mPXaoYAHhJ0MDdtJmsp7PDJSBHzeRfr3Cp4Y4Tzg8
         EGEg==
X-Gm-Message-State: ACrzQf2VWlKfEyiwFGoF2OwmrnaZDCuv22W5qhWFgDX45b+dFk8dMgeZ
        VbmvHqg1jMnK50c1c81hKwwJXY+RxYNFVcwkhLc2jrSnCQCpf80vNT06qjtPUbBeWesbO7qQMe5
        Y17SZPpibdSAP3Xy1ew==
X-Received: by 2002:a17:90b:3b49:b0:213:854f:f796 with SMTP id ot9-20020a17090b3b4900b00213854ff796mr70676670pjb.216.1668009709776;
        Wed, 09 Nov 2022 08:01:49 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7TurAucO3FSB+f65BBCpBZ4eRoeE3A4Hslb7WxEkug9lsZqTkK6+a72U65YxOJgZOkxhV5GA==
X-Received: by 2002:a17:90b:3b49:b0:213:854f:f796 with SMTP id ot9-20020a17090b3b4900b00213854ff796mr70676640pjb.216.1668009709372;
        Wed, 09 Nov 2022 08:01:49 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm9191146plb.276.2022.11.09.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:01:48 -0800 (PST)
Date:   Thu, 10 Nov 2022 00:01:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/3] btrfs: fix failure of tests that use defrag on
 btrfs-progs v6.0+
Message-ID: <20221109160144.rardxaglxxheyp4d@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <d2723c3a1b0205c68f5e62ed5156672d93b2e270.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2723c3a1b0205c68f5e62ed5156672d93b2e270.1667993961.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:36AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs v6.0, the defrag command now prints to stdout
> the full path of the files it processes. This makes test cases btrfs/021
> and btrfs/256 fail because they don't expect any output from the defrag
> command.
> 
> The change happened with the following commit in btrfs-progs:
> 
>   dd724f21803d ("btrfs-progs: add logic to handle LOG_DEFAULT messages")
> 
> So update the tests to ignore the stdout of the defrag command.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/021 | 4 +++-
>  tests/btrfs/256 | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/021 b/tests/btrfs/021
> index 5943da2f..1b55834a 100755
> --- a/tests/btrfs/021
> +++ b/tests/btrfs/021
> @@ -22,8 +22,10 @@ run_test()
>  
>  	sleep 0.5
>  
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
>  	find $SCRATCH_MNT -type f -print0 | xargs -0 \
> -	$BTRFS_UTIL_PROG filesystem defrag -f
> +		$BTRFS_UTIL_PROG filesystem defrag -f > /dev/null
>  
>  	sync
>  	wait
> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> index 1360c2c2..acbbc6fa 100755
> --- a/tests/btrfs/256
> +++ b/tests/btrfs/256
> @@ -50,7 +50,9 @@ $FSSUM_PROG -A -f -w "$checksums_file" "$SCRATCH_MNT"
>  # Now defrag each file.
>  for sz in ${file_sizes[@]}; do
>  	echo "Defragging file with $sz bytes..." >> $seqres.full
> -	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz"
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
> +	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz" > /dev/null
>  done
>  
>  # Verify the checksums after the defrag operations.
> -- 
> 2.35.1
> 

