Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A1EB64DD
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 14:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGDOEv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDOEu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Jul 2023 10:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C7FB
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688479445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=138+a/4+PWIe2vLu2g0IbA5tBIsL9VD0wcDwCy2snLo=;
        b=BRWzBU6aBylAGUV79U8tgfwPN14tZrkOxSBTsI/uyilOLDrGWxJ0fk9Z2ailvXerVGz6df
        Y537NBI0G7NuiMtAa7bnUK0lrjRn80Sl5LTdNdT3GohFR99D0IOX3Iy9yarETB+ck/65QR
        mWoLa0OYZxiUmyKSkocKXNzceIB9u74=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Mqx_iGipM1e4a7_f-ytcIg-1; Tue, 04 Jul 2023 10:04:01 -0400
X-MC-Unique: Mqx_iGipM1e4a7_f-ytcIg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6237c937691so33790346d6.0
        for <fstests@vger.kernel.org>; Tue, 04 Jul 2023 07:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479441; x=1691071441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=138+a/4+PWIe2vLu2g0IbA5tBIsL9VD0wcDwCy2snLo=;
        b=CHrVf/wZ7bwbbO1hAna5/iub3T53baIcsZIz5yAvP6qDPlSui5qMhICMUGCfKAs0hj
         OCga1lHjJESdbrhpSJShP2HMtSIOmVblhIOchYd8VdmqOIT2EpXOwmScPPcfWs7uqbt1
         mKiMVuKVmYUmTdJNgf0B6cssV1//UngKUWSB0ieD/+ajNm/o3hYxsWPrGdn40z+niosU
         qprTVXgPkA9G8zlGGhdslBauYWjQYnemWACc2JRJIV9Lo2/dXXospaVP12Esd6GTsPEC
         lwVLPs6GHjNJO6DAdkFZo3SlgaHfmSYcpiooNCi1gaWB+bKGthrkysKwhSDs0Qrq65to
         h3mw==
X-Gm-Message-State: AC+VfDymYIhnALSVLbT7ZK29W2/9Rp/TqJDNf6qtaT0oSFpac1FNwaCH
        FpnUxm6TtDukY0PrGvLEwFNkpgTyGhchNK1N0dwjlYgBLGOk+1vXKd8ei+QiEzlxum2h90BU+2c
        5L25H5aoYsT3JLKgy8sTpg1CK
X-Received: by 2002:a05:6214:20eb:b0:625:b491:7911 with SMTP id 11-20020a05621420eb00b00625b4917911mr21241705qvk.21.1688479441284;
        Tue, 04 Jul 2023 07:04:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4b6q/z/UD3dSBG0zDWpg6aaEcnmhvJq/Q1AAPbeMjxL3wW1ncFTfU7k0ti75OqH84iR94rHA==
X-Received: by 2002:a05:6214:20eb:b0:625:b491:7911 with SMTP id 11-20020a05621420eb00b00625b4917911mr21241682qvk.21.1688479441012;
        Tue, 04 Jul 2023 07:04:01 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id x7-20020ac87007000000b003fe0a89447fsm4666544qtm.14.2023.07.04.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:04:00 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:03:57 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 5/5] xfs: test growfs of the realtime device
Message-ID: <20230704140357.tg2yxfknkzniotve@aalbersh.remote.csb>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840384128.1317961.1554188648447496379.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168840384128.1317961.1554188648447496379.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-03 10:04:01, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a new test to make sure that growfs on the realtime device works
> without corrupting anything.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/934     |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/934.out |   19 +++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tests/xfs/934
>  create mode 100644 tests/xfs/934.out
> 
> 
> diff --git a/tests/xfs/934 b/tests/xfs/934
> new file mode 100755
> index 0000000000..f2db4050a7
> --- /dev/null
> +++ b/tests/xfs/934
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.

Oracle?

> +#
> +# FS QA Test No. 934
> +#
> +# growfs QA tests - repeatedly fill/grow the rt volume of the filesystem check
> +# the filesystem contents after each operation.  This is the rt equivalent of
> +# xfs/041.
> +#
> +. ./common/preamble
> +_begin_fstest growfs ioctl auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount
> +	rm -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs xfs
> +
> +_require_scratch
> +_require_realtime
> +_require_no_large_scratch_dev
> +_scratch_unmount 2>/dev/null
> +
> +_fill()
> +{
> +    if [ $# -ne 1 ]; then echo "Usage: _fill \"path\"" 1>&2 ; exit 1; fi

Is this needed for something?

> +    _do "Fill filesystem" \
> +	"$here/src/fill2fs --verbose --dir=$1 --seed=0 --filesize=65536 --stddev=32768 --list=- >>$tmp.manifest"
> +}
> +
> +_do_die_on_error=message_only
> +rtsize=32
> +echo -n "Make $rtsize megabyte rt filesystem on SCRATCH_DEV and mount... "
> +_scratch_mkfs_xfs -rsize=${rtsize}m | _filter_mkfs 2> "$tmp.mkfs" >> $seqres.full
> +test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed"
> +
> +. $tmp.mkfs
> +onemeginblocks=`expr 1048576 / $dbsize`
> +_scratch_mount
> +
> +# We're growing the realtime device, so force new file creation there
> +_xfs_force_bdev realtime $SCRATCH_MNT
> +
> +echo "done"
> +
> +# full allocation group -> partial; partial -> expand partial + new partial;
> +# partial -> expand partial; partial -> full
> +# cycle through 33m -> 67m -> 75m -> 96m
> +for size in 33 67 75 96
> +do
> +    grow_size=`expr $size \* $onemeginblocks`
> +    _fill $SCRATCH_MNT/fill_$size
> +    _do "Grow filesystem to ${size}m" "xfs_growfs -R $grow_size $SCRATCH_MNT"
> +    echo -n "Flush filesystem... "
> +    _do "_scratch_unmount"
> +    _do "_try_scratch_mount"
> +    echo "done"
> +    echo -n "Check files... "
> +    if ! _do "$here/src/fill2fs_check $tmp.manifest"; then
> +      echo "fail (see $seqres.full)"

I think "fail" is already printed by _do

These are nitpicks, anyway looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

