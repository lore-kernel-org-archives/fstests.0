Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA6C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Nov 2022 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKIP4P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiKIP4N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2022 10:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB6111C36
        for <fstests@vger.kernel.org>; Wed,  9 Nov 2022 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28Ccszi1P3T+ZnzNRGtbuUBqePx/ieU7H+4uG5/z258=;
        b=SwPbfBQSg/XJL7RBskNLsmbHOPFWcTujvKF9GhXctPPdIhPBOyMltgtmkKJrzyJwqas9sN
        fZsTJyWZX7KD94j0DjxbQsWdwncYU2mjTTckPIXjhSwbHGXnLdbJBB31207afrzloSUp5U
        Sg/Ze7i30o2b6U2QioN5kRfl3ZhERNw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-V22ICRvbOaC43dIyvOGfhQ-1; Wed, 09 Nov 2022 10:55:12 -0500
X-MC-Unique: V22ICRvbOaC43dIyvOGfhQ-1
Received: by mail-pg1-f198.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so9645457pgl.8
        for <fstests@vger.kernel.org>; Wed, 09 Nov 2022 07:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Ccszi1P3T+ZnzNRGtbuUBqePx/ieU7H+4uG5/z258=;
        b=6Nc9NwFn4jDh+DXYHpRlJyfmaoW5j6jJrA1ZVC+Chw2fK0b1ANX9fvMp/sj2y819gK
         pi0egBXhv4BcTxTWnv0fM3MhCygpAax+JTSjk9ga8A2b28+PjdfonhGdSJTbnCFqFBpq
         Dzaq8b2kv3MCk20ZjBqP29SvBsk+WN1thMWjmE2KmBuBG4RBoFhYV4eQr1Wgz1mkx1WD
         ykgwCouBslG/Me7wCK8F0MZt7v5hvPNZ/ivI5rh/nb7LDb0owR/XHNpVAnW1kWf2YT2p
         kiKemdA6UKo6WQdUAQVTUEwVZa9mNB2nM+AOf3GH6/U+dpsdKN964QtDE+e3rcQQXY6w
         KXlg==
X-Gm-Message-State: ACrzQf0sB4JQwT2K5Qq0+n+IcxH88zqU2V+hZhL35azaIUBP58PsbKRf
        wl++Hd6nkdRQMWwsfc4pdrSe9ip8kv3SKvef1wocVFow4HIUacJUFILWmHpmSN+HzmYKaNOQ+wi
        wSxkSUWZKtlSmHvtVEQ==
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr79970466pjz.144.1668009310517;
        Wed, 09 Nov 2022 07:55:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5JDa2W97WzCL9+HYj081LXkyOo8bMu+bLtxofTCA9SZ2GG3DFor+tz0J4k30ndtuPSd6uPyw==
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr79970451pjz.144.1668009310223;
        Wed, 09 Nov 2022 07:55:10 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001fe39bda429sm1375608pjg.38.2022.11.09.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:55:09 -0800 (PST)
Date:   Wed, 9 Nov 2022 23:55:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] btrfs/053: fix test failure when running with
 btrfs-progs v6.0+
Message-ID: <20221109155505.yki6xwqk4p4mhky6@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:35AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs-progs v6.0 the --leafsize (-l) command line option was removed,
> so btrfs/053 always fails with v6.0+.
> 
> The change was introduced by the following btrfs-progs commit:
> 
>   f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")
> 
> Change the test to use --nodesize (-n) instead, since it exists in both
> old and new btrfs-progs versions.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/053 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/053 b/tests/btrfs/053
> index fbd2e7d9..c0446257 100755
> --- a/tests/btrfs/053
> +++ b/tests/btrfs/053
> @@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
>  rm -fr $send_files_dir
>  mkdir $send_files_dir
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1

We you said this case starts to fail on btrfs-progs v6.0, I'm wondering how it
fail (I don't doubt it fails), at least not fails at here right?

Actually I recommend mkfs output to .full file at here, especially when you use
specified mkfs options to _scratch_mkfs helper. That really might fail, and
the case might keep running (with old fs on SCRATCH_DEV), and we hard to notice
that if no message output and no return value checking.

The _scratch_mkfs doesn't _fail if it fails, it just return nonzero and output
error message. So generally I recommend writting likes this (or other proper way
which can detect mkfs failure):

  _scratch_mkfs "--nodesize $leaf_size" >>$seqres.full 2>&1 || _fail "mkfs failed"

especially if there's specified mkfs options.

Thanks,
Zorro

>  _scratch_mount
>  
>  echo "hello world" > $SCRATCH_MNT/foobar
> @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
>  _scratch_unmount
>  _check_scratch_fs
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
>  _scratch_mount
>  
>  _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> -- 
> 2.35.1
> 

