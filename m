Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443BC00A8F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Oct 2023 05:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJXFZ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Oct 2023 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFZ1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Oct 2023 01:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51134E5
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698125080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mkkYRmoNKQaPF5+JHht/Xahm37ZRoweY/wCdPs+E1A=;
        b=E5xZImn6L/jqwMF6rZyRezYuyEUwZl7A1SndV64KidAuYMoV8lWG7sghqJhn3PFkmm73dA
        xSU97xNTjKdd3Oj8dRSMv5ZWig9KH+giVOeBiDF2kohsCXi1NZyyFWrZ2n7tcnCTYKb7u1
        4xIrUIt189HCaFcFufqLV0bkHgGwTmk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-V-_qKvloNG-qrnYnQD-4AA-1; Tue, 24 Oct 2023 01:24:38 -0400
X-MC-Unique: V-_qKvloNG-qrnYnQD-4AA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789a691086so530992785a.0
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 22:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698125078; x=1698729878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mkkYRmoNKQaPF5+JHht/Xahm37ZRoweY/wCdPs+E1A=;
        b=l/SlaGWmVIek8WRF3++v4ynbhvr1GL+LMSTojpvtqJOFw1Vi4b3DVD4ids0Uo0OEf/
         ml7gPBkdM3OjwUClhLt1yJEvdJJ3s0aOSfIauHmw54fK088vAMAIYn9hCZ9ebM4pJoMM
         PWrbl0HTbSb9egnWdT7oZ0aCITiMumxa45IjGQT0+jy16YByMm1izHfyn42tu2qSDSrU
         LpZ9hw9HtDwDu0MHVVuJdbu3TO5OGeenPRcvaBxbiflPtLFX1+qWFPJpGGJXmcAiWMBD
         UBWv6zccxWlnsT2sFApAs8eoFwkVybY8PWtLcvlJ5mxITM9EIvq7iPsNsk5hSthk8CC8
         GrDg==
X-Gm-Message-State: AOJu0YyHo99ikLHEJMGAF2/SQuMYK7YIE9rKJEEyIzLGII8hFTL3qFHW
        Evas4kaeiNdOld4PAMv4zGqaVbkbiCGCwTSvrGDva+K1O4dWpJIFNipm4JYSPXiYKrZkJb5c4RD
        daJnT+xZOqWqQoIYp5g==
X-Received: by 2002:a05:620a:29cb:b0:779:e75d:e80e with SMTP id s11-20020a05620a29cb00b00779e75de80emr2517970qkp.15.1698125077916;
        Mon, 23 Oct 2023 22:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkT0dxAl19J8ikhFMnEYSrEloPSQCmecjkWjNovdkHRWFVCyjiY1D4kN1efHDDFV3RWHCOFg==
X-Received: by 2002:a05:620a:29cb:b0:779:e75d:e80e with SMTP id s11-20020a05620a29cb00b00779e75de80emr2517959qkp.15.1698125077660;
        Mon, 23 Oct 2023 22:24:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7956b000000b006baa1cf561dsm7012913pfq.0.2023.10.23.22.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:24:37 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:24:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Karel Zak <kzak@redhat.com>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] overlay: add test for lowerdir mount option parsing
