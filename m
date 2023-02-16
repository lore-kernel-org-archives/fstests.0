Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497EBC61DA4
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Feb 2023 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBPO4A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Feb 2023 09:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBPOz7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2023 09:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B94BEB5
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2023 06:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676559311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZdMZJhZlRdzNah8mkhjB9E+/TqqMjmlQlAR08vbpcc=;
        b=NenH9itLkbi8svAVyrZxyWRjaOcud4sCTOmy4PluxkG1aZz4f1rTABICY4D1HrvuvSSRoh
        ZjsW/33Afq4Pms3emwc9mSfzF/bAa+fnyT35AxIgR5oQ8zPASDn1CcxMxDiYE9pMTPOyd2
        soiwK/GhNUgE8rLV4atYsCjvLoKpQW4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-314-s2DWvn1HMeqldlojuEHCzA-1; Thu, 16 Feb 2023 09:55:10 -0500
X-MC-Unique: s2DWvn1HMeqldlojuEHCzA-1
Received: by mail-pj1-f72.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso1024021pjb.6
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2023 06:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZdMZJhZlRdzNah8mkhjB9E+/TqqMjmlQlAR08vbpcc=;
        b=dYAm6a5F5WHXvipdjdo2hJ80UrGImypFj0T0UxOcNoxLTot2Mqa2Omwl8NSsOGPOt2
         jdmYxacxAwp4Y9ttIqh2bBrJnvf3fSk8go+fxUYrASRfYSqz63E3ibfXQaf0TGE+nG1i
         5xWHi2p2vje8dJ24N03Y/sJ1MT99D01cDXuzWgNkhvM3Jsp6167YSjU5nmbawflKv8FS
         Lz69+/VT4oeyeazWGJ+T6VD4cykyqby3+8O/3ymbrHl6zQpIfZVhAIo22Mt/7JlW38oT
         y1lv4h19rgdRITV32JoLTqMjxuLEAM0LxSVtiEvgP7YXvaiSeULEp/AMd2hmSSUQ9YMG
         uvRQ==
X-Gm-Message-State: AO0yUKWbuDsreHbMGnT0O7C4kTlWI2kWX7IuKghZpci89ZCQo43MPpLm
        ErpWpmRmt27lNPfDWmH2FdLTHAQIbbHens71g6boLq6iNcaZdK/DU3XZSKBtIukEiml9hyC0FAD
        W9rRjdjueSY6lEmXMIA==
X-Received: by 2002:a17:90a:1952:b0:234:b8cb:512b with SMTP id 18-20020a17090a195200b00234b8cb512bmr550336pjh.30.1676559309466;
        Thu, 16 Feb 2023 06:55:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+ULa7euy2EVmVm+cLmTuDqRomERXbJ6OpaGg3eBCnxVPQUfbXtyjeQ2m9IwUDP8urFkutlfQ==
X-Received: by 2002:a17:90a:1952:b0:234:b8cb:512b with SMTP id 18-20020a17090a195200b00234b8cb512bmr550314pjh.30.1676559309063;
        Thu, 16 Feb 2023 06:55:09 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090acc0e00b0023403f9020dsm3358529pju.40.2023.02.16.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:55:08 -0800 (PST)
Date:   Thu, 16 Feb 2023 22:55:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v6] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230216145504.6g7eseh65qxuhimx@zlang-mailbox>
References: <20230111131833.471ada43@echidna.fritz.box>
 <20230215051319.10327-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215051319.10327-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 01:13:19PM +0800, An Long wrote:
> Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
> profeils. For example, skip raid56 as it's not supported.
> 
> For dup profile, add dup to default profile configs.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---

David has given his RVB to V5 patch, so if no other review points, I'll merge
this patch with:

Reviewed-by: David Disseldorp <ddiss@suse.de> 

>  common/btrfs    |  3 +++
>  tests/btrfs/011 | 30 +++++++++++++++++-------------
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ee673a93..6557af86 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -213,6 +213,9 @@ _btrfs_get_profile_configs()
>  			"raid5:raid5"
>  			"raid6:raid6"
>  		)
> +		if [ "$1" == "dup" ]; then
> +			configs+=("dup:dup")
> +		fi
>  	else
>  		# User-provided configurations.
>  		local configs=(${BTRFS_PROFILE_CONFIGS[@]})
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 6c3d037f..852742ee 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -48,6 +48,7 @@ _require_scratch_dev_pool 5
>  _require_scratch_dev_pool_equal_size
>  _require_scratch_size $((10 * 1024 * 1024)) #kB
>  _require_command "$WIPEFS_PROG" wipefs
> +_btrfs_get_profile_configs dup
>  
>  rm -f $tmp.*
>  
> @@ -237,19 +238,22 @@ btrfs_replace_test()
>  	fi
>  }
>  
> -workout "-m single -d single" 1 no 64
> -# Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
> -if ! _scratch_btrfs_is_zoned; then
> -	workout "-m dup -d single" 1 no 64
> -	workout "-m dup -d single" 1 cancel 1024
> -	workout "-m raid0 -d raid0" 2 no 64
> -	workout "-m raid1 -d raid1" 2 no 2048
> -	workout "-m raid10 -d raid10" 4 no 64
> -	workout "-m single -d single -M" 1 no 64
> -	workout "-m dup -d dup -M" 1 no 64
> -	workout "-m raid5 -d raid5" 2 no 64
> -	workout "-m raid6 -d raid6" 3 no 64
> -fi
> +for t in "-m single -d single:1 no 64" \
> +	"-m dup -d single:1 no 64" \
> +	"-m dup -d single:1 cancel 1024" \
> +	"-m raid0 -d raid0:2 no 64" \
> +	"-m raid1 -d raid1:2 no 2048" \
> +	"-m raid10 -d raid10:4 no 64" \
> +	"-m single -d single -M:1 no 64" \
> +	"-m dup -d dup -M:1 no 64" \
> +	"-m raid5 -d raid5:2 no 64" \
> +	"-m raid6 -d raid6:3 no 64"; do
> +	mkfs_option=${t%:*}
> +	workout_option=${t#*:}
> +	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
> +		workout "$mkfs_option" $workout_option
> +	fi
> +done
>  
>  echo "*** done"
>  status=0
> -- 
> 2.35.3
> 

