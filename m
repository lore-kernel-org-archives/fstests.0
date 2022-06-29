Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C0C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 05:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiF2FQi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 01:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiF2FQh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 01:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8330F54
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 22:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A10EC616E1
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EC9C34114;
        Wed, 29 Jun 2022 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656479796;
        bh=LuaglwpMITe7zyGs+IoI118Aa97Rteyied8eRNMPCi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ez8j1Aw0z510AK1HCWE5Eu1U+l1eFUPzYBXd+4pJSVzwS7uiofWkNQXHuV6HCTHJA
         JTVgAvDOK52pkQ+9AiGvn+iuBk3peOOBocWHe9C3rvkjccHGrpiIuRk49DF1/VNkVd
         wu0loXRxlBpVPDOL1lqPi0EJ5TQBBcdrvOpALDoAML4zt1Q7AiCgmOJjeEv3nGlrMm
         yWKHqMaCziTuXUw9FsCahA4IQ4ZwOSmFEe8mB4QYsFXvbm6IJTXMgMIjrl+xh96ksi
         v7DK1jRSpY07EXF9jdU6srfFS2RB96NFJjHntG81Ho90FW1GGQAimuFHmmpAhkUzUx
         cDyK9LwMMdEqQ==
Date:   Tue, 28 Jun 2022 22:16:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] ext4: create file systems with the enrypt feature if
 necessary
Message-ID: <YrvgMkrXh8iUItVv@sol.localdomain>
References: <20220628182545.1834145-1-tytso@mit.edu>
 <20220628182545.1834145-7-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628182545.1834145-7-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 02:25:45PM -0400, Theodore Ts'o wrote:
> The linux kernel commit 5f41fdaea63d ("ext4: only allow
> test_dummy_encryption when supported") the kernel will reject mounts
> with the test_dummy_encryption option if the ext4 file system does not
> have the encrypt feature enabled.
> 
> There are a handful of tests (ext4/003, ext4/035, ext4/306, and
> generic/260) which will format the scratch file system using a
> hard-coded set of mkfs.ext4 parameters ignoring the MKFS_OPTION that
> is set by the file system test config.
> 
> For file system config that includes test_dummy_encryption in
> MOUNT_OPTIONS and "-O encrypt" in MKFS_OPTIONS, we need to test for
> test_dummy_encryption and force the hard-coded mkfs options to enable
> the encrypt feature.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/003    | 6 +++++-
>  tests/ext4/035    | 5 ++++-
>  tests/ext4/306    | 3 +++
>  tests/generic/260 | 5 ++++-
>  4 files changed, 16 insertions(+), 3 deletions(-)

Thanks, I didn't notice these.  The general approach looks good.  A few nits:

- The hunk in tests/ext4/035 doesn't apply; it seems you have a local change?

- "enrypt" in the subject should be "encrypt"

> diff --git a/tests/ext4/003 b/tests/ext4/003
> index 773bcb03..6a4518e3 100755
> --- a/tests/ext4/003
> +++ b/tests/ext4/003
> @@ -27,7 +27,11 @@ _require_scratch
>  _require_scratch_ext4_feature "bigalloc"
>  
>  BLOCK_SIZE=$(get_page_size)
> -$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
> +FEATURES=bigalloc
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    FEATURES=${FEATURES},encrypt
> +fi

Bash supports appending to variables: FEATURES+=",encrypt"

Also, lower case "features" would be better.

> diff --git a/tests/ext4/035 b/tests/ext4/035
> index 1f26e766..a1ccce45 100755
> --- a/tests/ext4/035
> +++ b/tests/ext4/035
> @@ -25,7 +25,10 @@ _require_scratch
>  _exclude_scratch_mount_option dax
>  _require_command "$RESIZE2FS_PROG" resize2fs
>  
> -$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    ENCRYPT="-O encrypt"
> +fi

Similarly, lower case "encrypt".  Also, starting out with "encrypt=" would be a
good idea, to avoid relying on an uninitialized variable.

> +$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $ENCRYPT $SCRATCH_DEV 32768 >> $seqres.full 2>&1
>  if [ $? -ne 0 ]; then
>      _notrun "Can't make file system with a block size of 1024"
>  fi
> diff --git a/tests/ext4/306 b/tests/ext4/306
> index 2ff88537..a6b7eab5 100755
> --- a/tests/ext4/306
> +++ b/tests/ext4/306
> @@ -33,6 +33,9 @@ features="^extents"
>  if grep -q 64bit /etc/mke2fs.conf ; then
>      features="^extents,^64bit"
>  fi
> +if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +    features=${features},encrypt
> +fi

Similarly, features+=",encrypt"

Also adding the ^64bit option can look like: features+=",^64bit"

> diff --git a/tests/generic/260 b/tests/generic/260
> index b4d72e0f..e86afe9c 100755
> --- a/tests/generic/260
> +++ b/tests/generic/260
> @@ -120,7 +120,10 @@ case $FSTYP in
>  		bsize=4096
>  		start=$(_math "$base*$agsize*$bsize")
>  		len=$start
> -		export MKFS_OPTIONS="-F -b $bsize -g $agsize"
> +		if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
> +		    ENCRYPT="-O encrypt"
> +		fi
> +		export MKFS_OPTIONS="-F -b $bsize -g $agsize $ENCRYPT"
>  		;;

This one could be:

	export MKFS_OPTIONS="-F -b $bsize -g $agsize"
	if echo "$MOUNT_OPTIONS" | grep -q 'test_dummy_encryption'; then
		MKFS_OPTIONS+=" -O encrypt"
	fi
