Received: from mga02.intel.com ([134.134.136.20]:27439 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbdDLDaz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 23:30:55 -0400
Date: Tue, 11 Apr 2017 21:30:53 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH 2/3] DAX-DIO: skip DAX to non-DAX if unsupported
Message-ID: <20170412033053.GA9671@linux.intel.com>
References: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
 <1491551764-18779-2-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491551764-18779-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 07, 2017 at 03:56:03PM +0800, Xiong Zhou wrote:
> By tweaking SCRATCH_DEV by ndctl, only run DAX mapped
> area DIO to non-DAX area tests when pmem device is in
> "memory mode".
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>  tests/generic/413 | 25 ++++++++++++++++++++++++-
>  tests/xfs/260     | 25 ++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/413 b/tests/generic/413
> index a1cc514..55a871f 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -34,6 +34,11 @@ _cleanup()
>  {
>  	cd /
>  	rm -f $tmp.*
> +	_check_scratch_fs
> +	# umount and restore SCRATCH_DEV to original mode
> +	_scratch_unmount
> +	$NDCTL_PROG create-namespace -f -e $scns -m $scmode \
> +	  > /dev/null 2>&1

If we are running on a system where the PMEM namespace was created with the
memmap kernel command line parameter (which is how I usually test), we don't
want to do any reconfig (our namespaces are already in "memory" mode), and
indeed the NDCTL and JSON commands will fail.  Really we can even run the test
without requiring these guys to be there.

We need to detect this situation, and only do NDCTL & JSON commands if we're
running against PMEM that came from an NFIT.

Perhaps it's as easy as just grepping for "memmap" in /proc/cmdline?  IMO we
don't need to worry too much about people running with both an memmap command
line *and* a valid NFIT...

This comment applies to patches 2 and 3 in this series.
