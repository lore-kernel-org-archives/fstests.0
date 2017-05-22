Received: from mx1.redhat.com ([209.132.183.28]:47412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934046AbdEVOry (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 May 2017 10:47:54 -0400
Date: Mon, 22 May 2017 22:47:49 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] Drop _require_fssum
Message-ID: <20170522144749.GU7250@eguan.usersys.redhat.com>
References: <20170522010528.23463-1-tytso@mit.edu>
 <20170522010528.23463-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522010528.23463-2-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 21, 2017 at 09:05:28PM -0400, Theodore Ts'o wrote:
> Now that fssum is built unconditionally, we no longer need
> _require_fssum.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc       | 6 ------
>  tests/btrfs/007 | 1 -
>  tests/btrfs/016 | 1 -
>  tests/btrfs/030 | 1 -
>  tests/btrfs/038 | 1 -
>  tests/btrfs/039 | 1 -
>  tests/btrfs/040 | 1 -
>  tests/btrfs/043 | 1 -
>  tests/btrfs/044 | 1 -
>  tests/btrfs/045 | 1 -
>  tests/btrfs/046 | 1 -
>  tests/btrfs/050 | 1 -
>  tests/btrfs/051 | 1 -
>  tests/btrfs/053 | 1 -
>  tests/btrfs/077 | 1 -
>  tests/btrfs/083 | 1 -
>  tests/btrfs/084 | 1 -
>  tests/btrfs/087 | 1 -
>  tests/btrfs/092 | 1 -
>  tests/btrfs/127 | 1 -
>  tests/btrfs/128 | 1 -
>  tests/btrfs/129 | 1 -
>  tests/btrfs/133 | 1 -
>  tests/btrfs/134 | 1 -
>  tests/btrfs/135 | 1 -
>  25 files changed, 30 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 65886886..796f60e7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3164,12 +3164,6 @@ _require_ugid_map()
>  	fi
>  }
>  
> -_require_fssum()
> -{
> -	FSSUM_PROG=$here/src/fssum
> -	[ -x $FSSUM_PROG ] || _notrun "fssum not built"
> -}
> -

I think this is still needed. It has FSSUM_PROG definition (otherwise
all these btrfs tests failed due to unable to find $FSSUM_PROG), and we
do check for existence of binary files in src, even the file is built
unconditionally on make. They can be removed accidently or one may
forget to build a newly added test.

Thanks,
Eryu
