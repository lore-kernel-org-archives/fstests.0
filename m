Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24AEECAAA1
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Sep 2022 01:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIGBGO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Sep 2022 21:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGBGN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Sep 2022 21:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E6D81B38
        for <fstests@vger.kernel.org>; Tue,  6 Sep 2022 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662512766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwuHUku1CYVarJx+Q05XI88XqClHar/SpF6mz8ME75s=;
        b=jHMPWv7OQG3PY4Da0jzTGJUsWT+frRxiC0YrE1i6nOnbwkdQNmPh/U271qlD7JELyd2LgW
        ZFldPHve0O+OHdkF6pDcHfu+r3Qhjj64+S8G/xxqrGaHbtXz0Px/fHc2krxECZwVq3ztYs
        k48+ILV7CM5DuO93E9NGawaZnX3NjWc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-beoKy5WcN6G_0rdyvx79sA-1; Tue, 06 Sep 2022 21:06:05 -0400
X-MC-Unique: beoKy5WcN6G_0rdyvx79sA-1
Received: by mail-qv1-f69.google.com with SMTP id n15-20020ad444af000000b004a2a341ad71so5685982qvt.15
        for <fstests@vger.kernel.org>; Tue, 06 Sep 2022 18:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jwuHUku1CYVarJx+Q05XI88XqClHar/SpF6mz8ME75s=;
        b=afZTJ+uNFqW+LQuQPWvwOebP5dBDBiz5dXmKWkBRbz1jV3ylEAcY+rn8JJdqfZUrob
         NxMkTFKcl8y3rXU+ZXojwHSPXLIyCmIdPVV6Cfc80xvbEDQyrp/o6nVQzGyMbampzGwP
         PVubBNBc/aVT2pQDYo6lNpS58fb78UqWE+EF1SS5THOlX6Qpq+aGo9J9siFAiOmB/Zlq
         slfBAxVbl6yCnXg+mX9/F64T9BK3bpA7NLp4GQQxpsZpX3q3R0bOLqXlfqHN+Ge6VGVD
         CZ6fow17Mpy3KO9zaXt0d/hAvZBntBydvTe4mi9rXHAsdqWlty3BQtFkh9jwqP4QEaw4
         wWVQ==
X-Gm-Message-State: ACgBeo1tqd7gw+xEC0jOZkuQWec6LeEP6M3ArATHHwy45rwfYko3dHw4
        yujXOUErToh+tekDTDSR5Dvo4SH5TrjzaE5sqYEMKNP4ZhAKewI4SfHR/Ax2m2ahbVqAi0f+AZh
        7wEQuDyml8F3zPry4wQ==
X-Received: by 2002:a05:6214:2a8e:b0:499:2963:5439 with SMTP id jr14-20020a0562142a8e00b0049929635439mr963578qvb.54.1662512764443;
        Tue, 06 Sep 2022 18:06:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR64eWMXnhAeKrwRdDzS3pUkWU4PSYBgPg2utBYKIeGw4QYS1TnGOoLEVnZIEO+3pVD3UcyCJA==
X-Received: by 2002:a05:6214:2a8e:b0:499:2963:5439 with SMTP id jr14-20020a0562142a8e00b0049929635439mr963567qvb.54.1662512764210;
        Tue, 06 Sep 2022 18:06:04 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a431100b006b9c355ed75sm13029339qko.70.2022.09.06.18.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 18:06:03 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:05:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test i_blocks for truncated large files
Message-ID: <20220907010559.uees5jhn33wfk3zn@zlang-mailbox>
References: <20220906155320.952636-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906155320.952636-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 06, 2022 at 05:53:20PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect computation of i_blocks for
> truncated files larger than 4 GiB. Bug was filed for exFAT.
> 
> Test is based on reproducer provied by Christophe Vu-Brugier as part
> of kernel patch-fix submission.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

Hi Pavel,

Your patch has been merged as generic/694,

>  tests/generic/698     | 47 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/698.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/generic/698
>  create mode 100644 tests/generic/698.out
> 
> diff --git a/tests/generic/698 b/tests/generic/698
> new file mode 100755
> index 00000000..217641e6
> --- /dev/null
> +++ b/tests/generic/698
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 698
> +#
> +# Verify that i_blocks for truncated files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
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
> +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB

_fixed_by_kernel_commit 92fba084b79e \
	exfat: fix i_blocks for files truncated over 4 GiB

> +
> +echo "Silence is golden"
> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
> +
> +

Useless empty lines

> +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
> +
> +iblocks_after_truncate=`stat -c '%b' $junk_file`
> +iblocks_expected=$((4 * 1024 * 1024 * 2))

I think you suspect that the `stat -c %B xxx` always be 512. I don't know if
it's always 512 on Linux, or better to check %B size at first.

Thanks,
Zorro

> +
> +if [ "$iblocks_expected" != "$iblocks_after_truncate" ]; then
> +	echo "Number of blocks needs to be same: $iblocks_expected, $iblocks_after_truncate"
> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/698.out b/tests/generic/698.out
> new file mode 100644
> index 00000000..222db0de
> --- /dev/null
> +++ b/tests/generic/698.out
> @@ -0,0 +1,2 @@
> +QA output created by 698
> +Silence is golden
> -- 
> 2.37.3
> 

