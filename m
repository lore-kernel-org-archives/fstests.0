Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FFC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 17:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiDMR65 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDMR6z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 13:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 401D93CA64
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649872592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6GEJ15mSukq/QKFETshzTgLJN1QsdHySvSu59mh3rw=;
        b=US1dowM3GiYe3VzX188tZ8tA1Z9flu7vlPDyFnZn1LiF8ngkheBWtlfdfgqrgBfSf/VXBE
        t8U0xKM5mn8tjwq2VBU3Fpk2+TjzwICH0UIyHwBVSubQWyZVYyetFTGLfdeUcAPQlGeSUI
        ZNjU/CI21d5NH3gJtHuFdxHK/x93elc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-v7HW-HPaNsCk-n6M4VfAag-1; Wed, 13 Apr 2022 13:56:31 -0400
X-MC-Unique: v7HW-HPaNsCk-n6M4VfAag-1
Received: by mail-qt1-f198.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso1741386qtc.12
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 10:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=J6GEJ15mSukq/QKFETshzTgLJN1QsdHySvSu59mh3rw=;
        b=A8oO9iqruXWWIjPlCYuzMRO3i4eU+fOsNeJbyWli55SlVrotrVEq0cFPIquDbvQybO
         cH0Tu7eyf/u1aa3RHalpAKkGUsALmWVBGdUp0FxeuMRfPL+usxqCiUhVhNU9WT1A/xrt
         p3TPPwoIBwNNqhoomVQynmXXCZfFRcXbfci43BFIAqguLHJXfOZ4jzqCvMEsKwmShkxg
         GrVwkyhdse6kxCutebXowuBxDMzVRJ/FguFTqaT4xVkTN1SVh9jMnC5QPQbL7s2A9tgr
         DcDHyvKX7gNwVjs7IvNoue3BVJ9fAMqujiB6RsQLgt1Vd1wbhyBaxJ5o9JvgNjDe+NJI
         eVVA==
X-Gm-Message-State: AOAM533ywDr37po6/WyrBGRpLYLuwJXL0EsMYn74wWBqdEpEjgThmNJx
        zT/gGDlwSfiMfeigSeeXQMcsmnPEFb3AStTEoevQDUo5w2a9aSOC4jZymMG3qnbFI687Ms2pZT4
        UOk3DOYCk0stWGJfOmg==
X-Received: by 2002:a05:6214:4016:b0:446:1677:7913 with SMTP id kd22-20020a056214401600b0044616777913mr3267351qvb.56.1649872590713;
        Wed, 13 Apr 2022 10:56:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3/flYx5mq4UQ81YOgoIrVlnM/fEIVExFAsM7nxYwJIqECn8WzhE5vnjid6pv4brFtpq307w==
X-Received: by 2002:a05:6214:4016:b0:446:1677:7913 with SMTP id kd22-20020a056214401600b0044616777913mr3267335qvb.56.1649872590461;
        Wed, 13 Apr 2022 10:56:30 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm8509338qth.88.2022.04.13.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:56:29 -0700 (PDT)
Date:   Thu, 14 Apr 2022 01:56:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: test mkfs.xfs config file stack corruption
 issues
Message-ID: <20220413175623.imxaab7hqpiw723g@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971769710.170109.8985299417765876269.stgit@magnolia>
 <164971770833.170109.18299545219088346786.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971770833.170109.18299545219088346786.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 03:55:08PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new regression test for a stack corruption problem uncovered in
> the mkfs config file parsing code.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/831     |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/831.out |    2 ++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/xfs/831
>  create mode 100644 tests/xfs/831.out
> 
> 
> diff --git a/tests/xfs/831 b/tests/xfs/831
> new file mode 100755
> index 00000000..a73f14ff
> --- /dev/null
> +++ b/tests/xfs/831
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 831
> +#
> +# Regression test for xfsprogs commit:
> +#
> +# 99c78777 ("mkfs: prevent corruption of passed-in suboption string values")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mkfs
> +
> +_cleanup()
> +{
> +	rm -f $TEST_DIR/fubar.img
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_require_test
> +_require_xfs_mkfs_cfgfile
> +
> +# Set up a configuration file with an exact block size and log stripe unit
> +# so that mkfs won't complain about having to correct the log stripe unit
> +# size that is implied by the provided data device stripe unit.
> +cfgfile=$tmp.cfg
> +cat << EOF >> $tmp.cfg
> +[block]
> +size=4096
> +
> +[data]
> +su=2097152
> +sw=1
> +EOF
> +
> +# Some mkfs options store the user's value string for processing after certain
> +# geometry parameters (e.g. the fs block size) have been settled.  This is how
> +# the su= option can accept arguments such as "8b" to mean eight filesystem
> +# blocks.
> +#
> +# Unfortunately, on Ubuntu 20.04, the libini parser uses an onstack char[]
> +# array to store value that it parse, and it passes the address of this array
> +# to the parse_cfgopt.  The getstr function returns its argument, which is
> +# stored in the cli_params structure by the D_SU parsing code.  By the time we
> +# get around to interpreting this string, of course, the stack array has long
> +# since lost scope and is now full of garbage.  If we're lucky, the value will
> +# cause a number interpretation failure.  If not, the fs is configured with
> +# garbage geometry.
> +#
> +# Either way, set up a config file to exploit this vulnerability so that we
> +# can prove that current mkfs works correctly.
> +$XFS_IO_PROG -f -c "truncate 1g" $TEST_DIR/fubar.img
> +options=(-c options=$cfgfile -l sunit=8 -f -N $TEST_DIR/fubar.img)
> +$MKFS_XFS_PROG "${options[@]}" >> $seqres.full ||
> +	echo "mkfs failed"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/831.out b/tests/xfs/831.out
> new file mode 100644
> index 00000000..abe137e3
> --- /dev/null
> +++ b/tests/xfs/831.out
> @@ -0,0 +1,2 @@
> +QA output created by 831
> +Silence is golden
> 

