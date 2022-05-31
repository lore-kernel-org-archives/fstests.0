Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF71C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 31 May 2022 16:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbiEaQEu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 May 2022 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiEaQEt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 May 2022 12:04:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401F8FD4B
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 09:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F731CE16FD
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 16:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C99EC385A9;
        Tue, 31 May 2022 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654013083;
        bh=77pU4mwBBht72Ang/QQcd6KRn2N6f7Mxq8dkjBDJfeM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cXx1k+e2ECfP9Qa3v1SjLX/RR+2uUC8XMiT4t8HrIhV4SrPc6iIc3LWIKYumPonHE
         KkTxxPZCtM/QdZ1Jsg3a+OMz3kOnDrlux3Z9wC5VY2yZTSIgx0UCgPW5qp6hNLfN0p
         j2YzF2p/B+7e4V3PBvPGmjhJy9JtfYDyfOrYzcT3pwJQTUs6y+tV7y+H5wLqLbuywp
         IBmgde2ipcReL9baBDQCBHcSyTpV7MwmNmDupb2+y5cBDS3syVVPp/Nvig+GiXSVRU
         mUhBoYsuatfSKxWAt6w8lB3ZmErn2PtiQvg4RZ5f67q+RcJNOFvNZn9PWAYBhqTldL
         TgQc6zh8OSOfQ==
Message-ID: <1643075e-f830-5e0a-9c12-e32a37ca0f5d@kernel.org>
Date:   Wed, 1 Jun 2022 00:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] generic: adjust strict SPO recovery testcases for f2fs
Content-Language: en-US
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-f2fs-devel@lists.sourceforge.net,
        zlang@kernel.org
References: <20220521031621.3494402-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220521031621.3494402-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

+Cc Zorro,

Any comments?

On 2022/5/21 11:16, Chao Yu wrote:
> Testcases like generic 342/502/526/527 expect that filesystems will
> recover all related metadata changes to the file which was fsynced
> before sudden power off.
> 
> This patch adjusts to use "fsync_mode=strict" mountoption for f2fs
> to pass these testcases.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   tests/generic/342 | 5 +++++
>   tests/generic/502 | 5 +++++
>   tests/generic/526 | 5 +++++
>   tests/generic/527 | 5 +++++
>   4 files changed, 20 insertions(+)
> 
> diff --git a/tests/generic/342 b/tests/generic/342
> index 676b876b..cdffaaf3 100755
> --- a/tests/generic/342
> +++ b/tests/generic/342
> @@ -31,6 +31,11 @@ _require_dm_target flakey
>   
>   _scratch_mkfs >>$seqres.full 2>&1
>   _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>   _init_flakey
>   _mount_flakey
>   
> diff --git a/tests/generic/502 b/tests/generic/502
> index b0f9077f..b5589b81 100755
> --- a/tests/generic/502
> +++ b/tests/generic/502
> @@ -34,6 +34,11 @@ _require_dm_target flakey
>   
>   _scratch_mkfs >>$seqres.full 2>&1
>   _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>   _init_flakey
>   _mount_flakey
>   
> diff --git a/tests/generic/526 b/tests/generic/526
> index dc7cb36c..ada4dbee 100755
> --- a/tests/generic/526
> +++ b/tests/generic/526
> @@ -32,6 +32,11 @@ _require_dm_target flakey
>   
>   _scratch_mkfs >>$seqres.full 2>&1
>   _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>   _init_flakey
>   _mount_flakey
>   
> diff --git a/tests/generic/527 b/tests/generic/527
> index 40cd1c6a..de09d171 100755
> --- a/tests/generic/527
> +++ b/tests/generic/527
> @@ -32,6 +32,11 @@ _require_dm_target flakey
>   
>   _scratch_mkfs >>$seqres.full 2>&1
>   _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>   _init_flakey
>   _mount_flakey
>   
