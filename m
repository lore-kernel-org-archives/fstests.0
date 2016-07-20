Received: from mx1.redhat.com ([209.132.183.28]:34675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbcGTEis (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 00:38:48 -0400
Date: Wed, 20 Jul 2016 12:38:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/071: require falloc -k
Message-ID: <20160720043846.GS27776@eguan.usersys.redhat.com>
References: <1468829204-24593-1-git-send-email-hch@lst.de>
 <20160718084714.GD27776@eguan.usersys.redhat.com>
 <20160719041718.GA17223@lst.de>
 <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 11:49:57PM -0700, Eric Sandeen wrote:
> 
> 
> On 7/18/16 9:17 PM, Christoph Hellwig wrote:
> > On Mon, Jul 18, 2016 at 04:47:14PM +0800, Eryu Guan wrote:
> >> This stops generic/071 from running no matter what filesystem it's
> >> testing, this is because _require_xfs_io_command only checks whether
> >> xfs_io knows the option (-k) by searching it in help message, not really
> >> running it, i.e.
> > 
> > Well, we can at least add the documentation as that would be useful
> > on it's own.  I'll look into a patch.
> > 
> >> Perhaps we should update _require_xfs_io_command to actually run the
> >> command with the provided additional option?
> > 
> > I'll have to look at the archives, but I remember we had a reason for
> > this way of probing for feature support.
> 
> Some tests actually do run xfs_io on a real file, but we probably
> don't want to go that way.
> 
> The test for finding it in help output seems way too specific,
> 
> _require_xfs_io_command "pwrite" "-Z"
> 
> fails as well because it doesn't hit the specific format in
> the grep.

Zorro's commit a6f6e594f74a ("common/rc: teach _require_xfs_io_command
accept multi-parameters") addressed this issue, but it requires
something like "_require_xfs_io_command pwrite -Z N" to match the help
message.

> 
> What if we loosen up the test; is this too loose? (look for param
> preceded by whitespace or square bracket)
> 
> diff --git a/common/rc b/common/rc
> index 6add69e..0eef3d5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1907,7 +1907,7 @@ _require_xfs_io_command()
>  		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
>  
>  	test -z "$param" && return
> -	$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
> +	$XFS_IO_PROG -c "help $command" | egrep -qw "[ \[]$param" || \
>  		_notrun "xfs_io $command doesn't support $param"
>  }

This looks better to me, at least better than current code :)

Thanks,
Eryu
