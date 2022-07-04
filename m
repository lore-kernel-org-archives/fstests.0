Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C56C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jul 2022 17:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiGDR5R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Jul 2022 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGDR5Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jul 2022 13:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A197B646B
        for <fstests@vger.kernel.org>; Mon,  4 Jul 2022 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656957434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3vN6WZfW5gSe2po9qbcl5NIkvtJvk8t8k6YEH5NTY8=;
        b=PXTHlZ1CdVKDRvNdGobq1MNZQeIpx9mwFJV0qa+eu0iICCTPI/o9NtFmh8RJe/xarySY+V
        zxj1U9WP+Oti3agdblMVObsBDXuaHQcciD4WWE6SEwfxJ25G8Wmigi1sDyOMfcy18u/VTL
        R/2al+QdfjWrfLArehb1XCd+QbF1ZUk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-qeYVEgvXM2O3i8kbdA-5Dw-1; Mon, 04 Jul 2022 13:57:13 -0400
X-MC-Unique: qeYVEgvXM2O3i8kbdA-5Dw-1
Received: by mail-qk1-f197.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so9230533qke.1
        for <fstests@vger.kernel.org>; Mon, 04 Jul 2022 10:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3vN6WZfW5gSe2po9qbcl5NIkvtJvk8t8k6YEH5NTY8=;
        b=KBQZo4cp8Y3LX0F14XEmqBxyqx3EWs/edlWW6I3IxKm8zVtpjm7wZVv8FcanqImM/j
         +juMX+KO5fhObrh/K5IRliJx39qE7s+WYqV8xoYB9r/5UEJ3npx61YYRSVqUfCQlSEEJ
         BLdLkfFlB5mUSjHU9WWXquOs78IyMC9fQssrewzmPKu05rUPzkS9oo3aiWBgNDJp3GJm
         xZsAS0nylTPmqFMqUvFxL0FQq4RNt9tIeTKoS7g0XHuyDM0xyN1NWAttYmeilntqm8eN
         /oQpXCqyDWCEr4ir8ALDiddOrS2EwL1dqRcqNI25rFpPpxmWQKmFiwGiPA97VvvAyhnV
         Bb/Q==
X-Gm-Message-State: AJIora+aFKYn0X/+vUYh1cPjyEA4wcX1R+ZG7HG0XuLLZB0Y/Z5JFJYf
        vVF5GzoOCUpuSMMWe95xBnitgt82car9iuDxdyZA2YpVNUQ3Gdw2lUwRIyzh8jkZZWCBqaLS7Om
        kAkb/ldi5HQqm0so8kg==
X-Received: by 2002:ae9:e887:0:b0:6af:5378:41bf with SMTP id a129-20020ae9e887000000b006af537841bfmr20645371qkg.673.1656957432775;
        Mon, 04 Jul 2022 10:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjVmOonjGqKKY/WEueo3hPo9ZG4K1hvJ2QFoyPRoBkBBOaPnOPzq8XLnBjZ9WytG9FZ8jd/g==
X-Received: by 2002:ae9:e887:0:b0:6af:5378:41bf with SMTP id a129-20020ae9e887000000b006af537841bfmr20645361qkg.673.1656957432411;
        Mon, 04 Jul 2022 10:57:12 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bq30-20020a05620a469e00b006a785ba0c25sm15476359qkb.77.2022.07.04.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:57:11 -0700 (PDT)
