Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F08ECAAD3
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Sep 2022 03:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIIDuC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Sep 2022 23:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIIDuB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Sep 2022 23:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D280353
        for <fstests@vger.kernel.org>; Thu,  8 Sep 2022 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662695398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIEE6kz3SztGeVUo60FyiwAb7oFAk4fbNUq+K1q/6WQ=;
        b=JsHJcGF4yc7vjHapGrHdZd4Fzh/MHg34hcs0aCnekIA6DOjkXlXcW7wsA6Aro30cVvC2Hm
        SraI/ymkQVPjmS5OUg7GOJX+r0LggHTWUwsYn3MM4G3Qp36zF6WD+wHDvSBsVrQnF6GrkY
        P5jkujSJwBNMI91ccNhCwdoNlvGzlGU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-zPR_QMcMPRCUvf_yzIvMcg-1; Thu, 08 Sep 2022 23:49:56 -0400
X-MC-Unique: zPR_QMcMPRCUvf_yzIvMcg-1
Received: by mail-qk1-f200.google.com with SMTP id u15-20020a05620a0c4f00b006b8b3f41303so475903qki.8
        for <fstests@vger.kernel.org>; Thu, 08 Sep 2022 20:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SIEE6kz3SztGeVUo60FyiwAb7oFAk4fbNUq+K1q/6WQ=;
        b=ecrWMVW1DFCW2t4y65jYJq0cR7/MgAikkCwZGmbBvOtLgf+sz05fdCGfS00raNgHUQ
         MoHe2lblb4QnuxYL+lAoiGrdvnJRGZgWzT1HtKTbYV1Tgd+wmetZQhxihHvclek09sJU
         xTsrp4bhL5twRV+Oj+/iZ8sE1wHKcdGAA2C5RTElqS766BHdZbUxFKVExEP+l26firfE
         6ucxUQkaTzU03F9v/v6TcLAcoaWuEuWk/YAExH96pNt1vM3kjETXzVQK976S0uUZ6b2y
         wT7knDEeXzFlLo7HoJqd1VYxC0G4i10JkbpcWlgJrIusenJwv3iEbGG0AlzIm6s+9219
         pNKg==
X-Gm-Message-State: ACgBeo2AUMGxndhWLypyoyia9DOBbbSuFOB0lDOMLB8q9AfIIYn4D1Z5
        +TdXGZxNxXCJcdPzpndj4dIFOzpB4zJEtLMb+Da4drEKiLer3nXwNRg1CwdJ2Nd3DQg9G3JV7O6
        AI0XXDgo4cLc/4bMaYQ==
X-Received: by 2002:ac8:5884:0:b0:344:6d9a:1e43 with SMTP id t4-20020ac85884000000b003446d9a1e43mr10949640qta.623.1662695395514;
        Thu, 08 Sep 2022 20:49:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7URkQbojkMs5zIneOYuLkrk3ZZqEuhzrE23f/dtoQF4unn2S0G+Gv3XLH2feDo05XvXWuCIA==
X-Received: by 2002:ac8:5884:0:b0:344:6d9a:1e43 with SMTP id t4-20020ac85884000000b003446d9a1e43mr10949630qta.623.1662695395168;
        Thu, 08 Sep 2022 20:49:55 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j8-20020ac85f88000000b0035a70a25651sm794977qta.55.2022.09.08.20.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 20:49:54 -0700 (PDT)
Date:   Fri, 9 Sep 2022 11:49:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] xfs: test xfs_quota's 'dump' and 'report' -L/-R range
 parameters
Message-ID: <20220909034950.pxim3itf6qiusidl@zlang-mailbox>
References: <20220805172531.520862-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805172531.520862-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 05, 2022 at 07:25:31PM +0200, Andrey Albershteyn wrote:
> These parameters define ID range of users/groups/projects to show.
> This test adds more checks for wider coverage (e.g. empty range,
> full range, open range).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
> 
> This is regression test in relation to the patch [1].

If this's a regression test case for a specific patchset, will it fail
on the kernel without this patchset?

