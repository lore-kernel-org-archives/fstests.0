Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A508C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 25 May 2022 10:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiEYKTs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiEYKTm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 06:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A1F980A3
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653473980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1DXRMCY/tfzpXdkcHcHEsQrRA6L8E7a7r6NEVKGEGM=;
        b=bxmcdMgkztIHBnNz17IKGOu/3iXp9xTXhqgXrQ5D4odjRywVPEJVWUaRjusJm3X1gvXw/P
        NRh4TW6dUEO05owC9hXTjDnxp11Mo/pgFCmLTAHkht77zUKW3u8L6RDIuyJHm3Hc9jUjjJ
        FLPHNbiHbR1FC1zmjc7jDzsdLXyCtBI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-dcfpURWtNsCIp4H2tOJNpw-1; Wed, 25 May 2022 06:19:39 -0400
X-MC-Unique: dcfpURWtNsCIp4H2tOJNpw-1
Received: by mail-qt1-f197.google.com with SMTP id q13-20020a05622a04cd00b002f3c0e197afso15914092qtx.0
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 03:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W1DXRMCY/tfzpXdkcHcHEsQrRA6L8E7a7r6NEVKGEGM=;
        b=OZvaP+A9CrW9gk39E38b8YhJPN7J9m8wCwz8hESV1SYAkyWX6GXZkRNSIIGcaVKmsp
         4IVtPlAH9R4bjJwKq57SIx1tLUxn/W8PLEYbBECain0y7tkzkBEVQY/0yWGvqyatXK/j
         vfCdtCtCptnHX652eBmMcK6YDem700Rr9tSp+CtMJ+7UQmMAh/O1PlrDPQY5M57u1gSR
         qyD95rlqaPo8KOgMwTTYDCoWUsHJMu6moxwJtEbDBQaRbbHCeIv/rKzy4FczuPFMYC/f
         wcLB1WwyzGro2wVED9xQxdQJGTWcVvPhNHySJnlTITscUiBpz8pVjsiamEN5XL3wwoYZ
         XxYg==
X-Gm-Message-State: AOAM530VGsu6uoOQNqzinmjdSzBYTiD+anf0UrFLflMQNrYd+Z5WjX7m
        q0H96W3NWHRwuuqXyWXS4DVHObDsRuMw3KapbDocp7PF7+665ksYJnW94Kt7fWLuzdYPKyqDJCV
        MgkpTG/0uRKhQX7sn0w==
X-Received: by 2002:ac8:5f4c:0:b0:2f9:2b1b:fb47 with SMTP id y12-20020ac85f4c000000b002f92b1bfb47mr15380529qta.454.1653473978971;
        Wed, 25 May 2022 03:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbpdiyKPiBBoOiqrekfDrpLEivO9HZvpX41s0nQVc9nMYQCjI+UQTdCllHVhw42wRHw6Kzzg==
X-Received: by 2002:ac8:5f4c:0:b0:2f9:2b1b:fb47 with SMTP id y12-20020ac85f4c000000b002f92b1bfb47mr15380512qta.454.1653473978674;
        Wed, 25 May 2022 03:19:38 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v4-20020ac873c4000000b002f906fc8530sm1073462qtp.46.2022.05.25.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:19:38 -0700 (PDT)
Date:   Wed, 25 May 2022 18:19:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] ceph/005: verify correct statfs behaviour with quotas
Message-ID: <20220525101932.2dnpi3ehhakhxdnp@zlang-mailbox>
References: <20220427143409.987-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427143409.987-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 27, 2022 at 03:34:09PM +0100, Luís Henriques wrote:
> When using a directory with 'max_bytes' quota as a base for a mount,
> statfs shall use that 'max_bytes' value as the total disk size.  That
> value shall be used even when using subdirectory as base for the mount.
> 
> A bug was found where, when this subdirectory also had a 'max_files'
> quota, the real filesystem size would be returned instead of the parent
> 'max_bytes' quota value.  This test case verifies this bug is fixed.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  tests/ceph/005     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/ceph/005.out |  2 ++
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/ceph/005
>  create mode 100644 tests/ceph/005.out
> 
> diff --git a/tests/ceph/005 b/tests/ceph/005
> new file mode 100755
> index 000000000000..0763a235a677
> --- /dev/null
> +++ b/tests/ceph/005
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 005
> +#
> +# Make sure statfs reports correct total size when:
> +# 1. using a directory with 'max_byte' quota as base for a mount
> +# 2. using a subdirectory of the above directory with 'max_files' quota
> +#
> +. ./common/preamble
> +_begin_fstest auto quick quota
> +
> +_supported_fs generic

