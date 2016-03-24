Received: from mx1.redhat.com ([209.132.183.28]:39184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbcCXLtg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Mar 2016 07:49:36 -0400
Date: Thu, 24 Mar 2016 19:49:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/338: Add mmap race test
Message-ID: <20160324114934.GU11419@eguan.usersys.redhat.com>
References: <1458740555-3512-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458740555-3512-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 23, 2016 at 02:42:35PM +0100, Jan Kara wrote:
> Add test which spawns two threads racing to write to file via mmap and
> checks the result. This is mainly interesting to uncover races in DAX
> fault handling.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  src/Makefile          |   5 +-
>  src/holetest.c        | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/338     |  57 +++++++++
>  tests/generic/338.out |  73 +++++++++++
>  tests/generic/group   |   1 +
>  5 files changed, 476 insertions(+), 2 deletions(-)
>  create mode 100644 src/holetest.c
>  create mode 100755 tests/generic/338
>  create mode 100644 tests/generic/338.out

338 is taken, 340 is free now :)

[snip]
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch

Need to make sure "holetest" is built here, and there's a new helper to
do it now

_require_test_program "holetest"

And test fails when I tested on ext3/2/NFS/CIFS, because they have no
fallocate support, so need to test for fallocate support as well

_require_xfs_io_command "falloc"

Thanks,
Eryu
