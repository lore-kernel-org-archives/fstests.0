Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D6CD4846
	for <linux-fstests@archiver.kernel.org>; Fri, 22 Sep 2023 17:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjIVRMl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIVRMk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 22 Sep 2023 13:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C01198
        for <fstests@vger.kernel.org>; Fri, 22 Sep 2023 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695402706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7JJ8GDc0WMBiyqPY+SDqt8ZvOoqVbEWn0hW2YQR7aGU=;
        b=gDvr55fH9K84QucV3CWLYN3frB3za0Pbl78qAbTOgEoRBQoPkApRomXLjveO9yEUPjT9WT
        vfjcSiXigpsrIWbppGat7KffeJnslQyj+jKVSwem7IasUSwVA+n6vl7DaVi3Lt9t8mlhBh
        f1KaTwfGzJe0YBerFlHrQAzgNFuyG9A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-M-Vjc4xxMVWFMOZqIEyJPQ-1; Fri, 22 Sep 2023 13:11:44 -0400
X-MC-Unique: M-Vjc4xxMVWFMOZqIEyJPQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c577fea3dcso20013465ad.2
        for <fstests@vger.kernel.org>; Fri, 22 Sep 2023 10:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695402703; x=1696007503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JJ8GDc0WMBiyqPY+SDqt8ZvOoqVbEWn0hW2YQR7aGU=;
        b=rXR7GMCJ+KtcdTyBv3wL0n96+2x7XauYbd7bb6vUOYYwinNZHlKsybYFBrG0lwxduU
         KOQXam7icebhEBrQRxf9dsH6NZB6BP7IFyvXcoqOY9xvgmN7G6HbGZf/P1LlBxaEDKEV
         QZHISK8vZI+ApkVwfoBn396qUQ3nlPq3+RECHIYXLaBbowEyt7DVsPqpWQDkVqi0OnQ3
         ll0g3zE1XzEomqRunph3ijkuZNgWgg/lZoLK5uEDVe8Ssl21ZUNrrMDJDzJLE5+GGTxj
         kgTIK/wut5pWwbO7uP+jyE6k8lwhaZfJ8ggFwmbqxC1cnUeq3MDsfuQ4VcYfNcCVHlzH
         CrUA==
X-Gm-Message-State: AOJu0YzlFEvikwExhhjqYvYzKlh8HzUdTU1TTcfWL+rsNkx6IsVwABxK
        mkzHoVVzEK2xA+76cmZ9sIKMuj/3EcjcCkETRgVLIcks1BzeWFZUZSkJx3QgQ+7QzBHL9nwfL7z
        wrwI0ecwdul5MoEQ9JA==
X-Received: by 2002:a17:902:ab17:b0:1b8:28f6:20e6 with SMTP id ik23-20020a170902ab1700b001b828f620e6mr90279plb.34.1695402703570;
        Fri, 22 Sep 2023 10:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvF8HqczD1mx2AQsIe4++Z59S6NRE1VnElUP63PN5GKXNT6dPAjHCJI8aVVC85o9lku7f8CA==
X-Received: by 2002:a17:902:ab17:b0:1b8:28f6:20e6 with SMTP id ik23-20020a170902ab1700b001b828f620e6mr90265plb.34.1695402703228;
        Fri, 22 Sep 2023 10:11:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001c56157f062sm3724112plk.227.2023.09.22.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:11:42 -0700 (PDT)
Date:   Sat, 23 Sep 2023 01:11:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add missing _fixed_by_kernel_commit for a few
 tests
Message-ID: <20230922171139.gnri5fnoxmqcxtt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <34b81b45d31ac4f951a1eb218870f27e74920a75.1695272311.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b81b45d31ac4f951a1eb218870f27e74920a75.1695272311.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 21, 2023 at 01:22:16PM +0800, Anand Jain wrote:
> A few tests were still using the older style of mentioning the fix in the
> comment section. This patch migrates them to using
> _fixed_by_kernel_commit.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

