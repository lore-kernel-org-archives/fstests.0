Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F750C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Nov 2022 16:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK3QqE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK3QqD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Nov 2022 11:46:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F18BD1A
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 08:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A28C161D08
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 16:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC55BC433C1
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669826761;
        bh=cDIoi5wF05wN/V+P7XyVOz7NZTBIAbkwqjpSQXIskww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MowQgtSUP4EAMtygvzsdUpBEYCO7a0gKypniB1FjOvhRRnHicHQXfxMl1GIGz4URp
         FAMwnhwkc8A7OKpN3x4Y+ufjY6oiI2P22H8TJPq4jlxrky4txxHVqVFwwHupBAEolr
         L8EZrXDptlzxjFzu13aSeWXBgARIR7Jnd7DqAB63kOgaiB0GtfOevlN9SoZHu/R1ob
         tmd3UyX2nO7Wd2qlT8+GkCC/ivrrDRWE7ag268ZkOqfOYuXVY4NSxb+DbyKDc1SzHc
         zMOkfi+4V0qutQRHiqpdwtwNBRlEh3tzn/dWo7LBPdPID4RKzzZgcvzY5RbQPEmWqI
         jr1QjaL+2YrwA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-142306beb9aso21628825fac.11
        for <fstests@vger.kernel.org>; Wed, 30 Nov 2022 08:46:00 -0800 (PST)
X-Gm-Message-State: ANoB5pkomKrjOQs5M3dqiOW1KMupdICs+GHw0O1cDkRkuAn8FPOMMdJU
        3JxamUkWFYZuGMuEDCGg3BL+rRz/poPwRzqng00=
X-Google-Smtp-Source: AA0mqf4TBcfknDR5vP5Fpzt6AiNq1MSfQLWi+FyO4gYIXPIDCJNE4LrU4dvOm5gd+T8oTz5yuJTIXJrgjJIbAVgh05A=
X-Received: by 2002:a05:6870:cc89:b0:12b:fbe7:b793 with SMTP id
 ot9-20020a056870cc8900b0012bfbe7b793mr36211493oab.92.1669826760052; Wed, 30
 Nov 2022 08:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20221130162239.27153-1-jack@suse.cz>
In-Reply-To: <20221130162239.27153-1-jack@suse.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 30 Nov 2022 16:45:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7O3NVOY0PD25wwuoyU5SWC7AqeGUwkDkY4kc1qz_6ovA@mail.gmail.com>
Message-ID: <CAL3q7H7O3NVOY0PD25wwuoyU5SWC7AqeGUwkDkY4kc1qz_6ovA@mail.gmail.com>
Subject: Re: [PATCH] generic/273: Limit number of files by available inodes
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 30, 2022 at 4:30 PM Jan Kara <jack@suse.cz> wrote:
>
> Test generic/273 is failing for ext4 with 1k blocksize because it is
> creating more files than we have available inodes. Just limit the number
> of files created to the number of inodes.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/273 | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/273 b/tests/generic/273
> index f86dae9b8095..80c02d43c7ac 100755
> --- a/tests/generic/273
> +++ b/tests/generic/273
> @@ -50,9 +50,16 @@ _file_create()
>
>         cd $SCRATCH_MNT/origin
>
> -       _disksize=`$DF_PROG -B 1 $SCRATCH_MNT | tail -1 | $AWK_PROG '{ print $5 }'`
> +       _disksize=$(_get_available_space $SCRATCH_MNT)
> +       _free_inodes=$(_get_free_inode $SCRATCH_MNT)

Jan, this will always return 0 on btrfs, since it has no limits on the
number of inodes, so it ends up not creating any files in the loop below.

We could call _require_inode_limits, but that would skip the test on btrfs.
Can we leave the old calculation if get_free_inode returns 0? (and
maybe leave a comment that a fs without inode limits returns 0)

Thanks.



> +       # Leave some slack for directories etc.
> +       _free_inodes=$(($_free_inodes - $_free_inodes/8))
>         _disksize=$(($_disksize / 3))
> -       _num=$(($_disksize / $count / $threads / $block_size))
> +       _num=$(($_disksize / $count / $block_size))
> +       if [ $_num -gt $_free_inodes ]; then
> +               _num=$_free_inodes
> +       fi
> +       _num=$(($_num/$threads))
>         _count=$count
>         while [ $_i -lt $_num ]
>         do
> --
> 2.35.3
>
