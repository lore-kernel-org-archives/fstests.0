Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB1C71133
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 02:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHXCgp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbjHXCgR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 22:36:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A711AD
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 19:36:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf3a2f4528so47075985ad.2
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 19:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1692844575; x=1693449375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cedzSAQRLYYaUxuY+nXHDTj0LDSIDM59U0UKTxK3qqs=;
        b=J2iiClNZOQmbjTboRWEFMw3vEmoHKYHRDHrFX31V4I8jbeIZbCxi4JGm/JnxDTMdy9
         zXOrGaP2JMC/wBvg3bqiMy+FY4dHexqA205AZ9tFiDK8gWiUWpK447xLBLHhmGfdjYi8
         KQt+kUCRT4rkaQJTjJL5PdrIDNBkMr6sKq6Qp+ojVt5GVPiJB16BMZPLMRQ6ZBQ2Mz6Q
         H6DEWEvoYh1Hy62NkDr40tdzI60Q5qkVJdjHRs91pxW6YPS4rVvi5dWsScyN7HDrSiFb
         QUv0BfZPJBj0EuxHaxHUC3XRpp2QVJBiu0lGhKh73FKJzLns1aK0/MuqIYF0XZgPaN3e
         ynGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844575; x=1693449375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cedzSAQRLYYaUxuY+nXHDTj0LDSIDM59U0UKTxK3qqs=;
        b=Rf81c6hjhZhUs8gk/iby94hpk3obqpF0Q9aG8EH8+BqlQfK0UImSLLLSN1OkTG33vL
         yDlr5WabvtSL7w8kOlADtkS2BHVWO7/yGyscWJf1WsFWy0nZ9nnTPLKqKqhDA1R4t95R
         Hx8Rg0YCy7kqR47Y36x7XxOTIkf9M7XZyA/lCmAtLQEsba7ZVo63CLGRkChc9MZeliDK
         XIAqeVOLfcG8Y7sB/6CULEJhxfhmfbbgyKU62a6qQU392Kia+vNrV+ivcEQzu08k6vFD
         sxWa1jtLt3/KEantMxQqX51u26bn52pBaqdPhxGQXUC8fxTu2WhWDGyuqtDfZS08A3wH
         nTqA==
X-Gm-Message-State: AOJu0YwVqIwT0LBEW91N1izBL1nppOijwHNjhBabOS809tiQRElSTvR7
        NkN65iVN4dGHpeKB1Zj4S/Ddqg==
X-Google-Smtp-Source: AGHT+IFcxGHbXw5mW+tQpun+4PtOSUCeA1GWGwAXElkbN1qkbok8QcqHgk3yFp0jILD+gzqvLr72PQ==
X-Received: by 2002:a17:902:e80e:b0:1bf:423:957b with SMTP id u14-20020a170902e80e00b001bf0423957bmr19269422plg.26.1692844574975;
        Wed, 23 Aug 2023 19:36:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001b016313b1dsm11644840plb.86.2023.08.23.19.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:36:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qZ0Ch-005hxt-2p;
        Thu, 24 Aug 2023 12:36:11 +1000
Date:   Thu, 24 Aug 2023 12:36:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH] fstests: test fix for an agbno overflow in
 __xfs_getfsmap_datadev
Message-ID: <ZObCG2iRTPr9wKuI@dread.disaster.area>
References: <20230823010046.GD11286@frogsfrogsfrogs>
 <20230823010239.GE11263@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823010239.GE11263@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 22, 2023 at 06:02:39PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Dave Chinner reported that xfs/273 fails if the AG size happens to be an
> exact power of two.  I traced this to an agbno integer overflow when the
> current GETFSMAP call is a continuation of a previous GETFSMAP call, and
> the last record returned was non-shareable space at the end of an AG.
> 
> This is the regression test for that bug.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/935     |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/935.out |    2 ++
>  2 files changed, 57 insertions(+)
>  create mode 100755 tests/xfs/935
>  create mode 100644 tests/xfs/935.out
> 
> diff --git a/tests/xfs/935 b/tests/xfs/935
> new file mode 100755
> index 0000000000..a06f2fc8dc
> --- /dev/null
> +++ b/tests/xfs/935
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 935
> +#
> +# Regression test for an agbno overflow bug in XFS GETFSMAP involving an
> +# fsmap_advance call.  Userspace can indicate that a GETFSMAP call is actually
> +# a continuation of a previous call by setting the "low" key to the last record
> +# returned by the previous call.
> +#
> +# If the last record returned by GETFSMAP is a non-shareable extent at the end
> +# of an AG and the AG size is exactly a power of two, the startblock in the low
> +# key of the rmapbt query can be set to a value larger than EOAG.  When this
> +# happens, GETFSMAP will return EINVAL instead of returning records for the
> +# next AG.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick fsmap
> +
> +. ./common/filter
> +
> +_fixed_by_git_commit kernel XXXXXXXXXXXXX \
> +	"xfs: fix an agbno overflow in __xfs_getfsmap_datadev"
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_xfs_io_command fsmap
> +_require_xfs_scratch_rmapbt
> +
> +_scratch_mkfs | _filter_mkfs 2> $tmp.mkfs >> $seqres.full
> +source $tmp.mkfs
> +
> +# Find the next power of two agsize smaller than whatever the default is.
> +for ((p = 31; p > 0; p--)); do
> +	desired_agsize=$((2 ** p))
> +	test "$desired_agsize" -lt "$agsize" && break
> +done
> +
> +echo "desired asize=$desired_agsize" >> $seqres.full
                 agsize

Otherwise looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
