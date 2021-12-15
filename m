Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4603C38161
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 16:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbhLOQBN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:01:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53624 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhLOQBN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 11:01:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BEFC1F3CC;
        Wed, 15 Dec 2021 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639584072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcyOfhujaA9FJ2yf3cCWbEhjS5wxhq22cEszEsDcrZE=;
        b=n8A7CV/3IGLQTk+FrkcX4rQamUwuLN9jz3X2rv3sKfeH1oRTmaG/iolpFWut0H5psscshS
        5swJn4wjfd+I18KeOZ65MKNfYtkNrJS4aIFsVhFeDL3Vq777fRPsQGIqH+TxsS16qZ05mb
        49zp0j1aXf7lZF6N5Nof251/9piVmxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639584072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcyOfhujaA9FJ2yf3cCWbEhjS5wxhq22cEszEsDcrZE=;
        b=8ht+8nFKFenDhxsljuTIUCGCM2lhDrazdn6+i7mkltJ885DlY5GyeDIgpFpCWNifxG0BQa
        RyxCUvFjUvcurdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2817613B75;
        Wed, 15 Dec 2021 16:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pOL1BkgRumFRFQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 15 Dec 2021 16:01:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 721168fa;
        Wed, 15 Dec 2021 16:01:10 +0000 (UTC)
Date:   Wed, 15 Dec 2021 16:01:10 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc, ceph: add _require_not_encrypted test
Message-ID: <YboRRjoPEVkdrzwe@suse.de>
References: <20211215142047.66403-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215142047.66403-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Jeff,

On Wed, Dec 15, 2021 at 09:20:47AM -0500, Jeff Layton wrote:
> Some tests on ceph require changing the layout of new files, which is
> forbidden when the files are encrypted. Add a test that touches a file
> in $TEST_DIR and then tests it to see if it reports the
> STATX_ATTR_ENCRYPTED flag, and does a _notrun if it's present.
> 
> Also add this requirement to the two ceph tests that change the layout.

Aren't you forgetting ceph/001?

> Cc: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc      | 17 +++++++++++++++++
>  tests/ceph/002 |  1 +
>  tests/ceph/003 |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 7973ceb5fdf8..9165325dc478 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4782,6 +4782,23 @@ _require_kernel_config()
>  	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
>  }
>  
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
> +

Maybe this function could be in the 'common/encrypt' file instead.

Other than these 2 comments, I also agree that this approach is better
than hooking into the _ceph_create_file_layout() function.

Cheers,
--
Luís

>  init_rc
>  
>  ################################################################################
> diff --git a/tests/ceph/002 b/tests/ceph/002
> index 9bc728fd2e18..be5c0f8c644d 100755
> --- a/tests/ceph/002
> +++ b/tests/ceph/002
> @@ -30,6 +30,7 @@ _begin_fstest auto quick copy_range
>  _supported_fs ceph
>  
>  _require_xfs_io_command "copy_range"
> +_require_not_encrypted
>  _require_attrs
>  _require_test
>  
> diff --git a/tests/ceph/003 b/tests/ceph/003
> index faedb48cfeea..c8aefc4ad06f 100755
> --- a/tests/ceph/003
> +++ b/tests/ceph/003
> @@ -18,6 +18,7 @@ _begin_fstest auto quick copy_range
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