Message-ID: <20231024052433.gpalxwtb37kqd6kn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231023163259.2949803-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023163259.2949803-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 23, 2023 at 07:32:59PM +0300, Amir Goldstein wrote:
> Check parsing and display of spaces and escaped colons and commans in
> lowerdir mount option.
> 
> This is a regression test for two bugs introduced in v6.5 with the
> conversion to new mount api.
> 
> There is another regression of new mount api related to libmount parsing
> of escaped commas, but this needs a fix in libmount - this test only
> verifies the fixes in the kernel, so it uses LIBMOUNT_FORCE_MOUNT2=always
> to force mount(2) and kernel pasring of the comma separated options list.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Changes since v2:
> - Fix test for when index feature is enabled
> 
> Changes since v1:
> - Fix test for libmount >= 2.39
> 
>  tests/overlay/083     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/083.out |  2 ++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/overlay/083
>  create mode 100644 tests/overlay/083.out
> 
> diff --git a/tests/overlay/083 b/tests/overlay/083
> new file mode 100755
> index 00000000..df82d1fd
> --- /dev/null
> +++ b/tests/overlay/083
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 CTERA Networks. All Rights Reserved.
> +#
> +# FS QA Test 083
> +#
> +# Test regressions in parsing and display of special chars in mount options.
> +#
> +# The following kernel commits from v6.5 introduced regressions:
> +#  b36a5780cb44 ("ovl: modify layer parameter parsing")
> +#  1784fbc2ed9c ("ovl: port to new mount api")
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs overlay
> +_fixed_by_kernel_commit 32db51070850 \
> +	"ovl: fix regression in showing lowerdir mount option"
> +_fixed_by_kernel_commit c34706acf40b \
> +	"ovl: fix regression in parsing of mount options with escaped comma"
> +
> +# _overlay_check_* helpers do not handle special chars well
> +_require_scratch_nocheck
> +
> +# Remove all files from previous tests
> +_scratch_mkfs
> +
> +# Create lowerdirs with special characters
> +lowerdir_spaces="$OVL_BASE_SCRATCH_MNT/lower1 with  spaces"
> +lowerdir_colons="$OVL_BASE_SCRATCH_MNT/lower2:with::colons"
> +lowerdir_commas="$OVL_BASE_SCRATCH_MNT/lower3,with,,commas"
> +lowerdir_colons_esc="$OVL_BASE_SCRATCH_MNT/lower2\:with\:\:colons"
> +lowerdir_commas_esc="$OVL_BASE_SCRATCH_MNT/lower3\,with\,\,commas"
> +upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
> +workdir=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
> +mkdir -p "$lowerdir_spaces" "$lowerdir_colons" "$lowerdir_commas"
> +
> +# _overlay_mount_* helpers do not handle special chars well, so execute mount directly.
> +# if escaped colons are not parsed correctly, mount will fail.
> +$MOUNT_PROG -t overlay ovl_esc_test $SCRATCH_MNT \
> +	-o"upperdir=$upperdir,workdir=$workdir" \
> +	-o"lowerdir=$lowerdir_colons_esc:$lowerdir_spaces" \
> +	2>&1 | tee -a $seqres.full
> +
> +# if spaces are not escaped when showing mount options,
> +# mount command will not show the word 'spaces' after the spaces
> +$MOUNT_PROG -t overlay | grep ovl_esc_test  | tee -a $seqres.full | grep -v spaces && \
> +	echo "ERROR: escaped spaces truncated from lowerdir mount option"
> +
> +# Re-create the upper/work dirs to mount them with a different lower
> +# This is required in case index feature is enabled
> +$UMOUNT_PROG $SCRATCH_MNT
> +rm -rf "$upperdir" "$workdir"
> +mkdir -p "$upperdir" "$workdir"
> +
> +# Kernel commit c34706acf40b fixes parsing of mount options with escaped comma
> +# when the mount options string is provided via data argument to mount(2) syscall.
> +# With libmount >= 2.39, libmount itself will try to split the comma separated
> +# options list provided to mount(8) commnad line and call fsconfig(2) for each
> +# mount option seperately.  Since libmount does not obay to overlayfs escaped
> +# commas format, it will call fsconfig(2) with the wrong path (i.e. ".../lower3")
> +# and this test will fail, but the failure would indicate a libmount issue, not
> +# a kernel issue.  Therefore, force libmount to use mount(2) syscall, so we only
> +# test the kernel fix.
> +LIBMOUNT_FORCE_MOUNT2=always $MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_DEV $SCRATCH_MNT \
> +	-o"upperdir=$upperdir,workdir=$workdir,lowerdir=$lowerdir_commas_esc" 2>> $seqres.full || \
> +	echo "ERROR: incorrect parsing of escaped comma in lowerdir mount option"

This version looks good to me. I just hope we can remove the "LIBMOUNT_FORCE_MOUNT2=always"
after that issue get fixed, to let this case cover new mount API test too.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/overlay/083.out b/tests/overlay/083.out
> new file mode 100644
> index 00000000..0beba309
> --- /dev/null
> +++ b/tests/overlay/083.out
> @@ -0,0 +1,2 @@
> +QA output created by 083
> +Silence is golden
> -- 
> 2.34.1
> 

