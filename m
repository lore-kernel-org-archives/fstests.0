Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbbB0Le0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 06:34:26 -0500
Date: Fri, 27 Feb 2015 12:34:09 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 2/2] generic/066: add _require_metadata_replay
In-Reply-To: <1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
Message-ID: <alpine.LFD.2.00.1502271056110.2188@localhost.localdomain>
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org> <1425000227-69601-2-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@suse.com>, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, 26 Feb 2015, Jaegeuk Kim wrote:

> Date: Thu, 26 Feb 2015 17:23:47 -0800
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Dave Chinner <david@fromorbit.com>
> Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
>     Jaegeuk Kim <jaegeuk@kernel.org>, Filipe Manana <fdmanana@suse.com>,
>     Eric Sandeen <sandeen@redhat.com>
> Subject: [PATCH 2/2] generic/066: add _require_metadata_replay
> 
> This patch adds _require_metadata_replay to detect whether or not filesystem
> supports metadata replay.
> 
> This should be used when:
> 
> 1. create file A
> 2. write file A
> 3. fsync file A
> 
> 4. write file A
> 
> 5. create file B
> 6. fsync file B
> 7. crash!
> 
> In this case, if filesystem supports metadata_replay, file A's data written
> by #4 should be recovered.

What ? No it should not! file A was never fsync after the last
write, so there is no guarantee that we'll have the new content.
"Metadata replay" suggests that we only replay metadata, not data
and that's what file systems usually do with they journals, cows,
and so on...

But this test is not about writing to a file, it's about changing
file xattr. And while extended attributes are metadata, they are
_not_ file system metadata and as such I think it can be very well
treated as data. Hence explicit fsync is needed to make sure it's
written to the disk.

Now let's look at the test itself:


	echo "hello world!" >> $SCRATCH_MNT/foobar
	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
	$SETFATTR_PROG -x user.attr1 $SCRATCH_MNT/foobar
	ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
	touch $SCRATCH_MNT/qwerty
	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty

	_crash_and_mount

	# Now only the xattr with name user.attr3 should be set in our file.
	echo "xattr names and values after second fsync log replay:"
	$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar |
	_filter_scratch

No it should not have only attr3 because $SCRATCH_MNT/foobar was
never fsynced after attr3 removal. If the internal design of the
file system accidentally synces unrelated xattrs on unrelated fsync,
than that's fine, but that's not what we need to test for at all
because it might not be guaranteed by all the file systems. So I
think this last part of the test is rather pointless. So I think
this patch is not needed as well.

Or am I missing something Filipe ?

Thanks!
-Lukas

> Otherwise, file A is recovered to #3.


> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/rc         | 18 ++++++++++++++++++
>  tests/generic/066 |  2 +-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 1ed9df5..e6e8d1f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2372,6 +2372,24 @@ _require_metadata_journaling()
>  	esac
>  }
>  
> +# Does this filesystem support metadata replay?
> +# Filesystem is able to recover metadata which were not written by fsync
> +# exlicitly. But another fsync'ed metadata should be followed by them.
> +_require_metadata_replay()
> +{
> +	_require_metadata_journaling $1
> +
> +	case "$FSTYP" in
> +	f2fs)
> +		# f2fs supports metadata_journaling, but does not recover any
> +		# intermediate metadata which was not fsync'ed explicitly.
> +		_notrun "$FSTYP does not support metadata replay"
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
>  # Does fiemap support?
>  _require_fiemap()
>  {
> diff --git a/tests/generic/066 b/tests/generic/066
> index cb36506..3fefda4 100755
> --- a/tests/generic/066
> +++ b/tests/generic/066
> @@ -61,7 +61,7 @@ _need_to_be_root
>  _require_scratch
>  _require_dm_flakey
>  _require_attrs
> -_require_metadata_journaling $SCRATCH_DEV
> +_require_metadata_replay $SCRATCH_DEV
>  
>  _crash_and_mount()
>  {
> 
