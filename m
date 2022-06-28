Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC0C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 04:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiF1EjV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiF1EjV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 00:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E07E315A37
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656391159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N63lhmc2w1byUeJR1mcg+9ZFkKfh0XHh2NeSYzU8iqM=;
        b=JHpkU7dJ4IPNStoKQO9fl1usWuOwMeqeqfahD46kAYhsC2PEuKckeEpp+KuS8zVljtSr4Z
        w3sL9Lm3bbTO7LMea82BmwegrZZooE7jJLiOF8J9cRXSyjxeyIvO/jAA78A73hXbhOyj7e
        K1s3bGI9TRui9RrWjzf/0G1tzYmJnTY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-6ZoTj4UNNKiftyUX0OMg2w-1; Tue, 28 Jun 2022 00:39:16 -0400
X-MC-Unique: 6ZoTj4UNNKiftyUX0OMg2w-1
Received: by mail-qk1-f200.google.com with SMTP id bi36-20020a05620a31a400b006a79f0706e5so12191924qkb.2
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N63lhmc2w1byUeJR1mcg+9ZFkKfh0XHh2NeSYzU8iqM=;
        b=s1pYLWNoEsylmtaAwmdvizCNNrTMtGc+bDxsLRZyslv6g/Ur8SljHYs2CNpHV5cIq/
         ZceWGlt7ZxWcNuAjObYJ5pa3S2Cs7OCJex7dIdvesAk0+gGn+z6bimJscQkI/gSgBH7f
         HUee5kebYh3l/qtbHoRlw6vakqyrFaENjlqZ8YsaZ8XJ4SImCH9mZILsE3F4AqTPsTd8
         EfzMHWBXLnn1aFmq0eaAD3SReRPtGUL4AH9rYHOg5/aS58zPQhTCssAG+v73A2/0PLaq
         ZMHrUeA+i7iVzTH+O7tE5gupsU8/MB56TxZypMCTDOE+cQadWrCJWTVUjWpWnklz2cN1
         JaRw==
X-Gm-Message-State: AJIora/rGU8yfAZ7DCHQ/JIR+6D8HmA6urWwGgYIGxby0gugTH3j3S3O
        KSkSVnLR4stM7X7P4in+cKehUUezLha4SK9Ywl9PdDL0CFKJ0oPa1tPE8HOiR/1ixP6VLxpBUTi
        CqtgFuIEr2PyiAt802A==
X-Received: by 2002:a05:620a:410e:b0:6a7:6c53:108e with SMTP id j14-20020a05620a410e00b006a76c53108emr10186143qko.119.1656391155442;
        Mon, 27 Jun 2022 21:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uGgAZnbtNlvEIgPce1zGP0/tRarW1fxeB3jyeitCVenKj3Q5hTWfWgU1Fh28x75O32hk2MIQ==
X-Received: by 2002:a05:620a:410e:b0:6a7:6c53:108e with SMTP id j14-20020a05620a410e00b006a76c53108emr10186133qko.119.1656391155177;
        Mon, 27 Jun 2022 21:39:15 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a0c4d00b006a71398f06fsm10504445qki.32.2022.06.27.21.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:39:14 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:39:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] ext4/054: skip test if the dax mount option is
 enabled
Message-ID: <20220628043909.m6plhgsn55jmddk4@zlang-mailbox>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-5-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625030718.1215980-5-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 11:07:17PM -0400, Theodore Ts'o wrote:
> The ext4/054 test explicitly creates a file system with a 1k
> blocksize.  This can't possibly work on if the dax mount option is
> enabled, so change ext4/054 to use _scratch_mkfs_blocksized, and and a
> check to _scratch_mkfs_blocksized to _notrun the test if the block
> size is less than the page size.
> 
> Also remove an unnecessary _require_test declaration since this test
> does not use the test device.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc      | 3 +++
>  tests/ext4/054 | 5 ++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 9378ff26..3014f5fc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1220,6 +1220,9 @@ _scratch_mkfs_blocksized()
>  	if ! [[ $blocksize =~ $re ]] ; then
>  		_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
>  	fi
> +	if [ $blocksize -lt $(get_page_size) ]; then
> +		_exclude_scratch_mount_option dax
> +	fi
>  
>  	case $FSTYP in
>  	btrfs)
> diff --git a/tests/ext4/054 b/tests/ext4/054
> index 9a11719f..e23acbb1 100755
> --- a/tests/ext4/054
> +++ b/tests/ext4/054
> @@ -19,7 +19,6 @@ _begin_fstest auto quick dangerous_fuzzers
>  
>  # real QA test starts here
>  _supported_fs ext4
> -_require_test
>  _require_scratch_nocheck
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "pwrite"
> @@ -28,8 +27,8 @@ _require_xfs_io_command "fpunch"
>  _require_command "$DEBUGFS_PROG" debugfs
>  
>  # In order to accurately construct the damaged extent in the following
> -# test steps, the blocksize is set to 1024 here
> -_scratch_mkfs "-b 1024" > $seqres.full 2>&1
> +# test steps, the block size is set to 1024 here
> +_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
>  _scratch_mount
>  
>  TEST_FILE="${SCRATCH_MNT}/testfile"
> -- 
> 2.31.0
> 

