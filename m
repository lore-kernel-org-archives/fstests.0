Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971EFC25B08
	for <linux-fstests@archiver.kernel.org>; Sat, 20 Aug 2022 03:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiHTDp5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiHTDpz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 23:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F26C6960
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660967152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gb3btCrql3qKGA7B8T9pesxtMLPN7nEi0KsR+v6lig0=;
        b=Q+JfOALzQW/r6hhJnT+9CRf6usQrwMuhVvA4/gm5PnOf3YUiAYtLrLDgaQ7XhzfYefjTlc
        0Xr07t7ATMpzJiw5oJfIQjxne0kxdEfZrWLP8NiQKYbVgVZipDFaQGG5HdVpX6YMYqLZHG
        UEtxOhCEaLFcvsTxVd+cKBXIOE4xZ1U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-L3Si8sqDMXKc06QzYaPT_w-1; Fri, 19 Aug 2022 23:45:50 -0400
X-MC-Unique: L3Si8sqDMXKc06QzYaPT_w-1
Received: by mail-pj1-f69.google.com with SMTP id oc16-20020a17090b1c1000b001fa8330e2ecso5838207pjb.8
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 20:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Gb3btCrql3qKGA7B8T9pesxtMLPN7nEi0KsR+v6lig0=;
        b=59GLKe5LM5pJ/J3zNVWVBBlKljxYk4wc0UQkdZ238PGEQG6ek4sDPLSGt2DtFwBswu
         8Lhm50vcpwMEeXHFaf6QmIr6oAjR1cHTzfEfnxWJJ/liQIBr/QSxxU+z9/JLAwHawrC8
         5t9tS/Nhfr6KY0WZ+dePIEiaeNnfqmMXiBcmw2HAyFJkige1wxj92GWbKElj6ccHv5pp
         DFTGA09dyZa/UbVN8fOj4Yob/RIj0IY6UPXxDyro8sE1OxirapyZ+cXJO+8OH6iiQi/X
         vItj/1LTz8bS1vDRPHX/dsL/O/Ue84LCXOanFjab3TWgyJVLBzWj+mmDJBfk4rABpLBy
         XXNA==
X-Gm-Message-State: ACgBeo1I7XeHUXinnHZryKpXBJ3CXqi09XmNK81stkLJ0DZhiPQNeNZp
        zp4SNiSON/DlAvkhNu6f7N+iWR6Zc2FFj+9XQXW0U1nfLeNxtUq/phFagHArtgC5kuNGTIvMQp6
        BZFl/weVSynFlDCluLQ==
X-Received: by 2002:a05:6a00:4c1b:b0:532:8f07:bba0 with SMTP id ea27-20020a056a004c1b00b005328f07bba0mr10702576pfb.37.1660967149752;
        Fri, 19 Aug 2022 20:45:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5bjfkKnqIzOrrIYyXHCcy8mzYoYR91bNPwTcZl91wR8Mb2NCK3OcjGOZ4J1vTqOw163l2N2w==
X-Received: by 2002:a05:6a00:4c1b:b0:532:8f07:bba0 with SMTP id ea27-20020a056a004c1b00b005328f07bba0mr10702569pfb.37.1660967149380;
        Fri, 19 Aug 2022 20:45:49 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b0016d6963cb12sm3827055plh.304.2022.08.19.20.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 20:45:48 -0700 (PDT)
Date:   Sat, 20 Aug 2022 11:45:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4] generic: test i_blocks for large files
Message-ID: <20220820034544.iatmczyud56poy3w@zlang-mailbox>
References: <20220819143135.468776-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819143135.468776-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 19, 2022 at 04:31:35PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect
> computation of i_blocks for files larger than
> 4 GiB. Bug was filed for exFAT.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/694     | 47 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/694.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/generic/694
>  create mode 100644 tests/generic/694.out
> 
> diff --git a/tests/generic/694 b/tests/generic/694
> new file mode 100755
> index 00000000..dfd988df
> --- /dev/null
> +++ b/tests/generic/694
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 694
> +#
> +# Verify that i_blocks for files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.* $junk_dir
> +}
> +
> +_supported_fs generic
> +_require_test
> +_require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
> +
> +echo "Silence is golden"
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +
> +iblocks=`stat -c '%b' $junk_file`
> +
> +_test_cycle_mount
> +
> +iblocks_after_remount=`stat -c '%b' $junk_file`
> +
> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/694.out b/tests/generic/694.out
> new file mode 100644
> index 00000000..d1fb84a2
> --- /dev/null
> +++ b/tests/generic/694.out
> @@ -0,0 +1,2 @@
> +QA output created by 694
> +Silence is golden
> -- 
> 2.37.2
> 