No objection from me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/199 | 6 +++---
>  tests/btrfs/216 | 4 ++--
>  tests/btrfs/218 | 6 ++----
>  tests/btrfs/225 | 4 ++--
>  tests/btrfs/238 | 5 ++---
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/btrfs/199 b/tests/btrfs/199
> index 709ad1f988c3..a4920b99ef97 100755
> --- a/tests/btrfs/199
> +++ b/tests/btrfs/199
> @@ -12,9 +12,6 @@
>  # There is a long existing bug that btrfs doesn't discard all space for
>  # above mentioned case.
>  #
> -# The fix is: "btrfs: extent-tree: Ensure we trim ranges across block group
> -# boundary"
> -#
>  . ./common/preamble
>  _begin_fstest auto quick trim fiemap
>  
> @@ -34,6 +31,9 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +_fixed_by_kernel_commit 6b7faadd985c \
> +	"btrfs: Ensure we trim ranges across block group boundary"
> +
>  _require_loop
>  _require_xfs_io_command "fiemap"
>  
> diff --git a/tests/btrfs/216 b/tests/btrfs/216
> index 2ed4866887f7..979dcb73f097 100755
> --- a/tests/btrfs/216
> +++ b/tests/btrfs/216
> @@ -6,8 +6,6 @@
>  #
>  # Test if the show_devname() returns sprout device instead of seed device.
>  #
> -# Fixed in kernel patch:
> -#   btrfs: btrfs_show_devname don't traverse into the seed fsid
>  
>  . ./common/preamble
>  _begin_fstest auto quick seed
> @@ -17,6 +15,8 @@ _begin_fstest auto quick seed
>  
>  # real QA test starts here
>  _supported_fs btrfs
> +_fixed_by_kernel_commit 4faf55b03823 \
> +	"btrfs: don't traverse into the seed devices in show_devname"
>  _require_scratch_dev_pool 2
>  
>  _scratch_dev_pool_get 2
> diff --git a/tests/btrfs/218 b/tests/btrfs/218
> index 672ad0ff61f0..b0434834ff65 100755
> --- a/tests/btrfs/218
> +++ b/tests/btrfs/218
> @@ -4,10 +4,6 @@
>  #
>  # FS QA Test 218
>  #
> -# Regression test for the problem fixed by the patch
> -#
> -#  btrfs: init device stats for seed devices
> -#
>  # Make a seed device, add a sprout to it, and then make sure we can still read
>  # the device stats for both devices after we remount with the new sprout device.
>  #
> @@ -22,6 +18,8 @@ _begin_fstest auto quick volume
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +_fixed_by_kernel_commit 124604eb50f8 \
> +	"btrfs: init device stats for seed devices"
>  _require_test
>  _require_scratch_dev_pool 2
>  
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> index cfb64a342644..677c162cb63a 100755
> --- a/tests/btrfs/225
> +++ b/tests/btrfs/225
> @@ -5,8 +5,6 @@
>  # FS QA Test 225
>  #
>  # Test for seed device-delete on a sprouted FS.
> -# Requires kernel patch
> -#    b5ddcffa3777  btrfs: fix put of uninitialized kobject after seed device delete
>  #
>  # Steps:
>  #  Create a seed FS. Add a RW device to make it sprout FS and then delete
> @@ -30,6 +28,8 @@ _cleanup()
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +_fixed_by_kernel_commit b5ddcffa3777 \
> +	"btrfs: fix put of uninitialized kobject after seed device delete"
>  _require_test
>  _require_scratch_dev_pool 2
>  _require_btrfs_forget_or_module_loadable
> diff --git a/tests/btrfs/238 b/tests/btrfs/238
> index 57245917e16a..3a711ea7a1a8 100755
> --- a/tests/btrfs/238
> +++ b/tests/btrfs/238
> @@ -6,9 +6,6 @@
>  #
>  # Check seed device integrity after fstrim on the sprout device.
>  #
> -#  Kernel bug is fixed by the commit:
> -#    btrfs: fix unmountable seed device after fstrim
> -
>  . ./common/preamble
>  _begin_fstest auto quick seed trim
>  
> @@ -19,6 +16,8 @@ _begin_fstest auto quick seed trim
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +_fixed_by_kernel_commit 5e753a817b2d \
> +	"btrfs: fix unmountable seed device after fstrim"
>  _require_command "$BTRFS_TUNE_PROG" btrfstune
>  _require_fstrim
>  _require_scratch_dev_pool 2
> -- 
> 2.31.1
> 