As this case name is ceph/005, so I suppose you'd like to support 'ceph' only.

> +_require_scratch
> +
> +_scratch_mount
> +mkdir -p $SCRATCH_MNT/quota-dir/subdir
> +
> +# set quotas
> +quota=$((1024*10000))
> +$SETFATTR_PROG -n ceph.quota.max_bytes -v $quota $SCRATCH_MNT/quota-dir
> +$SETFATTR_PROG -n ceph.quota.max_files -v $quota $SCRATCH_MNT/quota-dir/subdir
> +_scratch_unmount
> +
> +SCRATCH_DEV=$SCRATCH_DEV/quota-dir _scratch_mount

Try to not use SCRATCH_DEV like this.

> +total=`df -kP $SCRATCH_MNT | grep -v Filesystem | awk '{print $2}'`
          ^^ $DF_PROG

As we have _get_total_inode(), _get_used_inode(), _get_used_inode_percent(),
_get_free_inode() and _get_available_space() in common/rc, I don't mind add
one more:

_get_total_space()
{
	if [ -z "$1" ]; then
		echo "Usage: _get_total_space <mnt>"
		exit 1
	fi
	local total_kb;
	total_kb=`$DF_PROG $1 | tail -n1 | awk '{ print $2 }'`
	echo $((total_kb * 1024))
}

> +SCRATCH_DEV=$SCRATCH_DEV/quota-dir _scratch_unmount
> +[ $total -eq 8192 ] || _fail "Incorrect statfs for quota-dir: $total"
                ^^^^
I'm not familar with ceph, I just found "quota=$((1024*10000))" in this case,
didn't find any place metioned 8192. So may you help to demystify why we expect
"8192" at here?

And if "8192" is a fixed expected number at here, then we can print it directly,
as golden image, see below ...

> +
> +SCRATCH_DEV=$SCRATCH_DEV/quota-dir/subdir _scratch_mount
> +total=`df -kP $SCRATCH_MNT | grep -v Filesystem | awk '{print $2}'`
> +SCRATCH_DEV=$SCRATCH_DEV/quota-dir/subdir _scratch_unmount
> +[ $total -eq 8192 ] || _fail "Incorrect statfs for quota-dir/subdir: $total"

May below code helps?

_require_test

localdir=$TEST_DIR/ceph-quota-dir-$seq
rm -rf $localdir
mkdir -p ${localdir}/subdir
...
$SETFATTR_PROG -n ceph.quota.max_bytes -v $quota $localdir
$SETFATTR_PROG -n ceph.quota.max_bytes -v $quota $localdir/subdir
...

SCRATCH_DEV=$localdir _scratch_mount
echo ceph quota size is $(_get_total_space $SCRATCH_MNT)
SCRATCH_DEV=$localdir _scratch_unmount

SCRATCH_DEV=$localdir/subdir _scratch_mount
echo subdir ceph quota size is $(_get_total_space $SCRATCH_MNT)
SCRATCH_DEV=$localdir/subdir _scratch_unmount

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ceph/005.out b/tests/ceph/005.out
> new file mode 100644
> index 000000000000..a5027f127cf0
> --- /dev/null
> +++ b/tests/ceph/005.out
> @@ -0,0 +1,2 @@
> +QA output created by 005
> +Silence is golden
> 

