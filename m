Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E5C41513
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 19:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHNTQn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjHNTQl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 15:16:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9AB5
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 12:16:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76c4890a220so373702585a.3
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692040599; x=1692645399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkXgHi/kG4AJDV5Gi14STKJ/RXiXIBzuLRpbMbfpJ9Q=;
        b=VyikS5sS6FQ1Wg47WLPoK/Wcr+CPT4Zl0A59gLCaIa3X7cZTn9rqn00iPBrEKH0ci7
         97SzRafP1T5stFqqq9rixchA7y2tgjR2yKCHsDRFeiEeoqeCEATIFKCVFW7o9c6aVOqo
         TLIiumxaqypoT8pTGHqdXYb+LikWZh2Tne7Wk+WdPB0qLc7SIrboIiwHgn0wv9BngrM5
         Ilxt4jikotESNhVfz0rdITTUKxFM2LPsfE9H3u5/vhM4EyNJGE2IrEiagL1GTPq8tODH
         G8eYql1Rhm2A8NKNk0cTBDtNv2q3d4Ej40BgyYShOpkjDh//uM6CvoXThHlZVg36v7kC
         kNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040599; x=1692645399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkXgHi/kG4AJDV5Gi14STKJ/RXiXIBzuLRpbMbfpJ9Q=;
        b=NLw5dGM9F+2GkzDLvZkevz0n3LzsZtLTKYByL6DUaL1sArM5X2IUmDjBZqU+1lRcpz
         bhA9xJW9D6Z/naQQLseSEWg0yqkYpI5yi1FaL3EA/ZIAqNmwyyiAwKOfEaCw+enhPFhc
         TBgJaiIFIxdm1SlAflNILygzSzMcnH3RMwpscwYMYMKvhlSAgq0Ussen3AQGLwxfr/DU
         XbmoWwnH0TE/IBs/8blvmTYj1zBY/sYpR0HSwxy0mJXf1lNwe8EpTtNw14ZLLfyD7Ymj
         lncT4RUMJS80vze/uGNTwJYaKPGjAUwEfMOM/m5zPDWELlAmUJIXbaD+IbL9Ag4V/JF/
         Yvjw==
X-Gm-Message-State: AOJu0YxZDBGKjsIkB+/F6hGxlVusWgmIwVoSCbs55TRt+PdIPiZl04cx
        e0ZK3KTOjKy13BX3814mzmSPCBY1eG9Xwn/S8G4kbw==
X-Google-Smtp-Source: AGHT+IF0dn1q1loimYlafRTio8MdXf6bEGK7RykJvPguNK8q6+rzEypg4pAJYZPl5ECbLBLP+yg1NA==
X-Received: by 2002:a05:620a:4052:b0:767:27c8:968d with SMTP id i18-20020a05620a405200b0076727c8968dmr13473215qko.6.1692040599103;
        Mon, 14 Aug 2023 12:16:39 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i26-20020a05620a145a00b00767cdf23ee3sm3227235qkl.92.2023.08.14.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:16:38 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:16:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: Vertify dir permissions when creating a stub
 subvolume
Message-ID: <20230814191637.GA2832769@perftesting>
References: <20230814051342.3245942-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814051342.3245942-1-lee@trager.us>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 13, 2023 at 10:13:42PM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
> common/rc           |  6 ++++++
>  tests/btrfs/300     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++++
>  tests/overlay/020   |  7 +------
>  4 files changed, 71 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..ca7c5c14 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,12 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +
> +_require_unshare() {
> +	unshare -f -r -m -p -U  true &>/dev/null || \
> +		_notrun "unshare $@: not found, should be in util-linux"
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..c86ed268
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol snapshot
> +
> +_supported_fs btrfs
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +_register_cleanup "cleanup"
> +
> +test_dir="${TEST_DIR}/$(basename $0)"
> +cleanup() {
> +    [ -d "$test_dir" ] && rm -rf $test_dir
> +}
> +
> +mkdir $test_dir
> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshare
> +# sets the namespace for the running shell. The test must run in one user
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};
> +unshare --user --keep-caps --map-auto --map-root-user;
> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"
> +
> +find $test_dir -printf "%M %u %g %P\n"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 00000000..33b5fb44
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,18 @@
> +QA output created by 300
> +Create subvolume './subvol'
> +Create subvolume 'subvol/subsubvol'
> +Create a snapshot of 'subvol' in './snapshot'
> +drwxr-xr-x fsgqa fsgqa 

There's an extra whitespace here, did it come from the output or is it
extraneous?  Either way it should probably be removed.  Thanks,

Josef
