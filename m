Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACDEC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiDSTNS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357570AbiDSTNH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 15:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A803A72B
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650395423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19cH4W4To1Br5UnsbE+FKC3ZBPFHaTU/zK+fUeCYvFw=;
        b=J+Lk8WddqqrN3tKAwmrZyux5f+LRhvhaDhjpYvXqJTWFmzgaJ5sq+zAMCz755QwVhBNVOS
        JDfN4K/pXX+ccXqi/fvYINThARrwNDxKmSvpZ7p9+QE7k/KK5GTuBGGuVieskfuO4rgPxE
        C9SKBnpQLBd1D8tSZZpk45c7/bUbqs8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-1d4QZhUVM02IAQl6CHOAtw-1; Tue, 19 Apr 2022 15:10:22 -0400
X-MC-Unique: 1d4QZhUVM02IAQl6CHOAtw-1
Received: by mail-qv1-f70.google.com with SMTP id u7-20020a0cb407000000b00446687f0b1bso3837173qve.5
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 12:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=19cH4W4To1Br5UnsbE+FKC3ZBPFHaTU/zK+fUeCYvFw=;
        b=TnKzJhHSxu65pwZRbh6MhyPkMDMUFO523x/xym2T1C319XwnaA3mFm+M7fKONKYKvl
         zbau/0OHQwmjdL1KSY/7Ym6zN2V/F8+6XusN3O5LTmX3U/jmziL0K385uPQNvoGG9L0z
         INrgameVIkdMpqC1s7GSV8e12fsBjWCwxGnd0g1EyHZeh+3LdRUcBjYMgwU+aPaR5W3J
         nsCpSFUUYsBg32I5n5GjVm6q2/DZAcq6xMAoRdcUAWZLxmTldKEt2G9D5doV6tzHncM1
         Gai5PsmVVRhoAs0TTdhA5vuN95EhWoTW36Jqb3zK68qX5bpMZ92lDriV0eI0XXiKJRDL
         gDew==
X-Gm-Message-State: AOAM531M5pZCEghJTw5LA/BoirvJx0kNhoH4tInStPnjqPd8ou7BRTr0
        oAQVMj8FNNq7BhT1Wm9oxCeb597HYStBwwk1GH4OVehg/BArcd4ppC/g/VQzq+oPgJKEzFzEuVO
        Q6xyqIcTPUvr0l0Lj4w==
X-Received: by 2002:a05:620a:14b5:b0:69e:9ccf:de5e with SMTP id x21-20020a05620a14b500b0069e9ccfde5emr6941432qkj.596.1650395421537;
        Tue, 19 Apr 2022 12:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfobp7pxiFWTSQXAprt5jraScS1blZptaIiV8oRTcQqwohsOQmPnx61/u/l5UvndnQ89Kfqg==
X-Received: by 2002:a05:620a:14b5:b0:69e:9ccf:de5e with SMTP id x21-20020a05620a14b500b0069e9ccfde5emr6941421qkj.596.1650395421239;
        Tue, 19 Apr 2022 12:10:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020a05622a1a0b00b002f1f3b66bd4sm476691qtb.94.2022.04.19.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:10:20 -0700 (PDT)
Date:   Wed, 20 Apr 2022 03:10:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me, amir73il@gmail.com
Subject: Re: [PATCH 1/2] xfs: make sure syncfs(2) passes back
 super_operations.sync_fs errors
Message-ID: <20220419191014.ebcfzdbtg45fhg27@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, guaneryu@gmail.com,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        amir73il@gmail.com
References: <165038952992.1677711.6313258860719066297.stgit@magnolia>
 <165038953550.1677711.12931148474635467556.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165038953550.1677711.12931148474635467556.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 19, 2022 at 10:32:15AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This is a regression test to make sure that nonzero error returns from
> a filesystem's ->sync_fs implementation are actually passed back to
> userspace when the call stack involves syncfs(2).
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/839     |   42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/839.out |    2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/xfs/839
>  create mode 100644 tests/xfs/839.out
> 
> 
> diff --git a/tests/xfs/839 b/tests/xfs/839
> new file mode 100755
> index 00000000..9bfe93ef
> --- /dev/null
> +++ b/tests/xfs/839
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 839
> +#
> +# Regression test for kernel commits:
> +#
> +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> +#
> +# During a code inspection, I noticed that sync_filesystem ignores the return
> +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> +# that syncfs(2) does not capture internal filesystem errors that are neither
> +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> +# so that had to be corrected as well.
> +#
> +# The kernel commits above fix this problem, so this test tries to trigger the
> +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> +# hope that the EIO generated as a result of the filesystem being shut down is
> +# only visible via ->sync_fs.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick shutdown
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.

Good to me, we can help to add the missing "_supported_fs xfs", if you don't
like to send a new version for that again.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_require_xfs_io_command syncfs
> +_require_scratch_nocheck
> +_require_scratch_shutdown
> +
> +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> +# bother checking the filesystem afterwards since we never wrote anything.
> +_scratch_mount
> +$XFS_IO_PROG -x -c 'shutdown -f ' -c syncfs $SCRATCH_MNT
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/839.out b/tests/xfs/839.out
> new file mode 100644
> index 00000000..f275cdcc
> --- /dev/null
> +++ b/tests/xfs/839.out
> @@ -0,0 +1,2 @@
> +QA output created by 839
> +syncfs: Input/output error
> 

