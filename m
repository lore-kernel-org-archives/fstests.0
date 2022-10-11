Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F52C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 13:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJKN5F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJKN5F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 09:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584A8A1D0
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665496621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mHIWcLJcuFzKyDfOzGZAyY0Sq5ZgGQGzYlm0xYrvX0=;
        b=VmLpZbupSj16MJa97oXmRxbzxaCHH0IDw7xraJ8jpgJhz90axb9LZl4yqWc9Dsjm3ewLae
        ks1STG2Z2ENodzojAIojWJ4UC+qJQPSRIyMeUGOeobvm+nFmz3HVHAjpW5V06LYOMUDgk9
        Z1V21al+tu4OblKvtqBh0fTtg9Fb+0w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-emTzzsHWM2GKFZCETHshlw-1; Tue, 11 Oct 2022 09:56:59 -0400
X-MC-Unique: emTzzsHWM2GKFZCETHshlw-1
Received: by mail-qv1-f70.google.com with SMTP id cy11-20020a05621418cb00b004b17b3cf429so7919173qvb.6
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 06:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mHIWcLJcuFzKyDfOzGZAyY0Sq5ZgGQGzYlm0xYrvX0=;
        b=4QueFeCRAczvFirqhseKLnkem0seRmYkJ3rafvbCyZh6gSX6ykLsS86uFfoMpOl3WG
         XUDfOBNB4Y5iPlRNCWd40AkbwGH1Lbii7oNbnzMt+2NCWVMS2fNrmlV/6wBZrvMNAkGV
         /jjM1e6+QFQra2+fygbNmd2QcBX11b+JiqN6atF4N2AU0+lM0Z9jPpB5ccultWkuevlE
         7cUuSTGX/bql5JMMUNra4aseOQCkjhVkK/ftLnYROa/5Tbkc0TnWSYbpwifHQD26EEFw
         OMwUPMQxg1V74MdWqx8NJpCti3uTupqk735OrD2zyqrneVJbnx0/iQ+Ys+Qyrgn+rigI
         5Rdg==
X-Gm-Message-State: ACrzQf11oUMp7Fss5/53nsvQ3hTIKf2qEQGUSJVnEtROFMP65EPBuWA/
        rk5G3MbQ8hXuWQLa89ri5ro0I0HAtwyIclmwhq3721u/qR4fa5TlLAkrRK55+5vBiW6xfihfL4s
        G3OF7JSFIWkHyOrGvZQ==
X-Received: by 2002:a05:6214:d08:b0:4b1:7127:f615 with SMTP id 8-20020a0562140d0800b004b17127f615mr19203958qvh.92.1665496619537;
        Tue, 11 Oct 2022 06:56:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kd8mWSIB5jIu7wHgeuz2NSrCnZWG5XNeKD1BEPyHCZAzIpvCn7isu2ye6KZ7Hi8MQSieKZw==
X-Received: by 2002:a05:6214:d08:b0:4b1:7127:f615 with SMTP id 8-20020a0562140d0800b004b17127f615mr19203945qvh.92.1665496619309;
        Tue, 11 Oct 2022 06:56:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ee74cc976esm3156201qkp.70.2022.10.11.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:56:58 -0700 (PDT)
Date:   Tue, 11 Oct 2022 21:56:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] fstests: add missing require of xfs_io fiemap
 command to some tests
Message-ID: <20221011135654.zc6vrfvjqqmanpao@zlang-mailbox>
References: <cover.1665150613.git.fdmanana@suse.com>
 <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:35PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/257, btrfs/258, btrfs/259 and xfs/443 use the fiemap command of
> xfs_io but don't do a '_require_xfs_io_command "fiemap"'. So add the
> missing requirement.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/257 | 1 +
>  tests/btrfs/258 | 1 +
>  tests/btrfs/259 | 1 +
>  tests/xfs/443   | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> index 3092495f..87f9e0b2 100755
> --- a/tests/btrfs/257
> +++ b/tests/btrfs/257
> @@ -33,6 +33,7 @@ _require_btrfs_no_compress
>  # Needs 4K sectorsize
>  _require_btrfs_support_sectorsize 4096
>  _require_xfs_io_command "falloc"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs -s 4k >> $seqres.full 2>&1
>  
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index da073333..be61d039 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -17,6 +17,7 @@ _begin_fstest auto defrag quick
>  # Modify as appropriate.
>  _supported_fs generic
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  # Needs 4K sectorsize, as larger sectorsize can change the file layout.
>  _require_btrfs_support_sectorsize 4096
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index 92d0b9a6..36f499f9 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -18,6 +18,7 @@ _begin_fstest auto quick defrag
>  # Modify as appropriate.
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs >> $seqres.full
>  
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index f2390bf3..de28b85b 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -30,6 +30,7 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "swapext"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  _scratch_mount
> -- 
> 2.35.1
> 