> 
> Changes from v1:
>  - Moved to separate test (initially added to 152)
> Changes from v2:
>  - sed expression simplification
>  - remove _filter_trailing_spaces() from common/filter
>  - easier to read test cases
> 
> [1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/
> 
> ---
>  tests/xfs/550     | 169 +++++++++++++++++++++++++++++++++
>  tests/xfs/550.out | 232 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 401 insertions(+)
>  create mode 100755 tests/xfs/550
>  create mode 100644 tests/xfs/550.out
> 
> diff --git a/tests/xfs/550 b/tests/xfs/550
> new file mode 100755
> index 00000000..1fc1d37c
> --- /dev/null
> +++ b/tests/xfs/550
> @@ -0,0 +1,169 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Andrey Albershteyn <aalbersh@redhat.com>.
> +# All Rights Reserved.
> +#
> +# FS QA Test 550
> +#
> +# Test xfs_quota -L/-U range parameters for report and dump commands. These
> +# parameters define ID range of users/groups/projects with non-zero quota to
> +# show.
> +#
> +. ./common/preamble
> +_begin_fstest quick quota

Can it be in "auto" group?

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_scratch_unmount >/dev/null 2>&1

Why a _scratch_unmount is needed at here? I think this case doesn't need
a specific _cleanup.

> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_test

I didn't see this case need TEST_DIR, so this requirement might be useless

> +_require_scratch
> +_require_xfs_quota
> +_require_user fsgqa
> +_require_user fsgqa2
> +_require_group fsgqa
> +_require_group fsgqa2
> +
> +_scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
> +
> +uqid=`id -u fsgqa`
> +gqid=`id -g fsgqa`
> +
> +uqid2=`id -u fsgqa2`
> +gqid2=`id -g fsgqa2`
> +
> +[ $uqid -ge $uqid2 ] && _notrun \
> +	"ID of fsgqa user ($uqid) expected to be lower than fsgqa2 ($uqid2)"
> +[ $gqid -ge $gqid2 ] && _notrun \
> +	"ID of fsgqa group ($gqid) expected to be lower than fsgqa2 ($gqid2)"
> +
> +pqid=10
> +pqid2=42
> +cat >$tmp.projects <<EOF
> +$pqid:$SCRATCH_MNT
> +$pqid2:$SCRATCH_MNT
> +EOF
> +
> +cat >$tmp.projid <<EOF
> +root:0
> +fsgqa:$pqid
> +fsgqa2:$pqid2
> +EOF
> +
> +filter_dump()
> +{
> +	_filter_scratch | sed -e 's/^[0-9]\+/#ID/' -e 's/\s*$//'
> +}
> +
> +filter_report()
> +{
> +	_filter_quota | sed -e '/^root/d' \
> +				-e '/^#0/d' \
> +				-e 's/^#[0-9]\+/#ID/' \
> +				-e 's/\s*$//'
> +}
> +
> +set_quota_limit()
> +{
> +	local bs=$1
> +	local bh=$2
> +	local is=$3
> +	local ih=$4
> +	local user=$5
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "limit -$type bsoft=$bs bhard=$bh $user" \
> +			-c "limit -$type isoft=$is ihard=$ih $user" \
> +			$SCRATCH_MNT
> +}
> +
> +test_dump()
> +{
> +	local description=$1 ; shift
> +	local opt="$*"
> +
> +	echo "Options: $description"
> +
> +	rm -f $tmp.backup 2>>/dev/null
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "dump -$type $opt -f $tmp.backup" \
> +			$SCRATCH_MNT | _filter_scratch
> +	cat $tmp.backup | filter_dump
> +}
> +
> +test_report()
> +{
> +	local description=$1 ; shift
> +	local opt="$*"
> +
> +	echo "Options: $description"
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "report -$type $opt -bi" \
> +			$SCRATCH_MNT | filter_report
> +}
> +
> +test_xfs_quota()
> +{
> +	set_quota_limit 512k 2048k 10 20 $id
> +	set_quota_limit 1024k 4096k 10 20 $id2
> +
> +	echo "dump options test (type=$type)"
> +	test_dump "no options (full range)"
> +	test_dump "-L option" -L $id
> +	test_dump "-U option" -U $id
> +	test_dump "-L/-U options (one element range)" -L $id -U $id
> +	test_dump "-L/-U options (multiple elements range)" -L $id -U $id2
> +	test_dump "-L/-U options (empty range)" -L $id2 -U $id
> +	test_dump "-L/-U options (full range)" -L 0 -U 0
> +
> +	echo "report options test (type=$type)"
> +	test_report "no options (full range)"
> +	test_report "-L options" -L $id
> +	test_report "-U options" -U $id
> +	test_report "-L/-U options (one element range)" -L $id -U $id
> +	test_report "-L/-U options (multiple elements range)" -L $id -U $id2
> +	test_report "-L/-U options (empty range)" -L $id2 -U $id
> +	test_report "-L/-U options (full range)" -L 0 -U 0
> +}
> +
> +echo "Checking User quota"
> +_scratch_unmount >/dev/null 2>&1
> +_qmount_option "uquota"
> +_try_scratch_mount || _fail "qmount failed"

Why not use "_qmount" directly? (same below)

Thanks,
Zorro

> +type=u
> +id=$uqid
> +id2=$uqid2
> +test_xfs_quota
> +
> +echo "Checking Group quota"
> +_scratch_unmount >/dev/null 2>&1
> +_qmount_option "gquota"
> +_try_scratch_mount || _fail "qmount failed"
> +type=g
> +id=$gqid
> +id2=$gqid2
> +test_xfs_quota
> +
> +echo "Checking Project quota"
> +_scratch_unmount >/dev/null 2>&1
> +_qmount_option "pquota"
> +_try_scratch_mount || _fail "qmount failed"
> +type=p
> +id=$pqid
> +id2=$pqid2
> +test_xfs_quota
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/550.out b/tests/xfs/550.out
> new file mode 100644
> index 00000000..d98166c4
> --- /dev/null
> +++ b/tests/xfs/550.out
> @@ -0,0 +1,232 @@
> +QA output created by 550
> +Checking User quota
> +dump options test (type=u)
> +Options: no options (full range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -L option
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -U option
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +Options: -L/-U options (one element range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +Options: -L/-U options (multiple elements range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +report options test (type=u)
> +Options: no options (full range)
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L options
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -U options
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (one element range)
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (multiple elements range)
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +User quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Checking Group quota
> +dump options test (type=g)
> +Options: no options (full range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -L option
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -U option
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +Options: -L/-U options (one element range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +Options: -L/-U options (multiple elements range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +fs = SCRATCH_DEV
> +#ID          1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID          2048    8192      10      20
> +report options test (type=g)
> +Options: no options (full range)
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L options
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -U options
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (one element range)
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (multiple elements range)
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +Group quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Checking Project quota
> +dump options test (type=p)
> +Options: no options (full range)
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID            2048    8192      10      20
> +Options: -L option
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID            2048    8192      10      20
> +Options: -U option
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +Options: -L/-U options (one element range)
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +Options: -L/-U options (multiple elements range)
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID            2048    8192      10      20
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +fs = SCRATCH_DEV
> +#ID            1024    4096      10      20
> +fs = SCRATCH_DEV
> +#ID            2048    8192      10      20
> +report options test (type=p)
> +Options: no options (full range)
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +fsgqa 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +fsgqa2 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L options
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -U options
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (one element range)
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (multiple elements range)
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> +Options: -L/-U options (empty range)
> +Options: -L/-U options (full range)
> +Project quota on SCRATCH_MNT (SCRATCH_DEV)
> + Blocks Inodes
> +Project ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace
> +---------- -------------------------------------------------- --------------------------------------------------
> +#ID 0 512 2048 00 [--------] 0 10 20 00 [--------]
> +#ID 0 1024 4096 00 [--------] 0 10 20 00 [--------]
> +
> -- 
> 2.31.1
> 

