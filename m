Received: from mx1.redhat.com ([209.132.183.28]:45082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdDKLoM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 07:44:12 -0400
Date: Tue, 11 Apr 2017 19:44:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 2/3] DAX-DIO: skip DAX to non-DAX if unsupported
Message-ID: <20170411114410.GJ22845@eguan.usersys.redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
 <1491804353-1326-2-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491804353-1326-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 10, 2017 at 02:05:52PM +0800, Xiong Zhou wrote:
> By tweaking SCRATCH_DEV by ndctl, only run DAX mapped
> area DIO to non-DAX area tests when pmem device is in
> "memory mode".
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v2:
>   umount/check scratch fs after test
>   restore SCRATCH_DEV mode in cleanup
>   fix variable names
> 
>  tests/generic/413 | 26 +++++++++++++++++++++++++-
>  tests/xfs/260     | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/413 b/tests/generic/413
> index a1cc514..fbe8f11 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -34,6 +34,9 @@ _cleanup()
>  {
>  	cd /
>  	rm -f $tmp.*
> +	# restore SCRATCH_DEV to original mode
> +	$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
> +	  -m $scratch_dev_mode > /dev/null 2>&1
>  }
>  
>  # get standard environment, filters and checks
> @@ -47,9 +50,13 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  _require_scratch_dax
> +# fsck manually after tests as we will reconfig SCRATCH_DEV
> +_require_scratch_nocheck
>  _require_test_program "feature"
>  _require_test_program "t_mmap_dio"
>  _require_xfs_io_command "falloc"
> +_require_ndctl
> +_require_jq
>  
>  prep_files()
>  {
> @@ -110,7 +117,7 @@ t_both_nondax()
>  t_mmap_dio_dax()
>  {
>  	t_both_dax $1
> -	t_dax_to_nondax $1
> +	[ $skip_dax_to_nondax -eq 0 ] && t_dax_to_nondax $1
>  	t_nondax_to_dax $1
>  	t_both_nondax $1
>  }
> @@ -126,6 +133,21 @@ do_tests()
>  	t_mmap_dio_dax $((64 * 1024 * 1024))
>  }
>  
> +skip_dax_to_nondax=0
> +# config SCRATCH_DEV to memory mode to support DAX mapped
> +# area DIO to non-DAX area.
> +
> +# save original mode
> +scratch_dev_mode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
> +
> +# get its namespace
> +scratch_dev_namespace=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
> +
> +# skip dax to non-dax dio if config fails
> +$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
> +  -m memory > /dev/null 2>&1 \
> +  || skip_dax_to_nondax=1
> +

I'm not sure if it's proper to change the pmem device mode in tests.
IMO, fstests just takes use of user specified TEST|SCRATCH_DEV and
checks if they meet our requirements.

So I think the correct way is just check the mode of pmem device and
_notrun if the mode isn't compatible with this test.

Thanks,
Eryu
