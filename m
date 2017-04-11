Received: from mx1.redhat.com ([209.132.183.28]:55310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbdDKLkL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 07:40:11 -0400
Date: Tue, 11 Apr 2017 19:40:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 1/3] common: helper to get value from ndctl list by key
Message-ID: <20170411114008.GI22845@eguan.usersys.redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491804353-1326-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 10, 2017 at 02:05:51PM +0800, Xiong Zhou wrote:
> For some nvdimm DAX related tests, it's better to know
> some details of devices being tested. Adding new prog
> ndctl to manage nvdimms and jq to parse outputs.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v2:
>   use _require_command instead of running cmds
> 
>  common/config |  2 ++
>  common/rc     | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 59041a3..dfdcb8e 100644
> --- a/common/config
> +++ b/common/config
> @@ -212,6 +212,8 @@ export XZ_PROG="`set_prog_path xz`"
>  export FLOCK_PROG="`set_prog_path flock`"
>  export LDD_PROG="`set_prog_path ldd`"
>  export TIMEOUT_PROG="`set_prog_path timeout`"
> +export NDCTL_PROG="`set_prog_path ndctl`"
> +export JQ_PROG="`set_prog_path jq`"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/rc b/common/rc
> index e1ab2c6..bc387cf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3148,6 +3148,25 @@ _require_chattr()
>      rm -f $TEST_DIR/syscalltest.out
>  }
>  
> +_require_ndctl()
> +{
> +	_require_command "$NDCTL_PROG" ndctl
> +}
> +
> +_require_jq()
> +{
> +	_require_command "$JQ_PROG" jq
> +}

Don't need new wrappers for one line requirement, you could require the
command in tests directly.

> +
> +# $1 SCRATCH_DEV or TEST_DEV or other dev
> +# $2 key
> +_ndctl_get_pmem_key_value()
> +{
> +	$NDCTL_PROG list | \
> +	  $JQ_PROG -r ".[] | \
> +	  select(.blockdev == \"${1#/dev/}\") | .$2"
> +}
> +

And I think this patch could be merged with patch 2.

Thanks,
Eryu

>  _get_total_inode()
>  {
>  	if [ -z "$1" ]; then
> -- 
> 1.8.3.1
> 
