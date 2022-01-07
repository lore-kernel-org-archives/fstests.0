Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A6AC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 10:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiAGK2f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:28:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiAGK2e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 05:28:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78C0E1F39C;
        Fri,  7 Jan 2022 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641551313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uu/L2qmMze//Y3QmnRzg39hlXYoYVclcV8IqeDAU0lY=;
        b=2DouOU08CLUZDVPNshWwUlTTHfSelv5InqXb/EnbLyiidMgt/nGo2F2YcGvXJAvZgtdLLO
        miXniI9kTRtONzlOEcF8ncot2LY9rP8Z55jk8asKtqxej2aTrn9QfVkfCrAJwoztm1zTbV
        kZMb66r+LwgLPE5zdX2/5Ov9t0g5Nmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641551313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uu/L2qmMze//Y3QmnRzg39hlXYoYVclcV8IqeDAU0lY=;
        b=wN8vD8HQ+IZbVSPr0h8EjkESb6QW+zZkxUVFboYZnFvF6OH+XLVrvQqb/x72M8oGQBCFSX
        YQXw/z9xJW5BA9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1482D13CBA;
        Fri,  7 Jan 2022 10:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y0d4AdEV2GEnbwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 07 Jan 2022 10:28:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 97d7f6e9;
        Fri, 7 Jan 2022 10:28:40 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:28:40 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2] common/rc, ceph: skip ceph/001-ceph/003 if
 test_dummy_encryption is enabled
Message-ID: <YdgV2LSDO6ezQegm@suse.de>
References: <20220106133049.68171-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106133049.68171-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 06, 2022 at 08:30:49AM -0500, Jeff Layton wrote:
> Some tests on ceph require changing the layout of new files, which is
> forbidden when the files are encrypted. Skip these tests if the
> test_dummy_encryption mount option is being used.
> 
> Generalize the _exclude_scratch_mount_option code and add a new
> _exclude_test_mount_option call as well. Call the new function from the
> ceph tests that should exclude test_dummy_encryption.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me!  Feel free to add my

Reviewed-by: Luis Henriques <lhenriques@suse.de>

Cheers,
--
Luís

> ---
>  common/btrfs   |  2 +-
>  common/rc      | 28 +++++++++++++++++++---------
>  tests/ceph/001 |  1 +
>  tests/ceph/002 |  1 +
>  tests/ceph/003 |  1 +
>  5 files changed, 23 insertions(+), 10 deletions(-)
> 
> Thanks to Eric and Luis for review so far!
> 
> v2: fix argument handling in _exclude_mount_option
>     fix _require_btrfs_no_compress
>     ensure _normalize_mount_options callers pass correct argument
>     
> diff --git a/common/btrfs b/common/btrfs
> index fe5985663ab4..4afe81eb2dfb 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -115,7 +115,7 @@ _require_btrfs_fs_sysfs()
>  
>  _require_btrfs_no_compress()
>  {
> -	if _normalize_mount_options | grep -q "compress"; then
> +	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "compress"; then
>  		_notrun "This test requires no compression enabled"
>  	fi
>  }
> diff --git a/common/rc b/common/rc
> index 341abc9a0d02..0c985d0f2952 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2039,7 +2039,7 @@ _require_sane_bdev_flush()
>  # Returns 0 if DAX will be used, 1 if DAX is not going to be used.
>  __scratch_uses_fsdax()
>  {
> -	local ops=$(_normalize_mount_options)
> +	local ops=$(_normalize_mount_options "$MOUNT_OPTIONS")
>  
>  	echo $ops | egrep -qw "dax(=always| |$)" && return 0
>  	echo $ops | grep -qw "dax=never" && return 1
> @@ -3718,7 +3718,7 @@ _has_metadata_journaling()
>  			return 1
>  		}
>  		# ext4 might not load a journal
> -		if _normalize_mount_options | grep -qw "noload"; then
> +		if _normalize_mount_options "$MOUNT_OPTIONS" | grep -qw "noload"; then
>  			echo "mount option \"noload\" not allowed in this test"
>  			return 1
>  		fi
> @@ -3882,20 +3882,20 @@ _require_cloner()
>  		_notrun "cloner binary not present at $CLONER_PROG"
>  }
>  
> -# Normalize mount options from global $MOUNT_OPTIONS
> -# Convert options like "-o opt1,opt2 -oopt3" to
> -# "opt1 opt2 opt3"
> +# Normalize mount options from the option string in $1
> +# Convert options like "-o opt1,opt2 -oopt3" to "opt1 opt2 opt3"
>  _normalize_mount_options()
>  {
> -	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
> +	echo "$1" | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
>  }
>  
> -# skip test if MOUNT_OPTIONS contains the given strings
> +# skip test if $1 contains the given strings in trailing arguments
>  # Both dax and dax=always are excluded if dax or dax=always is passed
> -_exclude_scratch_mount_option()
> +_exclude_mount_option()
>  {
> -	local mnt_opts=$(_normalize_mount_options)
> +	local mnt_opts=$(_normalize_mount_options "$1")
>  
> +	shift
>  	while [ $# -gt 0 ]; do
>  		local pattern=$1
>  		echo "$pattern" | egrep -q "dax(=always|$)" && \
> @@ -3907,6 +3907,16 @@ _exclude_scratch_mount_option()
>  	done
>  }
>  
> +_exclude_scratch_mount_option()
> +{
> +	_exclude_mount_option "$MOUNT_OPTIONS" $@
> +}
> +
> +_exclude_test_mount_option()
> +{
> +	_exclude_mount_option "$TEST_FS_MOUNT_OPTS" $@
> +}
> +
>  _require_atime()
>  {
>  	_exclude_scratch_mount_option "noatime"
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index c00de308fd95..5a828567d500 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -22,6 +22,7 @@ _begin_fstest auto quick copy_range
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_exclude_test_mount_option "test_dummy_encryption"
>  _require_attrs
>  _require_test
>  
> diff --git a/tests/ceph/002 b/tests/ceph/002
> index 9bc728fd2e18..ac3d65b529bd 100755
> --- a/tests/ceph/002
> +++ b/tests/ceph/002
> @@ -30,6 +30,7 @@ _begin_fstest auto quick copy_range
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_exclude_test_mount_option "test_dummy_encryption"
>  _require_attrs
>  _require_test
>  
> diff --git a/tests/ceph/003 b/tests/ceph/003
> index faedb48cfeea..2d6cb393b3f6 100755
> --- a/tests/ceph/003
> +++ b/tests/ceph/003
> @@ -18,6 +18,7 @@ _begin_fstest auto quick copy_range
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_exclude_test_mount_option "test_dummy_encryption"
>  _require_attrs
>  _require_test
>  
> -- 
> 2.33.1
> 
