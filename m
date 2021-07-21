Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC9C07E9B
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 06:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F536024A
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 06:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhGUFY1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jul 2021 01:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhGUFYF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jul 2021 01:24:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600DC061574
        for <fstests@vger.kernel.org>; Tue, 20 Jul 2021 23:04:41 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id m20so1345960ili.9
        for <fstests@vger.kernel.org>; Tue, 20 Jul 2021 23:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEF/90rg/+KHP2YVLMYZa+NKsHMCApyRJZNW0Fne8es=;
        b=l6NgdXnxlWs8EVsMOQTVA58LrbbUnTA+cQJHwKgNhZjbICFCtxSm19UzzFTlKaoy8O
         X4K+Qx86qd0msrmUpThKn79GaYNp+6F25Q2DzbDNjpAaYhMmQOJ/oOdkSSjuIwsk0iEx
         gy/YPmBVDxZXOuFAWUE5QwipsUV4xZ1GnLcaOhfCGIkdboaHmT0SPVttiXKa4HHSutTD
         neGRgBugnuyXe+mQwjVrDfnqrpfNR7j6WUBgq+NAi8nurQY4ABjKhcwl2PICR9+YrpXn
         v4yZjthQNJnptGPmuLBtuIC9CVVFgLyhDtSmvIyKTZs8gnTDXLnoAoRIGiOagGn6tdmV
         AOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEF/90rg/+KHP2YVLMYZa+NKsHMCApyRJZNW0Fne8es=;
        b=BNPAxdDu6i0aAEkEegW66qbYzA3MHntsbZ8K54+De1+mQOyCqPACFl9viYYA1esn/4
         XHmBTpyDhpSJrj42VREqLt+zllh1E8gJWG2p5R6YMw9h9DzEuTdqzrvnXPMu1Qy9BQkh
         0wh2Zprqn7QOaSAfRFh2QaKJuKrfY/MsB017FpGe49iE/76RYRDr9SOAYRL8CrtCExqK
         r0q7MwLmK/LKmynn3OXSAdwagcZu5KTXbeN/rOo3Qd1/3syTL5o14BZ2TwsEp91cN9Yo
         7MO/Syq95Mihv+XChagEkMoH/o52fBK/JjLDqD6ipxMAQ6i86mxXqlwu76Y4nzEQ034z
         LDvA==
X-Gm-Message-State: AOAM531APxOGnG3ohsK30MaWHtIvI/FzWkxbfBAmjWGC9mvcsqUZ+nO9
        L2N6BQVvvR+DlTlvXj4HJU6EU5TD9rKPDHogctU=
X-Google-Smtp-Source: ABdhPJyIzib38+psC6JrIVzxu6sWjndTjaylMjY4h4bE9ker4CFniusekxsjnnv1hBjMOR+Nyq7tsLUSh7JkHSMepmA=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr22740927ilh.137.1626847480608;
 Tue, 20 Jul 2021 23:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210721001333.2999103-1-david@fromorbit.com>
In-Reply-To: <20210721001333.2999103-1-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 09:04:29 +0300
Message-ID: <CAOQ4uxh-rE4Tf7zsdCkaKxTvj47sE8N8g9MyHj1A49H_YMJ3kg@mail.gmail.com>
Subject: Re: [PATCH] tools: add a dm-logwrites replay tool
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 21, 2021 at 3:14 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Trying to decipher a dm-logwrites replay failure from generic/482 is
> difficult. The test destroys all the dm state and devices when the
> test fails, leaving nothing behind for post-mortem analysis. This
> script is intended to allow replay of the dm-logwrites device one
> FUA at a time similar to generic/482, and is used in conjunction
> with a modifed g/482 test that does not tear down the dm volumes
> or state when the test fails.
>
> This allows the developer to replay the logwrites up to just prior
> to failure to examine just the differences between the last good
> state and the first failure state, greatly reducing the complexity
> of analysing failures.
>
> Instructions for use are in the tools/dm-logwrite-replay script
> itself.
>

This looks very useful!
Thanks for sharing :)

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/dmlogwrites       |   8 +--
>  tests/generic/482        |  18 +++++++
>  tools/dm-logwrite-replay | 113 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 4 deletions(-)
>  create mode 100755 tools/dm-logwrite-replay
>
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 573f4b8a..66c57e2b 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -180,11 +180,11 @@ _log_writes_replay_log_range()
>         [ -z "$blkdev" ] && _fail \
>         "block dev must be specified for _log_writes_replay_log_range"
>
> -       # To ensure we replay the last entry,
> -       # we need to manually increase the end entry number to ensure
> -       # it's played
> +       # To ensure we replay the last entry, we need to manually increase the
> +       # end entry number to ensure it's played. We also dump all the
> +       # operations performed as this helps post-mortem analysis of failures.
>         echo "=== replay to $end ===" >> $seqres.full
> -       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +       $here/src/log-writes/replay-log -vv --log $LOGWRITES_DEV \
>                 --replay $blkdev --limit $(($end + 1)) \
>                 >> $seqres.full 2>&1
>         [ $? -ne 0 ] && _fail "replay failed"
> diff --git a/tests/generic/482 b/tests/generic/482
> index f26e6fc4..416b929a 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -12,6 +12,10 @@
>  _begin_fstest auto metadata replay thin
>
>  # Override the default cleanup function.
> +#
> +# If debugging logwrites failures using the tools/dm-logwrite-replay script,
> +# switch the cleanup function to the version that is commented out below so that
> +# failure leaves the corpse intact for post-mortem failure analysis.

