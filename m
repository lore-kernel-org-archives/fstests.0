Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B399AC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 00:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhLPApr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:45:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40434 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhLPApq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 19:45:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0549CB82232
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 00:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7666C36AE0;
        Thu, 16 Dec 2021 00:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639615543;
        bh=yWB7Zs2z97o0kqKm2muLYlSHf30CZKoB7o7EKmzY3hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po8O/kIxiSKVNEc0L0gBd/V7/XP2LXgxDe9WiYBEiFRmpJTx6/m2pdQaPw8PMAV/7
         p8fJYC7H/sT3IEKMJBWM5OAriEvZtXQDvma9amszxTWp+ppq/FTqFFyc1kJWrrq+gD
         cFQzie1JjM5QGpTbEg9j6OnQ/EbpmQIW51A+9qgFbWlI6taBEarG74GRoBN5h9Kgdc
         3Sd/SsKX0jj5ags1B1vzaYkTeVeNyGbG0XjfzK3UyMV4mwi+MpdBtUzSRqiHFeVLOE
         y7xtCZci4gJ+EpwWlLxF/mxfkVke4GgGBo/kTOernAelsq+RQynGenraybVh/weOQw
         GsXM2raG7NYyw==
Date:   Wed, 15 Dec 2021 16:45:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v3] common/encrypt, ceph: add _require_not_encrypted test
Message-ID: <YbqMLgoYh8ZI+8bR@sol.localdomain>
References: <20211215190248.111263-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
> 
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

Did you consider instead skipping the test if the mount options contain
test_dummy_encryption?  That's the way that the encryption tests currently
detect that they shouldn't run (since the automatic encryption caused by
test_dummy_encryption would interfere with them); see
_require_scratch_encryption().  What you've done here will work too, but it
might make sense to check for test_dummy_encryption the same way in both places.

- Eric
