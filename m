Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70DC433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 10:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhLPKET (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 05:04:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49532 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhLPKET (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 05:04:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 481791F3D5;
        Thu, 16 Dec 2021 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639649058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=COBkWeWBcwmYCi2xq3WOlvi/+KhPwOJ+t9biU047NTQ=;
        b=IGz/R9tYlgQQUwyrjvLjBT4SXvyTXThswUskn+bBmhCEnwFZNyUF3Yo/nqJB0kQABBR8kA
        6IqRxXsq8QNbzMZaA+Rv8Jinvvcoz5++d2ZXZVjAWL1622XwUKy+vVMO2SeiuZTcjgKycl
        hl/oYa1eR+kwfhU8epO4GpNPVLbHq3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639649058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=COBkWeWBcwmYCi2xq3WOlvi/+KhPwOJ+t9biU047NTQ=;
        b=VmWkQdKlupEt0L52q+hrGiGpvZn/gBfHgGZsgS3kbKVUtYBUpYZAej6CGNtuGpv7+QaqKK
        f3UdECzyvN3NIbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 039F713DF8;
        Thu, 16 Dec 2021 10:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AoKQOSEPu2E0FgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 16 Dec 2021 10:04:17 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id baa620f1;
        Thu, 16 Dec 2021 10:04:16 +0000 (UTC)
Date:   Thu, 16 Dec 2021 10:04:16 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] common/encrypt, ceph: add _require_not_encrypted test
Message-ID: <YbsPIHBjHd7haJPg@suse.de>
References: <20211215190248.111263-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215190248.111263-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 15, 2021 at 02:02:48PM -0500, Jeff Layton wrote:
> Some tests on ceph require changing the layout of new files, which is
> forbidden when the files are encrypted. Add a test that touches a file
> in $TEST_DIR and then tests it to see if it reports the
> STATX_ATTR_ENCRYPTED flag, and does a _notrun if it's present.
> 
> Also add this requirement to three ceph tests that change the layout.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/encrypt | 18 ++++++++++++++++++
>  tests/ceph/001 |  2 ++
>  tests/ceph/002 |  2 ++
>  tests/ceph/003 |  2 ++
>  4 files changed, 24 insertions(+)
> 
> v2: make ceph/001 also call _require_not_encrypted
> 
> v3: move test into common/encrypt

Awesome, looks good to me.  Feel free to add my

Reviewed-by: Luis Henriques <lhenriques@suse.de>

(Although you may send another revision with Eric's suggestion...)

Cheers,
--
Luís


> diff --git a/common/encrypt b/common/encrypt
> index f90c4ef05a3f..156425af40a8 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -940,3 +940,21 @@ _filter_nokey_filenames()
>  	# of characters that have ever been used in such names.
>  	sed "s|${dir}${dir:+/}[A-Za-z0-9+,_-]\+|${dir}${dir:+/}NOKEY_NAME|g"
>  }
> +
> +# Some tests require that encryption not be enabled.
> +_require_not_encrypted()
> +{
> +	local target=$TEST_DIR/require_not_encrypted.$$
> +	local ret=0
> +
> +	#
> +	# The top-level directory mounted with test_dummy_encryption is not
> +	# itself encrypted. Only new files and directories created under it
> +	# are.
> +	touch $target
> +	local attrs=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
> +	rm -f $target
> +
> +	# STATX_ATTR_ENCRYPTED == 0x800
> +	[ $(( attrs & 0x800 )) -eq 0 ] || _notrun "Filesystem is encrypted"
> +}
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index c00de308fd95..d6ded026a6dd 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -17,11 +17,13 @@ _begin_fstest auto quick copy_range
>  . common/filter
>  . common/attr
>  . common/reflink
> +. common/encrypt
>  
>  # real QA test starts here
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_require_not_encrypted
>  _require_attrs
>  _require_test
>  
> diff --git a/tests/ceph/002 b/tests/ceph/002
> index 9bc728fd2e18..2232b75e6dfa 100755
> --- a/tests/ceph/002
> +++ b/tests/ceph/002
> @@ -25,11 +25,13 @@ _begin_fstest auto quick copy_range
>  # get standard environment
>  . common/filter
>  . common/attr
> +. common/encrypt
>  
>  # real QA test starts here
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_require_not_encrypted
>  _require_attrs
>  _require_test
>  
> diff --git a/tests/ceph/003 b/tests/ceph/003
> index faedb48cfeea..aa130ae807f9 100755
> --- a/tests/ceph/003
> +++ b/tests/ceph/003
> @@ -13,11 +13,13 @@ _begin_fstest auto quick copy_range
>  . common/filter
>  . common/attr
>  . common/reflink
> +. common/encrypt
>  
>  # real QA test starts here
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_require_not_encrypted
>  _require_attrs
>  _require_test
>  
> -- 
> 2.33.1
> 
