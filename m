Received: from mx1.redhat.com ([209.132.183.28]:41484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbHZGcg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 26 Aug 2015 02:32:36 -0400
Date: Wed, 26 Aug 2015 14:32:31 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] busybox compat: use stat -c instead of stat --format
Message-ID: <20150826063231.GR17933@dhcp-13-216.nay.redhat.com>
References: <1440497203.29614.1.camel@ari-macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440497203.29614.1.camel@ari-macbook>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 25, 2015 at 01:06:43PM +0300, Ari Sundholm wrote:
> From: Ari Sundholm <ari@tuxera.com>
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/generic/040 |    4 ++--
>  tests/generic/041 |    2 +-
>  tests/generic/104 |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/040 b/tests/generic/040
> index c841fbc..b44a433 100755
> --- a/tests/generic/040
> +++ b/tests/generic/040
> @@ -122,9 +122,9 @@ _mount_flakey
>  # The fstests framework automatically calls fsck after a test is run, so we
>  # don't need to call fsck explicitly here.
>  
> -echo "Link count before rm foo_link_*: $(stat --format=%h $SCRATCH_MNT/foo)"
> +echo "Link count before rm foo_link_*: $(stat -c %h $SCRATCH_MNT/foo)"
>  rm -f $SCRATCH_MNT/foo_link_*
> -echo "Link count after rm foo_link_*: $(stat --format=%h $SCRATCH_MNT/foo)"
> +echo "Link count after rm foo_link_*: $(stat -c %h $SCRATCH_MNT/foo)"
>  cat $SCRATCH_MNT/foo
>  
>  status=0
> diff --git a/tests/generic/041 b/tests/generic/041
> index f38b662..50fb26f 100755
> --- a/tests/generic/041
> +++ b/tests/generic/041
> @@ -116,7 +116,7 @@ _mount_flakey
>  # the hard links and read the file's data. This is just to verify we don't
>  # get stale file handle errors (due to dangling directory index entries that
>  # point to inodes that no longer exist).
> -echo "Link count: $(stat --format=%h $SCRATCH_MNT/foo)"
> +echo "Link count: $(stat -c %h $SCRATCH_MNT/foo)"
>  [ -f $SCRATCH_MNT/foo ] || echo "Link foo is missing"
>  for ((i = 1; i <= 3003; i++)); do
>  	name=foo_link_`printf "%04d" $i`
> diff --git a/tests/generic/104 b/tests/generic/104
> index eeb7363..fef3583 100755
> --- a/tests/generic/104
> +++ b/tests/generic/104
> @@ -81,8 +81,8 @@ _load_flakey_table $FLAKEY_ALLOW_WRITES
>  _mount_flakey
>  
>  # Now verify both our files have a link count of 2.
> -echo "Link count for file foo: $(stat --format=%h $SCRATCH_MNT/testdir/foo)"
> -echo "Link count for file bar: $(stat --format=%h $SCRATCH_MNT/testdir/bar)"
> +echo "Link count for file foo: $(stat -c %h $SCRATCH_MNT/testdir/foo)"
> +echo "Link count for file bar: $(stat -c %h $SCRATCH_MNT/testdir/bar)"
>  
>  # We should be able to remove all the links of our files in testdir, and after
>  # that the parent directory should become empty and therefore possible to
> -- 
> 1.7.10.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
