Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FDC433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jun 2022 04:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiFFEFo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jun 2022 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFFEFo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jun 2022 00:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CA034B9B
        for <fstests@vger.kernel.org>; Sun,  5 Jun 2022 21:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654488339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXIzc9zVWI0tuX5YUpb2WS0HvfmJvHBn10RNWUgHUso=;
        b=NoogiEJirlSrtgEYT8BJ4PcFiY757v/z8WDVnWtWOADNG/EwBK8FMX1xBnXgMnik5plmzX
        FAk5FkPwVpv6r5K59gp9y+trUGOy2w3CXwn0XcOxYfCX+6TLazcnwFCWZ57Fts6Df9JVJt
        SFbv/7ulJ96YUQ9ZqhYi39IuHLJJeuE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-L_nqsBkWMIGdBoot_HeXGA-1; Mon, 06 Jun 2022 00:05:38 -0400
X-MC-Unique: L_nqsBkWMIGdBoot_HeXGA-1
Received: by mail-qk1-f199.google.com with SMTP id h16-20020a05620a401000b006a6b8ac9c64so1726278qko.8
        for <fstests@vger.kernel.org>; Sun, 05 Jun 2022 21:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hXIzc9zVWI0tuX5YUpb2WS0HvfmJvHBn10RNWUgHUso=;
        b=uWDQK+QkwBbcVSZy+3J4FeIiQPNqNKCBi/2i08HK8LKJWV6d183gfd5l+W1zeXpKqi
         o9botJMWNW8IzMtVop7pv/3oqcGgL/3n0XddRc3biRjszo9H7eTvx7SeCsV1ftHVBBZ5
         LIoHGm0PQ2KMeaZfl+u/wz7xzvygzssCMp7nn45qTjF+gFSKx/+J4CpG1yuljE9lhEmZ
         dJVG51H6EMxa9OO/xtBhettvgSAEPVxU+ZYq0zDeAwk1lwVABoIqu8bgAHf5ZqhSsxHr
         XbViZ2Q0sD5Sfm0fESjPArw+SoQwsRA0TpO76x8+CLES1dRyp34+oz5oYwC3nIVifbID
         TcDw==
X-Gm-Message-State: AOAM533xRxqZMt0QJZezhjqkvqz2BN+ufNMPVYantcsVmrzl4P/C8Pk8
        lArFLqmW2qL5nrcDbU76zQTnPtzXGB7B1qOdBJzr3cU0HKgwLG27acn8bqM3X5oRlGhnMJwNTnG
        dicJXxLiAZLj3UTm7Os1D3nbLzQGxGfR2zEVFEZLnFt0n0RnnERP0D4etRSbpjZA0lw==
X-Received: by 2002:a37:8d46:0:b0:6a6:48c7:8632 with SMTP id p67-20020a378d46000000b006a648c78632mr14145869qkd.633.1654488337527;
        Sun, 05 Jun 2022 21:05:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9irx4+jM8wocjqvqYV04uuT5c66HtHmf+2wlDvLDWR9DKwSQUMEIAwYAHV9rJxX4tRI981A==
X-Received: by 2002:a37:8d46:0:b0:6a6:48c7:8632 with SMTP id p67-20020a378d46000000b006a648c78632mr14145859qkd.633.1654488337117;
        Sun, 05 Jun 2022 21:05:37 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a13ec00b0069fc13ce20asm3330457qkl.59.2022.06.05.21.05.35
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 21:05:36 -0700 (PDT)
Date:   Mon, 6 Jun 2022 12:05:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/filter: filter out extra mount error output
Message-ID: <20220606040531.xo5ptknj7gjtyyud@zlang-mailbox>
References: <20220527121115.34358-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527121115.34358-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 08:11:15PM +0800, Zorro Lang wrote:
> The lastest mount command (from util-linux) merged below commit:
>   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> which brought in a new error output when mount fails, no matter
> ro/rw/busy mount fails.
> 
> That cause some cases (e.g. xfs/005) fail as:
>   mount: Structure needs cleaning
>          dmesg(1) may have more information after failed mount system call
> 
> More failed cases like generic/050, ext4/002, xfs/154, xfs/158 etc.
> Especially xfs/154 and xfs/158, need to change their _filter_scratch
> to _filter_error_mount.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Thanks the review points from Dave. This V2 turn to filter out the error in
> _filter_error/ro/busy_mount. And change xfs/154 and xfs/158 to use
> _filter_error_mount.

Ping, hope to get review :)

