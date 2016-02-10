Received: from mx1.redhat.com ([209.132.183.28]:58591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbcBJJHX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 04:07:23 -0500
Date: Wed, 10 Feb 2016 17:07:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 11/12] xfstests: add executable permission to tests
Message-ID: <20160210090721.GV11419@eguan.usersys.redhat.com>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-12-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-12-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:50:00PM -0500, Theodore Ts'o wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I noticed that there're more tests have the wrong mode

tests/xfs/140
tests/btrfs/104
tests/btrfs/026
tests/btrfs/114
tests/generic/061
tests/generic/103
tests/generic/063
tests/generic/094
tests/generic/058
tests/generic/060
tests/generic/092

I think they can be updated in one patch.

Thanks,
Eryu

> ---
>  tests/generic/058 | 0
>  tests/generic/060 | 0
>  tests/generic/061 | 0
>  tests/generic/063 | 0
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/generic/058
>  mode change 100644 => 100755 tests/generic/060
>  mode change 100644 => 100755 tests/generic/061
>  mode change 100644 => 100755 tests/generic/063
> 
> diff --git a/tests/generic/058 b/tests/generic/058
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/060 b/tests/generic/060
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/061 b/tests/generic/061
> old mode 100644
> new mode 100755
> diff --git a/tests/generic/063 b/tests/generic/063
> old mode 100644
> new mode 100755
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