Please let's use KEEP_LOGWRITES=yes envvar for this.

>  _cleanup()
>  {
>         cd /
> @@ -21,6 +25,20 @@ _cleanup()
>         rm -f $tmp.*
>  }
>
> +# tools/dm-logwrite-replay _cleanup version
> +#_cleanup()
> +#{
> +#      cd /
> +#      $KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> +#      if [ $status -eq 0 ]; then
> +#              _log_writes_cleanup &> /dev/null
> +#              _dmthin_cleanup
> +#      else
> +#              echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full

In this case, let's print a message to stdout, with a hint to use
dm-logwrite-replay tool and reminder to run the cleanup.

But also, I wonder - we can call _log_writes_cleanup;_dmthin_cleanup
from _dmthin_init() as a service for debuggers who forgot to cleanup
after forensics just as ./check itself will umount scratch and test leftover
mounts.

We could do that conditional or regardless to KEEP_LOGWRITES envvar.

Does it cost us anything to do that? Any caveats?

Thanks,
Amir.

> +#      fi
> +#      rm -f $tmp.*
> +#}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmthin
> diff --git a/tools/dm-logwrite-replay b/tools/dm-logwrite-replay
> new file mode 100755
> index 00000000..56d0121c
> --- /dev/null
> +++ b/tools/dm-logwrite-replay
> @@ -0,0 +1,113 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0 Copyright (c) 2021 Red Hat, Inc.  All Rights
> +# Reserved.
> +#
> +# dm-logwrite-replay utility.
> +#
> +# This is used to replay failures that result from generic/482. Modify the
> +# cleanup function in g/482 to the version that does not tear down the dm-thin
> +# volume and grab the thin volume name from the the 482.full output file.  Then
> +# you can replay the log writes manually with this tool so that the changes
> +# between a good replay and a bad replay can be isolated. The 482.full output
> +# file has all the FUA write locations recorded - these are what you pass the
> +# tool as "PREV_FUA" and "END_FUA".
> +#
> +# The tool uses the fstests infrastructure and scripts, so it needs to be run
> +# from the base fstests directory similar to the check script. RESULT_DIR is
> +# pointed at the current directory, which means that debug output from the tool
> +# placed in $seqres.full points ends up in ./dm-logwrite-replay.full.
> +#
> +# For example:
> +#      - device name /dev/mapper/thin-vol
> +#      - last good replay @ write 124
> +#      - first bad replay @ write 125
> +#
> +# Replay from start to 124:
> +#
> +# cd src/fstests
> +# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --end 124
> +# <take image of filesystem /dev/mapper/thin-vol>
> +#
> +# Replay from 124 to 125:
> +#
> +# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --start 124 --end 125
> +# <take image of filesystem from /dev/mapper/thin-vol>
> +#
> +# Now compare images of the filesystem to see the differences and analyse the
> +# failure.
> +#
> +# Often with log recovery failures, you need to see the pre-recovery state of
> +# the filesystem. To do this, use the --no-recovery option in conjunction with
> +# the above commands.  This allows you to determine if recovery is doing the
> +# wrong thing or not.
> +#
> +# Once finished, teardown the logwrites/thin vol with
> +#
> +# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --cleanup
> +#
> +
> +DMTHIN_VOL_DEV=""
> +PREV_FUA=""
> +END_FUA=""
> +CLEANUP=""
> +DO_RECOVERY="y"
> +
> +while [ $# -gt 0 ]; do
> +       case "$1" in
> +       --dev) DMTHIN_VOL_DEV="$2" ; shift ;;
> +       --start) PREV_FUA="$2" ; shift ;;
> +       --end) END_FUA="$2" ; shift ;;
> +       --cleanup) CLEANUP=y ;;
> +       --no-recovery) DO_RECOVERY="" ;;
> +       esac
> +       shift
> +done
> +
> +[ -z "$DMTHIN_VOL_DEV" ] && _fail "not dmthin vol defined"
> +
> +RESULT_DIR=`pwd`
> +
> +. ./common/preamble
> +_begin_fstest replay
> +
> +MOUNT_OPTIONS="-o dax=never"
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmthin
> +. ./common/dmlogwrites
> +
> +LOGWRITES_NAME=logwrites-test
> +LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
> +
> +if [ -n "$CLEANUP" ]; then
> +       _log_writes_cleanup &> /dev/null
> +       _dmthin_cleanup
> +       exit;
> +fi
> +
> +if [ -z "$PREV_FUA" ]; then
> +       prev=$(_log_writes_mark_to_entry_number mkfs)
> +       [ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +else
> +       prev="$((PREV_FUA + 1))"
> +fi
> +cur=$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +       echo "Replay writes from $prev to $cur"
> +       _log_writes_replay_log_range $cur $DMTHIN_VOL_DEV
> +
> +       if [ -n "$DO_RECOVERY" ]; then
> +               _dmthin_mount
> +               _dmthin_check_fs
> +       fi
> +
> +       [ -n "$END_FUA" -a "$END_FUA" -eq "$cur" ] && break;
> +
> +       prev=$cur
> +       cur=$(_log_writes_find_next_fua $(($cur + 1)))
> +       [ -z "$cur" ] && break
> +done
> +
> --
> 2.31.1
>
