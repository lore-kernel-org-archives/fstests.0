Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88957C636D7
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBRGIK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRGIK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127C4CCB4
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676700444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/GpxMDv7qFvdTtq4jRoWcv7jL8hnwE4tcMrAJRFw78=;
        b=VjpOcmlBqzhMJ2fH1ZoEzzAYXJ2dABwMVxtDgNNpey1jHptBDczXzJ9SnUIcDp8WwtZFBu
        9Af+gOUV14wnm+MMvJ0Rz/+OW3cd4+XY9C32xVUuMRM5ITpNvdtARHqnUxlNRZPQZTYDNn
        uYmMmCHpEsNDhAv4MLudwis/TM4gVoI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-UDWEQe0mPWmYXA8O39j2vA-1; Sat, 18 Feb 2023 01:07:22 -0500
X-MC-Unique: UDWEQe0mPWmYXA8O39j2vA-1
Received: by mail-pj1-f72.google.com with SMTP id m7-20020a17090ab78700b00234c1d817a3so639350pjr.0
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/GpxMDv7qFvdTtq4jRoWcv7jL8hnwE4tcMrAJRFw78=;
        b=2ck4tGYzy3F7KS1L3Mzi+KPx/PEVNF7QLlIiwaMuWB1PZD5eeAq6IVybLLuCMBouCr
         AiCAcAeaHuNO+n4fnV7i4OHd4N9zmuHeO1X0c0qPtCIn/qXL3mH3H9AOnoSXn9e0zIv0
         o3+lF+tolGW3qafDsFuEqNOsWMm3NmWptls9EUfGfBQA58Bm/kY8TdnBB7F6VqTvnrcx
         7tdiJHEGVsJFMY30FfITC06x/IHXyPAq7JwPfpaJUBGeHpPNJDzVvtj/GxHTBmo173Wp
         deJqP8tfSQ8/FrKPENP752S1QwFnkW4ABBdTejwqmJ1jdvo8sKhpui4LULFhHSMuHK6H
         Rf3A==
X-Gm-Message-State: AO0yUKWYdHwgSX/dAbyALmXXaZiwBmw7EUU3xO4hSRy0dvwaCEnKguKy
        QLVRmVuNuE1OaUBeqBmyqAPlsN7u4uSdbcoM1u0TepyIA2UF993JEyqFgTGv2ykxaTqQ+Ea2KL4
        athWz8aV1EoDhvAeosg==
X-Received: by 2002:a05:6a20:4c24:b0:c7:885b:450b with SMTP id fm36-20020a056a204c2400b000c7885b450bmr3640266pzb.22.1676700441514;
        Fri, 17 Feb 2023 22:07:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/47HuGTzypFk1BnZTHO9PIr/tjNOtLG8Vj22I0/T/FdBdiiZGz/75BjncYKMhLKvELuX9edA==
X-Received: by 2002:a05:6a20:4c24:b0:c7:885b:450b with SMTP id fm36-20020a056a204c2400b000c7885b450bmr3640252pzb.22.1676700441081;
        Fri, 17 Feb 2023 22:07:21 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b0019b06263bdasm3211899pln.69.2023.02.17.22.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:07:20 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:07:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: race fsstress with online repair for inode
 record metadata
Message-ID: <20230218060716.amsvpbd3ujq5uyds@zlang-mailbox>
References: <167243875538.724875.4064833218427202716.stgit@magnolia>
 <167243875550.724875.35173902093167169.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243875550.724875.35173902093167169.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:15PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a test that runs the inode record repairer in the foreground and
> fsstress in the background.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

LGTM,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/806     |   38 ++++++++++++++++++++++++++++++++++++++
>  tests/xfs/806.out |    2 ++
>  2 files changed, 40 insertions(+)
>  create mode 100755 tests/xfs/806
>  create mode 100644 tests/xfs/806.out
> 
> 
> diff --git a/tests/xfs/806 b/tests/xfs/806
> new file mode 100755
> index 0000000000..e07f9f9141
> --- /dev/null
> +++ b/tests/xfs/806
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle. Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 806
> +#
> +# Race fsstress and inode record repair for a while to see if we crash or
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
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_scratch
> +_require_xfs_stress_online_repair
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount
> +_scratch_xfs_stress_online_repair -s "repair inode" -t "%file%"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/806.out b/tests/xfs/806.out
> new file mode 100644
> index 0000000000..463bd7f008
> --- /dev/null
> +++ b/tests/xfs/806.out
> @@ -0,0 +1,2 @@
> +QA output created by 806
> +Silence is golden
> 