Date:   Tue, 5 Jul 2022 01:57:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/082: Add xfs_db get value regression test
Message-ID: <20220704175706.lzquvtzgzv3zv7q4@zlang-mailbox>
References: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1656340203-2322-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656340203-2322-2-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 27, 2022 at 10:30:03PM +0800, Yang Xu wrote:
> This case is a regression test for xfsprogs commit
> f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()").
> 
> I found this because xfs/270 on older xfsprogs can hit this bug.
> The code is pasted from xfs/270 but remove mount rw/ro test.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/082     | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/082.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/xfs/082
>  create mode 100644 tests/xfs/082.out
> 
> diff --git a/tests/xfs/082 b/tests/xfs/082
> new file mode 100755
> index 00000000..7a5ece8f
> --- /dev/null
> +++ b/tests/xfs/082
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> +#
> +# FS QA Test 082
> +#
> +# Today xfs_db set_cur whether clean up the LIBXFS_READBUF_SALVAGE
> +# call sites so that we use the return value directly instead of
> +# scraping it out later.
> +# 
> +# It is a regression test for xfsprogs
> +# f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()").
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs xfs
> +# skip fs check because superblock contains unknown ro-compat features
> +_require_scratch_nocheck
> +# Only V5 XFS disallow rw mount/remount with unknown ro-compat features
> +_require_scratch_xfs_crc
> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +
> +# set the highest bit of features_ro_compat, use it as an unknown
> +# feature bit. If one day this bit become known feature, please
> +# change this case.
> +
> +ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0")
> +echo $ro_compat | grep -q -E '^0x[[:xdigit:]]$'
> +if [[ $? != 0  ]]; then
> +	echo "features_ro_compat has an invalid value."
> +fi
> +
> +ro_compat=$(echo $ro_compat | \
> +		    awk '/^0x[[:xdigit:]]+/ {
> +				printf("0x%x\n", or(strtonum($1), 0x80000000))
> +			}')
> +
> +# write the new ro compat field to the superblock
> +_scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
> +				> $seqres.full 2>&1
> +
> +# read the newly set ro compat filed for verification
> +new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
> +					>$seqres.full 2>&1)

Hi,

Although you hit this issue by xfs/270, but that doesn't mean you need to do the
same complicated calculation.

You nearly can corrupt many fields to trigger that xfs_db bug, due to
you don't need to test xfs mount. For example corrupt the features_ro_compat
simply:

  # xfs_db -x -c "sb 0" -c "write -d features_ro_compat 0x80000000" /dev/sda3
  Allowing write of corrupted data with good CRC
  features_ro_compat = 0x80000000
  # xfs_db -c "sb 0" -c "print features_ro_compat" /dev/sda3
  Superblock has unknown read-only compatible features (0x80000000) enabled.
  Attempted to mount read-only compatible filesystem read-write.
  Filesystem can only be safely mounted read only.
  no current type
  cache_purge: shake on cache 0x562ed6463a70 left 1 nodes!?
  cache_purge: shake on cache 0x562ed6463a70 left 1 nodes!?
  cache_zero_check: refcount is 1, not zero (node=0x562ed6478110)

Or even corrupt the sb magicnum (sb 0 need -F) directly:

  # xfs_db -x -c "sb 1" -c "write -d magicnum 0" /dev/sda3
  Allowing write of corrupted data and bad CRC
  magicnum = 0
  # xfs_db -c "sb 1" -c "print magicnum" /dev/sda3
  bad magic number
  no current type
  cache_purge: shake on cache 0x5589a86a9a70 left 1 nodes!?
  cache_purge: shake on cache 0x5589a86a9a70 left 1 nodes!?
  cache_zero_check: refcount is 1, not zero (node=0x5589a86be110)

Or choose other fields you feel good.

> +
> +# verify the new ro_compat field is empty
> +# Without xfsprog patch, xfs_db set_cur function doesn't return directly when
> +# meeting error by using LIBXFS_READBUF_SALVAGE flag. So cache_purge will complain
> +# about this.
> +if [ -z $new_ro_compat ]; then
> +	grep -q "cache_purge: shake on cache" $seqres.full && \
> +		echo "Hit xfsprogs set_cur bug"
> +	echo "Unable to get new ro compat filed"

Let those "cache_purge ..." things break golden image (.out2 file) directly.

> +fi
> +
> +echo "Silence is golden."
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/082.out b/tests/xfs/082.out
> new file mode 100644
> index 00000000..6ed56cb1
> --- /dev/null
> +++ b/tests/xfs/082.out
> @@ -0,0 +1,2 @@
> +QA output created by 082
> +Silence is golden.
> -- 
> 2.27.0
> 

