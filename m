Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8919EC6FA82
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiIMNYo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIMNYn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 09:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA6115D
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 06:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32586146E
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 13:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E5C433D6;
        Tue, 13 Sep 2022 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663075479;
        bh=l5O1om1P1wsTGNiFTZkr16dRJPNYLzJwz6xVjJU1ozQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgNbm6GM24R4szEpsNTzkgyUnbM6vgerY01dnG9ED7ljDlfziQOxRDW9OKQYUkxrX
         kPDNm6uQRbMLtozm3c2VyAw9V1WpY5EzW2jqej1AOKyQCIZwp40JPBG6q2ZgDjMrwr
         HgzYX97xjLnWBwWipwOhpXG2CZvu5UfgHkCN/9OsJ7t6Wb+SQ/Ll0LyWD3HaDCkhkS
         qcx+C+2ME+vYnvGi+UEL1w7QtLOLDmr1UWIiRsePy7g67FXWAGURTPYPDeOGc0Ia4n
         C6o/ylE8xEt7biGtor9qEoe2+xG82qazM31jna6uTzN8bOozrFkagdmqkSKWAfiAwQ
         XQg260jHorqTg==
Date:   Tue, 13 Sep 2022 21:24:33 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     cuiyue-fnst@fujitsu.com
Cc:     fstests@vger.kernel.org, procps@freelists.org
Subject: Re: [PATCH] generic: fix the expected output of sysctl
Message-ID: <20220913132433.dgl4ybggvfxtdc47@zlang-mailbox>
References: <>
 <dda772ba-c391-eb9e-2613-a67892b8785f@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda772ba-c391-eb9e-2613-a67892b8785f@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 13, 2022 at 04:44:04PM +0800, cuiyue-fnst@fujitsu.com wrote:
> 
> When the version of procps-ng is 3.3.17-6, the output of "sysctl -w" is
> like:
> /proc/sys/fs/protected_regular = 0
> 
> But when I install procps-ng 3.3.17-4, the output is like:
> fs.protected_regular = 0
> 
> To avoid this, Just remove the sysctl's stdout from out file.
> ---

Hi,

I have two points about this patch...

1)
Is this a designed change of procps, or an issue which was brought in
accidentally? Better to figure out which commit brought in it, due to
when I tried to use the upstream procps source code, I didn't hit this
issue:

# git clone https://gitlab.com/procps-ng/procps.git
# git lo
a8f1c50d (tag: v4.0.1rc1) nls: Update man-po for EIP updates
...
# cd procps
# ./autogen.sh
# ./configure
# make -j8
# ./sysctl -w fs.protected_symlinks=1
fs.protected_symlinks = 1

So I doubt if it's an issue which has been fixed by procps? If anyone knows
more about that, please feel free to tell us :)

2)
Even if this's an expected behavior change of procps, we'd better to use a
filter to keep same output format for old and new procps. E.g.

_sysctl()
{
        sysctl "$@" | sed -e /proc\\/sys/s#/proc/sys/##g \
                          -e s#/#.#g
}

It's a little rude, welcome better pattern :)

Thanks,
Zorro


>  tests/generic/597     |  8 ++++----
>  tests/generic/597.out |  4 ----
>  tests/generic/598     | 12 ++++++------
>  tests/generic/598.out |  6 ------
>  4 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/generic/597 b/tests/generic/597
> index ff985ca..30129ac 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -83,9 +83,9 @@ setup_tree
>  # is not the link owner.
>  echo "== Test symlink follow protection when"
>  echo "== process != link owner and dir owner != link owner"
> -sysctl -w fs.protected_symlinks=0
> +sysctl -w fs.protected_symlinks=0 > /dev/null
>  test_symlink
> -sysctl -w fs.protected_symlinks=1
> +sysctl -w fs.protected_symlinks=1 > /dev/null
>  test_symlink
>   echo
> @@ -96,9 +96,9 @@ echo
>  # read-write access to the target
>  echo "== Test hardlink create protection when"
>  echo "== process != target owner and process cannot read target"
> -sysctl -w fs.protected_hardlinks=0
> +sysctl -w fs.protected_hardlinks=0 > /dev/null
>  test_hardlink
> -sysctl -w fs.protected_hardlinks=1
> +sysctl -w fs.protected_hardlinks=1 > /dev/null
>  test_hardlink
>   # success, all done
> diff --git a/tests/generic/597.out b/tests/generic/597.out
> index c654da7..dc327ae 100644
> --- a/tests/generic/597.out
> +++ b/tests/generic/597.out
> @@ -1,14 +1,10 @@
>  QA output created by 597
>  == Test symlink follow protection when
>  == process != link owner and dir owner != link owner
> -fs.protected_symlinks = 0
>  successfully followed symlink
> -fs.protected_symlinks = 1
>  Permission denied
>   == Test hardlink create protection when
>  == process != target owner and process cannot read target
> -fs.protected_hardlinks = 0
>  successfully created hardlink
> -fs.protected_hardlinks = 1
>  ln: failed to create hard link 'TEST_DIR/597/sticky_dir/hardlink' =>
> 'TEST_DIR/597/target': Operation not permitted
> diff --git a/tests/generic/598 b/tests/generic/598
> index 769c1b1..4264f33 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -88,11 +88,11 @@ setup_tree
>  # sticky directories
>   echo "== Test file open when owned by another and file owner != dir owner"
> -sysctl -w fs.protected_regular=0
> +sysctl -w fs.protected_regular=0 > /dev/null
>  test_access file
> -sysctl -w fs.protected_regular=1
> +sysctl -w fs.protected_regular=1 > /dev/null
>  test_access file
> -sysctl -w fs.protected_regular=2
> +sysctl -w fs.protected_regular=2 > /dev/null
>  test_access file
>   echo
> @@ -105,11 +105,11 @@ echo
>  # With protection set to 2, the same goes for group-writable
>  # sticky directories
>  echo "== Test fifo open when owned by another and fifo owner != dir owner"
> -sysctl -w fs.protected_fifos=0
> +sysctl -w fs.protected_fifos=0 > /dev/null
>  test_access fifo
> -sysctl -w fs.protected_fifos=1
> +sysctl -w fs.protected_fifos=1 > /dev/null
>  test_access fifo
> -sysctl -w fs.protected_fifos=2
> +sysctl -w fs.protected_fifos=2 > /dev/null
>  test_access fifo
>   # success, all done
> diff --git a/tests/generic/598.out b/tests/generic/598.out
> index 6d8047d..7903107 100644
> --- a/tests/generic/598.out
> +++ b/tests/generic/598.out
> @@ -1,27 +1,21 @@
>  QA output created by 598
>  == Test file open when owned by another and file owner != dir owner
> -fs.protected_regular = 0
>  = group & world writable dir
>  = only group writable dir
> -fs.protected_regular = 1
>  = group & world writable dir
>  Permission denied
>  = only group writable dir
> -fs.protected_regular = 2
>  = group & world writable dir
>  Permission denied
>  = only group writable dir
>  Permission denied
>   == Test fifo open when owned by another and fifo owner != dir owner
> -fs.protected_fifos = 0
>  = group & world writable dir
>  = only group writable dir
> -fs.protected_fifos = 1
>  = group & world writable dir
>  Permission denied
>  = only group writable dir
> -fs.protected_fifos = 2
>  = group & world writable dir
>  Permission denied
>  = only group writable dir
> -- 
> 1.8.3.1
> 
