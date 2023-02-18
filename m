Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66201C636D7
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBRGNQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRGNP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507125E02
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676700747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJ2UNpwUhKlTpkBny6N3Ttv/bcvyUY8/AGG3V8QUGWU=;
        b=YD5CEne9ciIt/aixQtCUGfTTfoEAqlL7Fy/2ykwFV3sCK6Lgxb3Y3g8pw13TVcL4eOPnPh
        nWKvvnvDbdcQ0+JHH7N5bnI0sNJls8iMThCa7s4xRswH/qGhKrmwdjwzW0e4Slbvr6wuR3
        SfwWzyAg/ePKZ5K/Sh8hw/4iJ1bukoI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-zEYJewJ-NCeoXT4k0az_0g-1; Sat, 18 Feb 2023 01:12:25 -0500
X-MC-Unique: zEYJewJ-NCeoXT4k0az_0g-1
Received: by mail-pl1-f199.google.com with SMTP id d18-20020a170902729200b0019ac5d9fdb3so109468pll.9
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ2UNpwUhKlTpkBny6N3Ttv/bcvyUY8/AGG3V8QUGWU=;
        b=350nDuaXhTEh1FEEyqZCDqOHkk5Tsqf4v28s+GFrl8+rBh0P6jXX9jgshNx0BHN62U
         EU8HU6Evb+ewZJa1fgovqu+Rq5FPUAmzujk99hNBCqnYzWtIgbxXL5IuF/FBgUEGkvLg
         gTFqeEFPSCbeAzOahJCc0L7QFTUN37Q7pMu+/qZ9+mjRWsOhrKPqqyBpQ6+FHOx2aqtE
         B1XOxb9DouhXT2UGwTv9Q+cIsrocHspY2+fQ7ltVeMkkU+yYuOSCMdEWfDHJkN5Oct+r
         ulgRNMXqh1ImrShZcVIXqf5QjFzqbLdNtC941yao/UzFP1ciLOjWyGdU2CaAGQvEuEkv
         Xnzw==
X-Gm-Message-State: AO0yUKUwQmc23n90f8M5MeWJN6uMjeuBeUB5PQc8DvBsyySQt4FmItmH
        OxHPfDF70BXlTgDN5lmMnhTEoKqAgEjudxGZJFNKnZqJtRArJbB6GdqcK2HePL4FBh4AOe2Rvdd
        kq6nPRng3IqA5Mk+C1oxZRpxZ5A==
X-Received: by 2002:a17:902:7845:b0:19b:2332:18cb with SMTP id e5-20020a170902784500b0019b233218cbmr295582pln.1.1676700744554;
        Fri, 17 Feb 2023 22:12:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/PeyCZw+lPD/qnB1SDtCuAuak2cMXPyEbMEzgOpor5sik1avB6A6EHw2DUmm/kh38IMx/XYg==
X-Received: by 2002:a17:902:7845:b0:19b:2332:18cb with SMTP id e5-20020a170902784500b0019b233218cbmr295571pln.1.1676700744129;
        Fri, 17 Feb 2023 22:12:24 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r6-20020a170902be0600b00198b0fd363bsm4022720pls.45.2023.02.17.22.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:12:23 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:12:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: race fsstress with online scrub and repair for
 quota metadata
Message-ID: <20230218061220.4vhtu5mw7yemwi52@zlang-mailbox>
References: <167243876170.726678.17872891128076933126.stgit@magnolia>
 <167243876182.726678.5993728572164871488.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243876182.726678.5993728572164871488.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:21PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create tests to race fsstress with dquot repair while running fsstress
> in the background.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/809     |   40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/809.out |    2 ++
>  tests/xfs/810     |   40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/810.out |    2 ++
>  tests/xfs/811     |   40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/811.out |    2 ++
>  6 files changed, 126 insertions(+)
>  create mode 100755 tests/xfs/809
>  create mode 100644 tests/xfs/809.out
>  create mode 100755 tests/xfs/810
>  create mode 100644 tests/xfs/810.out
>  create mode 100755 tests/xfs/811
>  create mode 100644 tests/xfs/811.out
> 
> 
> diff --git a/tests/xfs/809 b/tests/xfs/809
> new file mode 100755
> index 0000000000..35ac02ff85
> --- /dev/null
> +++ b/tests/xfs/809
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 809
> +#
> +# Race fsstress and user quota repair for a while to see if we crash or
> +# livelock.
> +#
> +. ./common/preamble
> +_begin_fstest online_repair dangerous_fsstress_repair
> +
> +_cleanup() {
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_require_xfs_quota_acct_enabled "$SCRATCH_DEV" usrquota
> +_scratch_xfs_stress_online_repair -s "repair usrquota"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/809.out b/tests/xfs/809.out
> new file mode 100644
> index 0000000000..e90865ca8f
> --- /dev/null
> +++ b/tests/xfs/809.out
> @@ -0,0 +1,2 @@
> +QA output created by 809
> +Silence is golden
> diff --git a/tests/xfs/810 b/tests/xfs/810
> new file mode 100755
> index 0000000000..7387910504
> --- /dev/null
> +++ b/tests/xfs/810
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 810
> +#
> +# Race fsstress and group quota repair for a while to see if we crash or
> +# livelock.
> +#
> +. ./common/preamble
> +_begin_fstest online_repair dangerous_fsstress_repair
> +
> +_cleanup() {
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_require_xfs_quota_acct_enabled "$SCRATCH_DEV" grpquota
> +_scratch_xfs_stress_online_repair -s "repair grpquota"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/810.out b/tests/xfs/810.out
> new file mode 100644
> index 0000000000..90f12fdd21
> --- /dev/null
> +++ b/tests/xfs/810.out
> @@ -0,0 +1,2 @@
> +QA output created by 810
> +Silence is golden
> diff --git a/tests/xfs/811 b/tests/xfs/811
> new file mode 100755
> index 0000000000..1e13940b46
> --- /dev/null
> +++ b/tests/xfs/811
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 811
> +#
> +# Race fsstress and project quota repair for a while to see if we crash or
> +# livelock.
> +#
> +. ./common/preamble
> +_begin_fstest online_repair dangerous_fsstress_repair
> +
> +_cleanup() {
> +	_scratch_xfs_stress_scrub_cleanup &> /dev/null
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +_register_cleanup "_cleanup" BUS
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/inject
> +. ./common/xfs
> +. ./common/quota
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_require_xfs_quota_acct_enabled "$SCRATCH_DEV" prjquota
> +_scratch_xfs_stress_online_repair -s "repair prjquota"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/811.out b/tests/xfs/811.out
> new file mode 100644
> index 0000000000..cf30f69bdc
> --- /dev/null
> +++ b/tests/xfs/811.out
> @@ -0,0 +1,2 @@
> +QA output created by 811
> +Silence is golden
> 

