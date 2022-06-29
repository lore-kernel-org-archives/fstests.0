Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D6EC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 08:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiF2I61 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF2I6Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 04:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8128C9FFA
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656493102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ju7ZLI/iK/NXt4WScnIRGw7IgYvVKrHI33cMGAhcnHg=;
        b=fb4FL/hteBNPSTTLITvfqmCL37c54ncAIoz1uXzgqiQHESFJprvZs/Vrwo0BiWy4cgDsXs
        GEXVYUBxF1/Qj15Db5j9yofbSMwa0K6kNhDzA92kc/sIMZMDi2NqMFsa0VIslsVzBi+25G
        +kqo/kJyUDo9AVdVwU7o49YKFpp6Gwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-8B6LRQ0xPJGbacvYtrHc9g-1; Wed, 29 Jun 2022 04:58:21 -0400
X-MC-Unique: 8B6LRQ0xPJGbacvYtrHc9g-1
Received: by mail-qk1-f199.google.com with SMTP id e128-20020a376986000000b006af6adf035cso3109200qkc.8
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 01:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ju7ZLI/iK/NXt4WScnIRGw7IgYvVKrHI33cMGAhcnHg=;
        b=6/ayW+bThwnXq28nSIe0RmfgM1H1KhbY5MpEfnkhMQVwiYceKq67xcr8+6I5wEE5Lx
         /cUKK9j5O6FZoelQOWhnri6CI2CsZXIcd30Eahu+rpTBxYA2hunE29vK3EMcK6GEMwdy
         KTYY9HXQWFKVheDGHZC6vZkX+cZex4ux9gMiLS21Vf/inhtBdcIOuWOa6SwD1ZXypI7W
         6cdD7UOUPGSjSGpoG/g8GuT2X5s66meknr0i6VDi8SYNxcu0LJCTklGzXogmjWusTw00
         RQNW5MmSlB+L5PcrCBrXXvk5z8A7VibAxOiVrkA7C8sq+eoXrKafQjHYAkoG1qnQ5Css
         0kAw==
X-Gm-Message-State: AJIora/2W521hY/POCqjaXaG8jUXVmaVFoQVAa86FsazTWY0cB3nCyrs
        rxRGAV9Jl/Leb6uLF8cfJqke7M39u6gtliui+Qx7NslkMAT8Yzc/6wXXjruyie4j6U5fg49R/Cb
        0f/zq2UctJx9ODccCUw==
X-Received: by 2002:ac8:5953:0:b0:317:cfd0:1a72 with SMTP id 19-20020ac85953000000b00317cfd01a72mr1450040qtz.483.1656493100097;
        Wed, 29 Jun 2022 01:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5K7TRvhobRrYUDZC13/4XmI2giPX+/o5y2PDyTHLHZOOybmPbSPpcuzWl7CCMc88X8NhOWw==
X-Received: by 2002:ac8:5953:0:b0:317:cfd0:1a72 with SMTP id 19-20020ac85953000000b00317cfd01a72mr1450032qtz.483.1656493099814;
        Wed, 29 Jun 2022 01:58:19 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c3-20020ac84e03000000b00304f55e56e4sm10416373qtw.40.2022.06.29.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:58:19 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:58:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] ext4: create file systems with the enrypt feature if
 necessary
Message-ID: <20220629085814.msgubmmpcstasrhp@zlang-mailbox>
References: <20220628182545.1834145-1-tytso@mit.edu>
 <20220628182545.1834145-7-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628182545.1834145-7-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 02:25:45PM -0400, Theodore Ts'o wrote:
> The linux kernel commit 5f41fdaea63d ("ext4: only allow
> test_dummy_encryption when supported") the kernel will reject mounts
> with the test_dummy_encryption option if the ext4 file system does not
> have the encrypt feature enabled.
> 
> There are a handful of tests (ext4/003, ext4/035, ext4/306, and
> generic/260) which will format the scratch file system using a
> hard-coded set of mkfs.ext4 parameters ignoring the MKFS_OPTION that
> is set by the file system test config.
> 
> For file system config that includes test_dummy_encryption in
> MOUNT_OPTIONS and "-O encrypt" in MKFS_OPTIONS, we need to test for
> test_dummy_encryption and force the hard-coded mkfs options to enable
> the encrypt feature.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/003    | 6 +++++-
>  tests/ext4/035    | 5 ++++-
>  tests/ext4/306    | 3 +++
>  tests/generic/260 | 5 ++++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/ext4/003 b/tests/ext4/003
> index 773bcb03..6a4518e3 100755
> --- a/tests/ext4/003
> +++ b/tests/ext4/003
> @@ -27,7 +27,11 @@ _require_scratch
>  _require_scratch_ext4_feature "bigalloc"
>  
>  BLOCK_SIZE=$(get_page_size)
> -$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
> +FEATURES=bigalloc
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    FEATURES=${FEATURES},encrypt
> +fi
> +$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O ${FEATURES} -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
>  	>> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/ext4/035 b/tests/ext4/035
> index 1f26e766..a1ccce45 100755
> --- a/tests/ext4/035
> +++ b/tests/ext4/035
> @@ -25,7 +25,10 @@ _require_scratch
>  _exclude_scratch_mount_option dax
>  _require_command "$RESIZE2FS_PROG" resize2fs
>  
> -$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    ENCRYPT="-O encrypt"
> +fi
> +$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $ENCRYPT $SCRATCH_DEV 32768 >> $seqres.full 2>&1
>  if [ $? -ne 0 ]; then
>      _notrun "Can't make file system with a block size of 1024"
>  fi

This _notrun part isn't in mainline fstests. That cause merging aborted
at here :)

Thanks,
Zorro

> diff --git a/tests/ext4/306 b/tests/ext4/306
> index 2ff88537..a6b7eab5 100755
> --- a/tests/ext4/306
> +++ b/tests/ext4/306
> @@ -33,6 +33,9 @@ features="^extents"
>  if grep -q 64bit /etc/mke2fs.conf ; then
>      features="^extents,^64bit"
>  fi
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    features=${features},encrypt
> +fi
>  
>  blksz=$(get_page_size)
>  
> diff --git a/tests/generic/260 b/tests/generic/260
> index b4d72e0f..e86afe9c 100755
> --- a/tests/generic/260
> +++ b/tests/generic/260
> @@ -120,7 +120,10 @@ case $FSTYP in
>  		bsize=4096
>  		start=$(_math "$base*$agsize*$bsize")
>  		len=$start
> -		export MKFS_OPTIONS="-F -b $bsize -g $agsize"
> +		if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +		    ENCRYPT="-O encrypt"
> +		fi
> +		export MKFS_OPTIONS="-F -b $bsize -g $agsize $ENCRYPT"
>  		;;
>  	xfs)
>  		agsize=65538
> -- 
> 2.31.0
> 