> 
> Thanks,
> Zorro
> 
>  common/filter     | 13 +++++++++++--
>  tests/xfs/154     |  2 +-
>  tests/xfs/154.out |  2 +-
>  tests/xfs/158     |  2 +-
>  tests/xfs/158.out |  2 +-
>  5 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index a6a42b7a..14f6a027 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -380,6 +380,8 @@ _filter_ending_dot()
>  # ancient:	   mount: cannot remount block device <device> read-write, is write-protected
>  # prior to v2.30:  mount: cannot remount <device> read-write, is write-protected
>  # v2.30 and later: mount: <mountpoint>: cannot remount <device> read-write, is write-protected.
> +# v2.38 and later:
> +# dmesg(1) may have more information after failed mount mount system call
>  #
>  # Now use _filter_ro_mount to unify all these differences across old & new
>  # util-linux versions. So the filtered format would be:
> @@ -412,7 +414,8 @@ _filter_ro_mount() {
>  		print "mount: cannot remount device read-write, is write-protected\n";
>  	} else {
>  		print "$_";
> -	}' | _filter_ending_dot
> +	}' | grep -v "dmesg(1) may have more information after failed mount" | \
> +	_filter_ending_dot
>  }
>  
>  # Filter a failed mount output due to EUCLEAN and USTALE, util-linux changed
> @@ -424,6 +427,8 @@ _filter_ro_mount() {
>  # mount: mount <device> on <mountpoint> failed: Structure needs cleaning
>  # v2.30 and later:
>  # mount: <mountpoint>: mount(2) system call failed: Structure needs cleaning.
> +# v2.38 and later:
> +# dmesg(1) may have more information after failed mount mount system call
>  #
>  # This is also true for ESTALE error. So let's remove all the changing parts
>  # and keep the 'prior to v2.21' format:
> @@ -431,7 +436,8 @@ _filter_ro_mount() {
>  # mount: Stale file handle
>  _filter_error_mount()
>  {
> -	sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
> +	grep -v "dmesg(1) may have more information after failed mount" | \
> +		sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
>  }
>  
>  # Similar to _filter_error_mount, filter a busy mount output.
> @@ -440,8 +446,11 @@ _filter_error_mount()
>  # old: mount: <device> is already mounted or <mountpoint> busy
>  # new: mount: <mountpoint>: <device> already mounted or mount point busy.
>  # filtered: mount: device already mounted or mount point busy
> +# v2.38 and later, filter out:
> +# dmesg(1) may have more information after failed mount mount system call
>  _filter_busy_mount()
>  {
> +	grep -v "dmesg(1) may have more information after failed mount" | \
>  	sed -e "s/.*: .* already mounted or .* busy/mount: device already mounted or mount point busy/" | \
>  		_filter_ending_dot
>  }
> diff --git a/tests/xfs/154 b/tests/xfs/154
> index 3f90a397..548c9490 100755
> --- a/tests/xfs/154
> +++ b/tests/xfs/154
> @@ -48,7 +48,7 @@ test $? -eq 137 || echo "repair should have been killed??"
>  _check_scratch_xfs_features NEEDSREPAIR
>  _try_scratch_mount &> $tmp.mount
>  res=$?
> -_filter_scratch < $tmp.mount
> +_filter_error_mount < $tmp.mount
>  if [ $res -eq 0 ]; then
>  	echo "Should not be able to mount after needsrepair crash"
>  	_scratch_unmount
> diff --git a/tests/xfs/154.out b/tests/xfs/154.out
> index 12f154ab..1263f091 100644
> --- a/tests/xfs/154.out
> +++ b/tests/xfs/154.out
> @@ -1,4 +1,4 @@
>  QA output created by 154
>  FEATURES: NEEDSREPAIR:YES
> -mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
> +mount: Structure needs cleaning
>  FEATURES: NEEDSREPAIR:NO
> diff --git a/tests/xfs/158 b/tests/xfs/158
> index 505a9c73..4440adf6 100755
> --- a/tests/xfs/158
> +++ b/tests/xfs/158
> @@ -51,7 +51,7 @@ test $? -eq 137 || echo "repair should have been killed??"
>  _check_scratch_xfs_features NEEDSREPAIR INOBTCNT
>  _try_scratch_mount &> $tmp.mount
>  res=$?
> -_filter_scratch < $tmp.mount
> +_filter_error_mount < $tmp.mount
>  if [ $res -eq 0 ]; then
>  	echo "needsrepair should have prevented mount"
>  	_scratch_unmount
> diff --git a/tests/xfs/158.out b/tests/xfs/158.out
> index 4f9dfd08..5461031a 100644
> --- a/tests/xfs/158.out
> +++ b/tests/xfs/158.out
> @@ -8,7 +8,7 @@ FEATURES: INOBTCNT:NO
>  Fail partway through upgrading
>  Adding inode btree counts to filesystem.
>  FEATURES: NEEDSREPAIR:YES INOBTCNT:YES
> -mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
> +mount: Structure needs cleaning
>  Re-run repair to finish upgrade
>  FEATURES: NEEDSREPAIR:NO INOBTCNT:YES
>  Filesystem should be usable again
> -- 
> 2.31.1
> 

