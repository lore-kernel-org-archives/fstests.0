Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA8EC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Mar 2022 04:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiCIEcW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Mar 2022 23:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCIEcV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Mar 2022 23:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268EE6E4E7
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 20:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B629661868
        for <fstests@vger.kernel.org>; Wed,  9 Mar 2022 04:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C7C340E8;
        Wed,  9 Mar 2022 04:31:19 +0000 (UTC)
Message-ID: <cd2a245e-b9d2-c09c-0f8c-a7ca9157ca9f@oppo.com>
Date:   Wed, 9 Mar 2022 12:31:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH] generic/066: attr1 is still there after log
 replay on f2fs
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20220228035719.4102745-1-sunke32@huawei.com>
From:   Chao Yu <chao.yu@oppo.com>
In-Reply-To: <20220228035719.4102745-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/2/28 11:57, Sun Ke via Linux-f2fs-devel wrote:
> The test fail on f2fs:
>       xattr names and values after second fsync log replay:
>       # file: SCRATCH_MNT/foobar
>      +user.attr1="val1"
>       user.attr3="val3"
> 
> attr1 is still there after log replay.
> I guess it is f2fs's special feature to improve the performance.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> 
> Is it a BUG on f2fs?

I don't think so, it fails due to f2fs doesn't follow recovery rule which
btrfs/ext4/xfs does, but it doesn't mean f2fs has break posix semantics of
fsync().

Could you please try fastboot mountpoint? It may help to pass this testcase.

Thanks,

>   .gitignore                                 |  1 +
>   tests/generic/066                          |  3 +++
>   tests/generic/066.cfg                      |  1 +
>   tests/generic/{066.out => 066.out.default} |  0
>   tests/generic/066.out.f2fs                 | 11 +++++++++++
>   5 files changed, 16 insertions(+)
>   create mode 100644 tests/generic/066.cfg
>   rename tests/generic/{066.out => 066.out.default} (100%)
>   create mode 100644 tests/generic/066.out.f2fs
> 
> diff --git a/.gitignore b/.gitignore
> index 65b93307..135742f5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -194,6 +194,7 @@ tags
>   /src/perf/*.pyc
>   
>   # Symlinked files
> +/tests/generic/066.out
>   /tests/generic/035.out
>   /tests/generic/050.out
>   /tests/xfs/033.out
> diff --git a/tests/generic/066 b/tests/generic/066
> index 105a7acd..524dc82d 100755
> --- a/tests/generic/066
> +++ b/tests/generic/066
> @@ -17,6 +17,7 @@
>   #
>   #  Btrfs: remove deleted xattrs on fsync log replay
>   #
> +seqfull=$0
>   . ./common/preamble
>   _begin_fstest auto quick attr metadata log
>   
> @@ -32,6 +33,8 @@ _cleanup()
>   . ./common/dmflakey
>   . ./common/attr
>   
> +# Select appropriate golden output based on fstype
> +_link_out_file
>   # real QA test starts here
>   _supported_fs generic
>   _require_scratch
> diff --git a/tests/generic/066.cfg b/tests/generic/066.cfg
> new file mode 100644
> index 00000000..c25641be
> --- /dev/null
> +++ b/tests/generic/066.cfg
> @@ -0,0 +1 @@
> +f2fs: f2fs
> diff --git a/tests/generic/066.out b/tests/generic/066.out.default
> similarity index 100%
> rename from tests/generic/066.out
> rename to tests/generic/066.out.default
> diff --git a/tests/generic/066.out.f2fs b/tests/generic/066.out.f2fs
> new file mode 100644
> index 00000000..8fc58693
> --- /dev/null
> +++ b/tests/generic/066.out.f2fs
> @@ -0,0 +1,11 @@
> +QA output created by 066
> +xattr names and values after first fsync log replay:
> +# file: SCRATCH_MNT/foobar
> +user.attr1="val1"
> +user.attr3="val3"
> +
> +xattr names and values after second fsync log replay:
> +# file: SCRATCH_MNT/foobar
> +user.attr1="val1"
> +user.attr3="val3"
> +
