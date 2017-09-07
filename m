Received: from mx1.redhat.com ([209.132.183.28]:56792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753312AbdIGHp7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 03:45:59 -0400
Date: Thu, 7 Sep 2017 15:45:57 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 09/13] fstests: add support for working with
 dm-log-writes target
Message-ID: <20170907074557.GL8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-10-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504638680-25682-10-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 05, 2017 at 10:11:16PM +0300, Amir Goldstein wrote:
> Cherry-picked the relevant common bits from commit 70d41e17164b
> in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
> Quoting from Josef's commit message:
> 
>   This patch adds the supporting code for using the dm-log-writes
>   target.  The dmlogwrites code is similar to the dmflakey code, it just
>   gives us functions to build and tear down a dm-log-writes target.  We
>   add a new LOGWRITES_DEV variable to take in the device we will use as
>   the log and add checks for that.
> 
> [Amir:]
> - Removed unneeded _test_falloc_support
> - Moved _require_log_writes to dmlogwrites
> - Document _require_log_writes
> - Address review comments by Eryu Guan
> 
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  README                       |  2 +
>  common/dmlogwrites           | 94 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/requirement-checking.txt | 20 ++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 common/dmlogwrites
> 
> diff --git a/README b/README
> index 9456fa7..4963d28 100644
> --- a/README
> +++ b/README
> @@ -91,6 +91,8 @@ Preparing system for tests:
>               - set TEST_XFS_SCRUB=1 to have _check_xfs_filesystem run
>                 xfs_scrub -vd to scrub the filesystem metadata online before
>                 unmounting to run the offline check.
> +             - setenv LOGWRITES_DEV to a block device to use for power fail
> +               testing.
>  
>          - or add a case to the switch in common/config assigning
>            these variables based on the hostname of your test
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> new file mode 100644
> index 0000000..592b047
> --- /dev/null
> +++ b/common/dmlogwrites
> @@ -0,0 +1,94 @@
> +##/bin/bash
> +#
> +# Copyright (c) 2015 Facebook, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +#
> +# common functions for setting up and tearing down a dm log-writes device
> +
> +echo $MOUNT_OPTIONS | grep -q dax
> +if [ $? -eq 0 ]; then
> +	_notrun "Cannot run tests with DAX on dmerror devices"
> +fi

Sorry, I just realized that we can take use of
_exclude_scratch_mount_option helper to do this, and I think we can move
the check inside _require_log_writes() too.

> +
> +_require_log_writes()
> +{
> +	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
> +		_notrun "This test requires a valid \$LOGWRITES_DEV"
> +
> +	_require_dm_target log-writes
> +	_require_test_program "log-writes/replay-log"
> +}

Otherwise this looks good to me.

Thanks,
Eryu
