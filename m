Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFACC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 13:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhLSNUc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 08:20:32 -0500
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:37057 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhLSNUb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 08:20:31 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07960631|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00678837-0.000153474-0.993058;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MJYB2gI_1639920029;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MJYB2gI_1639920029)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 19 Dec 2021 21:20:29 +0800
Date:   Sun, 19 Dec 2021 21:20:29 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH v3] common/encrypt, ceph: add _require_not_encrypted test
Message-ID: <Yb8xnVYfmZeF2Vjn@desktop>
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

We have some other helpers that require something not enabled or present,
and they're all in the format as:

_require_no_compress()
_require_no_realtime()
_require_no_xfs_debug()

So how about name it as _require_no_encryption() to be consistent with
other functions?

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

I think we may need to check if statx is supported as well

_require_xfs_io_command "statx" "-r"

Thanks,
Eryu

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
