Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CF6C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiF2NbF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiF2NbE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 09:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 905AB36B54
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656509461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2uyBTxeBOQvgDWroiYic1nlR2+haf7sz9R1Uf0Y0qg=;
        b=DkcR+/gkCebDggqfuqBWL1+RPYQxwW0MaH+3wZUVPT8CwXupJHjkR7skNd1ye8thiHxq+T
        6g2YUak1pO3CAOEOnK2DfWZoPRpOprFMyUIaiaQE05D13j3DFT7/XcaPZVqTBKxjzyA104
        oiVpHtfKhFUx5s4uHZBLJ3U3brAa7gQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-Rntlx-kENxKNcM2DR7-a_Q-1; Wed, 29 Jun 2022 09:30:59 -0400
X-MC-Unique: Rntlx-kENxKNcM2DR7-a_Q-1
Received: by mail-qk1-f198.google.com with SMTP id bi36-20020a05620a31a400b006a79f0706e5so16225389qkb.2
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O2uyBTxeBOQvgDWroiYic1nlR2+haf7sz9R1Uf0Y0qg=;
        b=q4aC8qH7RW3qpI1k3RzPHPD3YMyoTVu8lODl3DJKIBGLkt3fw76UrWDFBNbd/XuT7F
         5RQ3Lde72/5JecuEtBXE8gx/1qNwbtcdsfBNa4Ovev7woNw295mPc3RWXjj7bdmNaVk3
         bMd1RvY69E2Srwt2pcpeWzN3wsaHXo1jqgZN0s1Zm3t0YjSufECo49Uti40fMWIiFYAb
         bKjA1hQVtJ2FhiTi4Y27LPnfWY9jrgf/C5iJTEkTT8fqfy0EiNlXLD1M1S+ynUlJRm9C
         odQC7bO5HSLtq2Q0A6OvQ7qG1TMFesB4PWox8LtnTC5qiQKKZcljMKl/QL4bWphOdm82
         YNnw==
X-Gm-Message-State: AJIora/wacsbQ1dH8wcasNBKl1scQ/Xy0BN8odF6EIijZkxhSS4wJ39L
        oISsaL/4z1xKy/5l0i2OAVptKSjSwhjS+bWUyizlEf/55z2SwvFtFGrSGeJ6zM8p9t3GUk8Z28Z
        kHqmljIx3oId8R6j1FQ==
X-Received: by 2002:a05:620a:785:b0:6af:2743:d342 with SMTP id 5-20020a05620a078500b006af2743d342mr2056350qka.260.1656509458620;
        Wed, 29 Jun 2022 06:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9jd5++EihLwKyK/4NllzetwMFeMzJdBCRBdjjGIfuUCdGyAe4rsdLEwyUzvNq3bwTz3cXMg==
X-Received: by 2002:a05:620a:785:b0:6af:2743:d342 with SMTP id 5-20020a05620a078500b006af2743d342mr2056299qka.260.1656509458156;
        Wed, 29 Jun 2022 06:30:58 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id de11-20020a05620a370b00b006a5d8d96681sm12014551qkb.100.2022.06.29.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:30:57 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:30:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH -v3 7/7] ext4: create file systems with the encrypt
 feature as necessary
Message-ID: <20220629133052.3knyrselanytvrws@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-8-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629124540.175775-8-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 08:45:40AM -0400, Theodore Ts'o wrote:
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
> For file system configs which includes test_dummy_encryption in
> MOUNT_OPTIONS and "-O encrypt" in MKFS_OPTIONS, we need to test for
> test_dummy_encryption and force the hard-coded mkfs options to enable
> the encrypt feature.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

This patch makes sense to me. 

Reviewed-by: Zorro Lang <zlang@redhat.com>

As Eric gave some review points to V2, so double check with Eric, if it's good
to him?

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

