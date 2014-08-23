Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45985 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaHWL4L (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 23 Aug 2014 07:56:11 -0400
Date: Sat, 23 Aug 2014 04:56:06 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] common: add cifs support
Message-ID: <20140823115606.GA29808@infradead.org>
References: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
 <1408781763-30127-2-git-send-email-pshilovsky@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408781763-30127-2-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 23, 2014 at 12:16:02PM +0400, Pavel Shilovsky wrote:
> Pass -cifs argument from command line to enable cifs testing.

Looks mostly fine, but a few nitpicks below:

>  _mount_opts()
>  {
> +
>  	case $FSTYP in

Remove this spurious new empty line, please.

> -	echo $TEST_DEV | grep -q ":" > /dev/null 2>&1
> +	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
>  	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
> -		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a NFS filesystem"
> +		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a NFS or CIFS filesystem"
>  		exit 1
>  	fi

I'd just generalize this to ".. is not a block device or network
filesystem"

> -	echo $SCRATCH_DEV | grep -q ":" > /dev/null 2>&1
> +	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
>  	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
> -		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a NFS filesystem"
> +		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a NFS or CIFS filesystem"
>  		exit 1
>  	fi

Same here.

>  
>  # make sure we have a standard umask
> @@ -148,6 +150,11 @@ _test_options()
>      type=$1
>      TEST_OPTIONS=""
>  
> +    if [ "$FSTYP" = "cifs" ]; then
> +        TEST_OPTIONS="$MOUNT_OPTIONS"
> +        return
> +    fi

What's this for?  This doesn't really make sense to me as this function adds
mkfs/mount options to the already normally specified ones.

> +	cifs)
> +		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ];
> +		then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ];
> +		then
> +		     _notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;

Please put the then on the same line as the if for new code.

> diff --git a/tests/generic/013 b/tests/generic/013
> index 93d9904..ae57c67 100755
> --- a/tests/generic/013
> +++ b/tests/generic/013
> @@ -35,7 +35,12 @@ _cleanup()
>  {
>      cd /
>      # we might get here with a RO FS
> -    mount -o remount,rw $TEST_DEV >/dev/null 2>&1
> +    REMOUNT_OPTIONS="remount,rw"
> +    if [ "$FSTYP" = "cifs" ];
> +    then
> +        REMOUNT_OPTIONS="$REMOUNT_OPTIONS,$MOUNT_OPTIONS"
> +    fi
> +    mount -o $REMOUNT_OPTIONS $TEST_DEV >/dev/null 2>&1

This looks wrong and will need an explanation.

