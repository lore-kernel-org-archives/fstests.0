Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbbB0LK2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 06:10:28 -0500
Date: Fri, 27 Feb 2015 12:10:20 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH] generic/065: fsync file 'hello' before checking its
 content
In-Reply-To: <1425033696-14119-1-git-send-email-fdmanana@suse.com>
Message-ID: <alpine.LFD.2.00.1502271209450.2188@localhost.localdomain>
References: <1425033696-14119-1-git-send-email-fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@suse.com>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, 27 Feb 2015, Filipe Manana wrote:

> Date: Fri, 27 Feb 2015 10:41:36 +0000
> From: Filipe Manana <fdmanana@suse.com>
> To: fstests@vger.kernel.org
> Cc: Filipe Manana <fdmanana@suse.com>, Lukas Czerner <lczerner@redhat.com>,
>     Jaegeuk Kim <jaegeuk@kernel.org>, Eric Sandeen <sandeen@redhat.com>
> Subject: [PATCH] generic/065: fsync file 'hello' before checking its content
> 
> Explicitly fsync the file named 'hello' before checking its content.
> This way there's only one expected result for all filesystems.

Looks good.

Thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/065     | 28 +++++++++-------------------
>  tests/generic/065.out |  5 ++++-
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/generic/065 b/tests/generic/065
> index b5a296d..739a4d5 100755
> --- a/tests/generic/065
> +++ b/tests/generic/065
> @@ -96,6 +96,11 @@ touch $SCRATCH_MNT/mydir/x/y/z/qwerty
>  # Now fsync only our top directory.
>  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/mydir
>  
> +# And fsync now our new file named 'hello', just to verify later that it has
> +# the expected content and that the previous fsync on the directory 'mydir' had
> +# no bad influence on this fsync.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/hello
> +
>  # Simulate a crash/power loss.
>  _load_flakey_table $FLAKEY_DROP_WRITES
>  _unmount_flakey
> @@ -131,25 +136,10 @@ rm -f $SCRATCH_MNT/foo
>  [ -f $SCRATCH_MNT/mydir/x/y/z/qwerty ] || \
>  	echo "File mydir/x/y/z/qwerty is missing"
>  
> -digest_ok=no
> -hello_digest=$(md5sum $SCRATCH_MNT/hello | cut -d ' ' -f 1)
> -
> -case "$FSTYP" in
> -ext3)
> -	# a 64Kb file, with all bytes having the value 0xff
> -	[ $hello_digest == "ecb99e6ffea7be1e5419350f725da86b" ] && digest_ok=yes
> -	;;
> -*)
> -	# an empty file
> -	[ $hello_digest == "d41d8cd98f00b204e9800998ecf8427e" ] && digest_ok=yes
> -	;;
> -esac
> -
> -if [ $digest_ok == "yes" ]; then
> -	echo "file 'hello' has expected size and content"
> -else
> -	echo "file 'hello' has unexpected size or content"
> -fi
> +# We expect our file here to have a size of 64Kb and all the bytes having the
> +# value 0xff.
> +echo "file 'hello' content after log replay:"
> +od -t x1 $SCRATCH_MNT/hello
>  
>  # Now remove all files/links, under our test directory 'mydir', and verify we
>  # can remove all the directories.
> diff --git a/tests/generic/065.out b/tests/generic/065.out
> index ad376b3..6d394b0 100644
> --- a/tests/generic/065.out
> +++ b/tests/generic/065.out
> @@ -8,4 +8,7 @@ File 'foo' content after log replay:
>  *
>  0020000
>  file 'foo' link count after log replay: 5
> -file 'hello' has expected size and content
> +file 'hello' content after log replay:
> +0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +*
> +0200000
> 
